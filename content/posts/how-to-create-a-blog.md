Title: How to Create a Blog!
Date: 2023-09-18
Category: Programming
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

### [Pelican](https://getpelican.com/) Site Architecture
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
├── output
│   ├── archives.html
│   ├── author
│   │   └── noel-miller.html
│   ├── authors.html
│   ├── categories.html
│   ├── category
│   │   └── programming.html
│   ├── creating-a-blog-and-custom-theme-using-pelican.html
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

