# Variables
PELICAN := "pelican"
PELICANOPTS := ""
BASEDIR := invocation_directory()
INPUTDIR := "{{BASEDIR}}/content"
OUTPUTDIR := "{{BASEDIR}}/output"
PUBLISHDIR := "{{BASEDIR}}/docs"
CONFFILE := "{{BASEDIR}}/pelicanconf.py"
PUBLISHCONF := "{{BASEDIR}}/publishconf.py"
CNAME := "noelmiller.dev"

help:
    @echo "Justfile for a pelican Web site and podman commands"
    @echo ""
    @echo "Usage (Outside the Container):"
    @echo "  just build           Build a dev container"
    @echo "  just clean           Remove generated files"
    @echo "  just post            Run container to create a post"
    @echo "  just run             Run container with devserver"
    @echo ""
    @echo "Usage (Inside the Container):"
    @echo "  just create-post     Create new post with template"
    @echo "  just devserver       Serve/regenerate site"
    @echo "  just publish-docs    Generate with production settings"
    @echo ""

build:
    podman build -t pelican:latest .

clean:
    [ ! -d "{{OUTPUTDIR}}" ] || rm -rf "{{OUTPUTDIR}}"

post:
    podman run --rm -it --volume .:/app:Z -p 8000:8000 pelican:latest create-post

run:
    podman run --rm -it --volume .:/app:Z -p 8000:8000 pelican:latest devserver

create-post:
    python create_post.py

devserver:
    "{{PELICAN}}" -lr "{{INPUTDIR}}" -o "{{OUTPUTDIR}}" -s "{{CONFFILE}}" -b 0.0.0.0 {{PELICANOPTS}}
    echo "{{CNAME}}" > "{{OUTPUTDIR}}/CNAME"

publish-docs:
    @echo "Placeholder for production publishing"