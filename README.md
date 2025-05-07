# Downed Allied Air Crew Database Austria



* data is fetched from https://github.com/acdh-oeaw/daacda-data
* build with [DSE-Static-Cookiecutter](https://github.com/acdh-oeaw/dse-static-cookiecutter)


## initial (one time) setup

* run `./shellscripts/dl_saxon.sh`
* run `./fetch_data.sh`
* run `ant`

## set up GitHub repo
* create a public, new, and empty (without README, .gitignore, license) GitHub repo https://github.com/acdh-oeaw/daacda-static 
* run `git init` in the root folder of your application daacda-static
* execute the commands described under `…or push an existing repository from the command line` in your new created GitHub repo https://github.com/acdh-oeaw/daacda-static

## start dev server

* `cd html/`
* `python -m http.server`
* go to [http://0.0.0.0:8000/](http://0.0.0.0:8000/)

## publish as GitHub Page

* go to https://https://github.com/acdh-oeaw/daacda-static/actions/workflows/build.yml
* click the `Run workflow` button


## dockerize your application

* To build the image run: `docker build -t daacda-static .`
* To run the container: `docker run -p 80:80 --rm --name daacda-static daacda-static`
* in case you want to password protect you server, create a `.htpasswd` file (e.g. https://htpasswdgenerator.de/) and modifiy `Dockerfile` to your needs; e.g. run `htpasswd -b -c .htpasswd admin mypassword`

### run image from GitHub Container Registry

`docker run -p 80:80 --rm --name daacda-static ghcr.io/acdh-oeaw/daacda-static:main`

### third-party libraries

the code for all third-party libraries used is included in the `html/vendor` folder, their respective licenses can be found either in a `LICENSE.txt` file or directly in the header of the `.js` file