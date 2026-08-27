# Windows Variables
export MSYS_NO_PATHCONV := "1"

# Variables
PELICAN := "pelican"
PELICANOPTS := ""
INPUTDIR := "content"
OUTPUTDIR := "output"
PUBLISHDIR := "docs"
CONFFILE := "pelicanconf.py"
PUBLISHCONF := "publishconf.py"
CNAME := "noelmiller.dev"

help:
    @echo "Justfile for a pelican Web site and podman commands"
    @echo ""
    @echo "Usage (Outside the Container):"
    @echo "  just build           Build a dev container"
    @echo "  just clean           Remove generated files"
    @echo "  just post            Run container to create a post"
    @echo "  just run             Run container with devserver"
    @echo "  just resume          Export the resume page to a PDF via pandoc"
    @echo ""
    @echo "Usage (Inside the Container):"
    @echo "  just create-post     Create new post with template"
    @echo "  just devserver       Serve/regenerate site"
    @echo ""

build:
    podman build -t noelmiller.dev:latest .

build-docker:
    docker build -f Containerfile -t noelmiller.dev:latest .

clean:
    [ ! -d "{{OUTPUTDIR}}" ] || rm -rf "{{OUTPUTDIR}}"

post:
    podman run --rm -it --volume "$(pwd):/app:Z" -p 8000:8000 noelmiller.dev:latest create-post

post-docker:
    docker run --rm -it --volume "$(pwd):/app" -p 8000:8000 noelmiller.dev:latest create-post

run:
    -podman run --init --rm -it --volume "$(pwd):/app:Z" -p 8000:8000 noelmiller.dev:latest devserver

run-docker:
    docker run --init --rm -it --volume "$(pwd):/app" -p 8000:8000 noelmiller.dev:latest devserver

create-post:
    python create_post.py

resume:
    read -p "Phone number: " phone; sed -e '1d' -e 's/<!--//' -e 's/-->//' -e "s/\[Insert Phone Number Here\]/$phone/" content/pages/resume.md | pandoc --from markdown --template=templates/resume.latex --pdf-engine=pdflatex -o resume.pdf

devserver:
    "{{PELICAN}}" -lr "{{INPUTDIR}}" -o "{{OUTPUTDIR}}" -s "{{CONFFILE}}" -b 0.0.0.0 {{PELICANOPTS}}
    echo "{{CNAME}}" > "{{OUTPUTDIR}}/CNAME"
