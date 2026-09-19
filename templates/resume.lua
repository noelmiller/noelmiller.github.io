-- Pandoc Lua filter for the resume PDF (used by `just resume` with templates/resume.latex).
--
-- content/pages/resume.md is written for the website, so its structure is plain
-- markdown. This filter recognises the patterns in it and swaps them for the layout
-- macros defined in resume.latex:
--
--   # Name / **Tagline** / contact | line         -> \resumeheader
--   ### Heading                                   -> \resumesection
--   #### Heading                                  -> \resumesubsection
--   **Job Title** / [Company](url) / dates        -> \resumeentry
--   "Some label:" paragraph before a bullet list  -> \resumelabel
--   #### Heading + bullet list                    -> two-column list
--   run of (#### Heading + Name|Proficiency table) -> three-column skills grid

if not FORMAT:match('latex') then
  return {}
end

local SKILL_COLUMNS = 3

local function raw(s)
  return pandoc.RawBlock('latex', s)
end

local function latex(inlines)
  local s = pandoc.write(pandoc.Pandoc({ pandoc.Plain(inlines) }), 'latex')
  return (s:gsub('%s+$', ''))
end

local function latex_blocks(blocks)
  local s = pandoc.write(pandoc.Pandoc(blocks), 'latex')
  return (s:gsub('%s+$', ''))
end

-- Para holding exactly one inline of the given type (e.g. a lone **bold** or [link]())
local function lone(block, inline_type)
  return block and block.t == 'Para' and #block.content == 1
    and block.content[1].t == inline_type
end

local function is_label(block, next_block)
  if not (block and block.t == 'Para' and next_block and next_block.t == 'BulletList') then
    return false
  end
  local last = block.content[#block.content]
  return last and last.t == 'Str' and last.text:sub(-1) == ':'
end

-- "August 2023 - Present" -> "August 2023 – Present"
local function en_dashes(inlines)
  return inlines:walk({
    Str = function(s)
      if s.text == '-' then return pandoc.Str('–') end
    end,
  })
end

-- Split "a | b | c" into a list of LaTeX strings
local function split_on_pipes(inlines)
  local items, current = {}, pandoc.Inlines({})
  local function flush()
    while #current > 0 and current[1].t == 'Space' do current:remove(1) end
    while #current > 0 and current[#current].t == 'Space' do current:remove(#current) end
    if #current > 0 then items[#items + 1] = latex(current) end
    current = pandoc.Inlines({})
  end
  for _, inline in ipairs(inlines) do
    if inline.t == 'Str' and inline.text == '|' then
      flush()
    else
      current:insert(inline)
    end
  end
  flush()
  return items
end

local function header_block(name, tagline, contact)
  local items = split_on_pipes(contact.content)
  local split = math.floor(#items / 2)
  local line1, line2 = {}, {}
  for i, item in ipairs(items) do
    if i <= split then line1[#line1 + 1] = item else line2[#line2 + 1] = item end
  end
  return raw(string.format('\\resumeheader{%s}{%s}{%s}{%s}',
    latex(name.content), latex(tagline.content[1].content),
    table.concat(line1, '\\contactsep '), table.concat(line2, '\\contactsep ')))
end

local function skill_group(heading, tbl)
  local simple = pandoc.utils.to_simple_table(tbl)
  local lines = { string.format('\\skillgroup{%s}', latex(heading.content)) }
  for _, row in ipairs(simple.rows) do
    lines[#lines + 1] = string.format('\\skillrow{%s}{%s}',
      latex_blocks(row[1]), latex_blocks(row[2] or {}))
  end
  return { height = #simple.rows + 2, body = table.concat(lines, '\n') }
end

-- Longest group first, each into the currently shortest column, so the columns balance
local function skills_grid(groups)
  table.sort(groups, function(a, b) return a.height > b.height end)
  local columns = {}
  for c = 1, SKILL_COLUMNS do columns[c] = { height = 0, parts = {} } end
  for _, group in ipairs(groups) do
    local target = columns[1]
    for _, column in ipairs(columns) do
      if column.height < target.height then target = column end
    end
    target.parts[#target.parts + 1] = group.body
    target.height = target.height + group.height
  end
  local out = { '\\begin{skillsgrid}' }
  for c, column in ipairs(columns) do
    out[#out + 1] = '\\begin{skillscolumn}'
    out[#out + 1] = table.concat(column.parts, '\n')
    out[#out + 1] = '\\end{skillscolumn}' .. (c < #columns and '\\hfill%' or '')
  end
  out[#out + 1] = '\\end{skillsgrid}'
  return raw(table.concat(out, '\n'))
end

-- First half of the items on the left, the rest on the right
local function two_column_list(list)
  local split = math.ceil(#list.content / 2)
  local left, right = {}, {}
  for i, item in ipairs(list.content) do
    if i <= split then left[#left + 1] = item else right[#right + 1] = item end
  end
  -- One raw block: a blank line between the two columns would stack them instead
  return raw(table.concat({
    '\\begin{listcolumnleft}', latex_blocks({ pandoc.BulletList(left) }), '\\end{listcolumnleft}%',
    '\\begin{listcolumnright}', latex_blocks({ pandoc.BulletList(right) }), '\\end{listcolumnright}',
  }, '\n'))
end

function Pandoc(doc)
  local blocks, out = doc.blocks, pandoc.Blocks({})
  local i = 1
  while i <= #blocks do
    local b, n1, n2 = blocks[i], blocks[i + 1], blocks[i + 2]

    if b.t == 'Header' and b.level == 1 and lone(n1, 'Strong') and n2 and n2.t == 'Para' then
      out:insert(header_block(b, n1, n2))
      i = i + 3

    elseif lone(b, 'Strong') and lone(n1, 'Link') and n2 and n2.t == 'Para' then
      out:insert(raw(string.format('\\resumeentry{%s}{%s}{%s}',
        latex(b.content[1].content), latex(n1.content), latex(en_dashes(n2.content)))))
      i = i + 3

    elseif b.t == 'Header' and b.level >= 4 and n1 and n1.t == 'Table' then
      local groups = {}
      while blocks[i] and blocks[i].t == 'Header' and blocks[i].level >= 4
        and blocks[i + 1] and blocks[i + 1].t == 'Table' do
        groups[#groups + 1] = skill_group(blocks[i], blocks[i + 1])
        i = i + 2
      end
      out:insert(skills_grid(groups))

    elseif b.t == 'Header' and b.level >= 4 and n1 and n1.t == 'BulletList' then
      out:insert(raw(string.format('\\resumesubsection{%s}', latex(b.content))))
      out:insert(two_column_list(n1))
      i = i + 2

    elseif b.t == 'Header' and b.level >= 4 then
      out:insert(raw(string.format('\\resumesubsection{%s}', latex(b.content))))
      i = i + 1

    elseif b.t == 'Header' then
      out:insert(raw(string.format('\\resumesection{%s}{%s}', latex(b.content), b.identifier)))
      i = i + 1

    elseif is_label(b, n1) then
      out:insert(raw(string.format('\\resumelabel{%s}', latex(b.content))))
      i = i + 1

    else
      out:insert(b)
      i = i + 1
    end
  end
  doc.blocks = out
  return doc
end
