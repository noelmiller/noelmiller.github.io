Title: How to Create a Blog!
Date: 2023-09-21
Category: coding
Tags: python, css, html
Description: Creating a Blog and Custom Theme Using Pelican

---

### TLDR
[Pelican](https://getpelican.com/) is a static site generator (built on python) that I have seen primarily used to create blogs. It is the project I used to build this site. Source code for this site is available [here](https://github.com/noelmiller/noelmiller.github.io).

[TOC]

---

### What is [Pelican](https://getpelican.com/)?
*Pelican is a static site generator that requires no database or server-side logic.* I definitely think that it lives up to it's description from the creators! It is fairly easy to use and their [documentation](https://docs.getpelican.com/en/latest/) is solid! 

Pelican will ingest either reStructuredText or Markdown and create HTML output in a directory you specify! This is great for having an easy way to write blog posts without having to do all of the HTML markup by hand. It will output this HTML with styling through a theme you have constructed (or you can use an existing theme someone else has created). This helps with keeping your blog designed consistently in every post or page. 

There are other competing static site generators (see [here](https://jamstack.org/generators/) for a nice list of them), but Pelican seemed the most straight forward to me! It is also built on python which is the programming language I am the most familiar working with!

### Installing Pelican
Here is an excellent [article](https://docs.getpelican.com/en/latest/install.html) on how to install pelican. My recommendation would be to use a virtualenv to manage your pelican site.

### [Pelican](https://getpelican.com/) Site Architecture
In this section, I will explain the basic architecture of pelican using my site. Here is an excellent [article](https://docs.getpelican.com/en/latest/install.html#installing-pelican) from the documentation on how to install pelican as well as some basic information on the [site architecture](https://docs.getpelican.com/en/latest/install.html#kickstart-your-site) when you use the `pelican-quickstart` command.

The code below is an example of what my folder layout looks like for my [site](https://github.com/noelmiller/noelmiller.github.io):
```shell
.
├── content
│   ├── images
│   ├── pages
│   │   ├── about.md
│   │   ├── contact.md
│   │   ├── music.md
│   │   └── projects.md
│   └── posts
│       └── how-to-create-a-blog.md
├── create_post.py
├── docs
│   ├── archives.html
│   ├── author
│   │   └── noel-miller.html
│   ├── authors.html
│   ├── categories.html
│   ├── category
│   │   └── programming.html
│   ├── CNAME
│   ├── feeds
│   │   ├── all.atom.xml
│   │   └── programming.atom.xml
│   ├── how-to-create-a-blog.html
│   ├── index.html
│   ├── pages
│   │   ├── about.html
│   │   ├── contact.html
│   │   ├── music.html
│   │   └── projects.html
│   ├── tag
│   │   ├── css.html
│   │   ├── html.html
│   │   └── python.html
│   ├── tags.html
│   └── theme
│       └── css
│           ├── custom.css
│           ├── pico.min.css
│           ├── pico.min.css.map
│           ├── postcss.config.js
│           └── pygments.css
├── Makefile
├── pelicanconf.py
├── publishconf.py
├── README.md
├── requirements.txt
├── templates
│   └── standard_post_template.md
└── theme
    ├── static
    │   └── css
    │       ├── custom.css
    │       ├── pico.min.css
    │       ├── pico.min.css.map
    │       ├── postcss.config.js
    │       └── pygments.css
    └── templates
        ├── archives.html
        ├── article.html
        ├── author.html
        ├── authors.html
        ├── base.html
        ├── categories.html
        ├── category.html
        ├── gosquared.html
        ├── index.html
        ├── page.html
        ├── pagination.html
        ├── period_archives.html
        ├── tag.html
        ├── tags.html
        └── translations.html
```

As you can see, there is a lot of files and directories and my site is very small at this point. I will go down the list of top level files and directories one by one to explain their purpose in the architecture of my site.

#### [content](https://github.com/noelmiller/noelmiller.github.io/tree/main/content)
The purpose of this directory is to store all of your static pages and posts for your site. These will all either be formatted in markdown or reStructuredText. These assets are processed by pelican when you publish your site or run your dev server instance. You will notice both the pages and posts have metadata at the top of the Markdown files. These are used by the processor to categorize and tag posts. I do not have search on my site, but it could be useful if you do want an internal search or categorizing posts in RSS feeds.
```shell
.
├── content
│   ├── images
│   ├── pages
│   │   ├── about.md
│   │   ├── contact.md
│   │   ├── music.md
│   │   └── projects.md
│   └── posts
│       └── how-to-create-a-blog.md
```
For more information, click [here](https://docs.getpelican.com/en/latest/content.html#writing-content) for documentation related to writing content.

#### [docs (or output)](https://github.com/noelmiller/noelmiller.github.io/tree/main/docs)
The docs directory is what I use as the output directory for my processed HTML. This is what the user actually sees when they visit my blog. The reason I call it docs as opposed to output is because that is the default directory that Github Pages uses for site assets. You can call this directory whatever you want, I just preferred the ease of use of GitHub Pages to get my blog published for free. One other useful thing to note is the CNAME file. If you want to have a custom domain for your Github pages, you need to have a plain text file called CNAME and the contents are the domain you wish to use. I won't go into detail for every single HTML file it generates, but what it does generate is managed by pelicanconf.py, publishconf.py, and your theme.
```shell
├── docs
│   ├── archives.html
│   ├── author
│   │   └── noel-miller.html
│   ├── authors.html
│   ├── categories.html
│   ├── category
│   │   └── programming.html
│   ├── CNAME
│   ├── feeds
│   │   ├── all.atom.xml
│   │   └── programming.atom.xml
│   ├── how-to-create-a-blog.html
│   ├── index.html
│   ├── pages
│   │   ├── about.html
│   │   ├── contact.html
│   │   ├── music.html
│   │   └── projects.html
│   ├── tag
│   │   ├── css.html
│   │   ├── html.html
│   │   └── python.html
│   ├── tags.html
│   └── theme
│       └── css
│           ├── custom.css
│           ├── pico.min.css
│           ├── pico.min.css.map
│           ├── postcss.config.js
│           └── pygments.css
```

#### [pelicanconf.py](https://github.com/noelmiller/noelmiller.github.io/blob/main/pelicanconf.py)
This file controls how pelican generates your static site. There are several useful items in here. I have kept mine pretty simple, but the main things here are PATH, DEFAULT_PAGINATION, THEME, and MARKDOWN. 

PATH controls where it looks for content to generate the site with. 

DEFAULT_PAGINATION controls how many articles will show up on a page before it will paginate. 

THEME is the path to your theme that you are using. 

MARKDOWN is a useful section to fill out if you want extended markdown support. In my blog, I wanted both Code Highlighting and a Table of Contents feature that can be generated inside of my articles.

Example from this blog:
```python
AUTHOR = 'Noel Miller'
SITENAME = 'noelmiller.dev'
SITEURL = ''

PATH = 'content'

TIMEZONE = 'America/Chicago'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

DEFAULT_PAGINATION = 10

THEME = "./theme"
# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

MARKDOWN = {
    'extension_configs': {
        'markdown.extensions.codehilite': {'css_class': 'highlight'},
        'markdown.extensions.toc': {'title': 'Table of Contents'},
        'markdown.extensions.extra': {},
        'markdown.extensions.meta': {},
    },
    'output_format': 'html5',
}
```
For more information on configuration settings, see this [article](https://docs.getpelican.com/en/latest/settings.html).

#### [publishconf.py](https://github.com/noelmiller/noelmiller.github.io/blob/main/publishconf.py)
Since I use a Makefile, I also take advantage of using a publishconf.py which will add specific settings for publishing the site. When I am developing, I see no benefit in generating my RSS Feeds each time I generate the site during testing. In production, I do want to offer RSS Feeds, so that information is updated in this configuration file. I also want to make sure my domain information is filled out in this file to have links properly configured.

Example from this blog:
```python
# This file is only used if you use `make publish` or
# explicitly specify it as your config file.

import os
import sys
sys.path.append(os.curdir)
from pelicanconf import *

# If your site is available via HTTPS, make sure SITEURL begins with https://
SITEURL = 'https://noelmiller.dev'
RELATIVE_URLS = False

FEED_ALL_ATOM = 'feeds/all.atom.xml'
CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'

DELETE_OUTPUT_DIRECTORY = True

# Following items are often useful when publishing

#DISQUS_SITENAME = ""
#GOOGLE_ANALYTICS = ""
```

#### [Makefile](https://github.com/noelmiller/noelmiller.github.io/blob/main/Makefile)
I was not familiar with the concept of Makefiles before using pelican. They have been around for a long time and are useful for doing laborious build processes for your applications. The Makefile in Pelican's case is a convenient wrapper around the pelican command.

I made some custom edits to my Makefile to have it generate a CNAME file on build so I don't need to worry about running a separate command to do that. It also defines variables that are easily changeable at the top of the file. Everything else in the file is generally what you get when you use the `pelican-quickstart` command.

Here is my Makefile:
```Makefile
PY?=
PELICAN?=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/docs
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

CNAME=noelmiller.dev


DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

SERVER ?= "0.0.0.0"

PORT ?= 0
ifneq ($(PORT), 0)
	PELICANOPTS += -p $(PORT)
endif


help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make regenerate                     regenerate files upon modification '
	@echo '   make publish                        generate using production settings '
	@echo '   make serve [PORT=8000]              serve site at http://localhost:8000'
	@echo '   make serve-global [SERVER=0.0.0.0]  serve (as root) to $(SERVER):80    '
	@echo '   make devserver [PORT=8000]          serve and regenerate together      '
	@echo '   make devserver-global               regenerate and serve on 0.0.0.0    '
	@echo '                                                                          '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html   '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                    '
	@echo '                                                                          '

html:
	"$(PELICAN)" "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(CONFFILE)" $(PELICANOPTS)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

clean:
	[ ! -d "$(OUTPUTDIR)" ] || rm -rf "$(OUTPUTDIR)"

regenerate:
	"$(PELICAN)" -r "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(CONFFILE)" $(PELICANOPTS)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

serve:
	"$(PELICAN)" -l "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(CONFFILE)" $(PELICANOPTS)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

serve-global:
	"$(PELICAN)" -l "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(CONFFILE)" $(PELICANOPTS) -b $(SERVER)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

devserver:
	"$(PELICAN)" -lr "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(CONFFILE)" $(PELICANOPTS)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

devserver-global:
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -b 0.0.0.0
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

publish:
	"$(PELICAN)" "$(INPUTDIR)" -o "$(OUTPUTDIR)" -s "$(PUBLISHCONF)" $(PELICANOPTS)
	echo $(CNAME) > "$(OUTPUTDIR)/CNAME"

.PHONY: html help clean regenerate serve serve-global devserver publish github
```
For more information on how to use the make command to serve or publish your site, see this [article](https://docs.getpelican.com/en/latest/publish.html#make). 


#### [theme](https://github.com/noelmiller/noelmiller.github.io/tree/main/theme)
The theme folder is how you define what each page looks like in your blog. The `static` directory is where you will put css, javascript, and images to be used by your theme. The `templates` directory is used for storing HMTL code for your site. These HTML pages use [jinja2](https://jinja.palletsprojects.com/en/3.1.x/) templating inside them to generate pages and posts from your `content` directory as well as using special variables that Pelican defines. 

The focus of a theme is to separate your content away from how things look visually. There are pre-built themes, but I decided to create my own using the [simple theme](https://github.com/getpelican/pelican/tree/master/pelican/themes/simple/templates) provided by Pelican and [Pico.css](https://picocss.com/) for styling. For more information on creating your own theme, go [here](https://docs.getpelican.com/en/latest/themes.html#creating-themes).

The one criticism I would give towards pelican is that there are not a lot of pre-built themes for it like there is for WordPress, Hugo, or other blogging platforms. 

Here is what my theme directory looks like:
```shell
└── theme
    ├── static
    │   └── css
    │       ├── custom.css
    │       ├── pico.min.css
    │       ├── pico.min.css.map
    │       ├── postcss.config.js
    │       └── pygments.css
    └── templates
        ├── archives.html
        ├── article.html
        ├── author.html
        ├── authors.html
        ├── base.html
        ├── categories.html
        ├── category.html
        ├── gosquared.html
        ├── index.html
        ├── page.html
        ├── pagination.html
        ├── period_archives.html
        ├── tag.html
        ├── tags.html
        └── translations.html
```

#### [requirements.txt](https://github.com/noelmiller/noelmiller.github.io/blob/main/requirements.txt) (recommended)
When working on my blog, I prefer to use a Python Virtual Environment to do all of my dependency handling. This will ensure I will not accidentally update a python package by mistake that my blog depends on. The requirements are pretty basic for pelican and when you do an installation, it will pull all the requirements it needs to run properly. For more information on virtual environments, see this [article](https://docs.python.org/3/library/venv.html).

#### [create_post.py](https://github.com/noelmiller/noelmiller.github.io/blob/main/create_post.py) (optional)
This is a custom script I wrote specifically for my site. It uses Jinja2 templating to create a new post from templates I've defined in the top-level templates directory. 

##### Dependencies
- [Jinja2](https://pypi.org/project/Jinja2/) - For doing the templating
- [python-slugify](https://pypi.org/project/python-slugify/) - For creating the markdown files based on their Title
- [inquirer](https://pypi.org/project/inquirer/) - For creating interactive questions

##### Usage
Once you have installed the dependencies, you can run it by doing `./create_post.py`. It will ask you a series of questions and then place the contents of your template in the `./contents/posts/` directory.

Here is the source code:
```python
#!/usr/bin/env python3

from jinja2 import Environment, FileSystemLoader
from datetime import datetime
import inquirer
from slugify import slugify

current_datetime = datetime.now()

date = current_datetime.strftime("%Y-%m-%d")

questions = [
    inquirer.Text("title", message="What is the name of the article?"),
    inquirer.Text("description", message="In summary, what is the article about?"),
    inquirer.List("category", message="What Category is the article?", choices=["Programming", "IT", "Music", "Gaming"]),
    inquirer.Text("tags", message="Please enter a comma separated list of tags")
]

answers = inquirer.prompt(questions)

environment = Environment(loader=FileSystemLoader("templates/"))
template = environment.get_template("standard_post_template.md")

content = template.render(
    title=answers['title'],
    date=date,
    category=answers['category'],
    tags=answers['tags'],
    description=answers['description']
)
filepath = "./content/posts/" + slugify(answers['title']) + ".md"
with open(filepath, mode="w", encoding="utf-8") as post:
    post.write(content)
    print(f"Created {filepath}" )
```

#### [templates](https://github.com/noelmiller/noelmiller.github.io/tree/main/templates) (optional)
This is the directory that the `create_post.py` script uses. These templates are written in Jinja2 format.

#### [README.md](https://github.com/noelmiller/noelmiller.github.io/blob/main/README.md) (optional)
This is a basic README file that I wrote up for my site. Useful for knowing what the project is.

### Development Environment
For developing my blog, I use Fedora 38 Workstation on my desktop, a text editor (VIM), a Virtual Python Environment, and the command `make devserver-global` to start up an auto refreshing instance of my blog on port 8000. This allows me to make edits to the site, save my file, and refresh the page to see changes instantly reflected on the site. No need to stop and restart the server while developing. 

`make devserver-global` also allows traffic to connect to my desktop computer on the local network (so long as I open a firewall rule for it). This makes it convenient to develop from my iPad if I am not at my desk. All I do is connect to my desktop over SSH and navigate to my desktop's `ipaddress:8000` to access the site remotely. 

### Writing Posts
For writing posts, I create a post from my post template using `create_post.py` and start writing in Markdown. The convenient thing about my `create_post.py` script is that it creates all the frontmatter data so I can focus on writing my content. 

Since all of my content is source controlled by git, I create a separate branch called `drafts` where all of my drafts are put until I am ready to publish them to my site. I will explain this further when I talk about how I configured Github Pages to publish my site.

### Configuring Github Pages
To configure Github pages, it is very simple. 

1. Create a repository on Github
2. Go to the settings of the repository
3. Under code and automation, select Pages
4. Under build and deployment, select Deploy from a branch
5. For your branch, you will want to select main (or whatever branch you want to use) and select the `/docs` directory (or whatever your output directory is)
6. For custom domain, fill out a custom domain (you will want to create a CNAME record in your public DNS provider)
7. Enforce HTTPS or don't!

For more information on Github pages, see [here](https://docs.github.com/en/pages).


### Publishing Posts
To conclude, publishing posts is very simple. 

#### 3 step process
1. Run `make publish` to generate the production version of your site. 
2. Add everything to a git commit and commit it to your `drafts` branch. 
3. Merge your drafts branch into your `main` branch which will then run a git action to confirm that the site will built properly. If it builds, it will start serving it on Github Pages immediately after it builds!
