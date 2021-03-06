nacktenutzer
============

Getting started
---------------

The site is generated using [Middleman](www.middlemanapp.com). The easiest (and
cleanest) way of getting everything is using RVM and bundler:

    // install RVM first
    $ rvm use 2.1.0@nacktenutzer --create
    $ gem install bundler
    $ bundle install

This step can take some time. Then, create a "nutzer.yml" configuration
file in the "data" directory - you can simply copy the
nutzer.yml_template and edit it. Afterwards, you should be able to build
and serve the site locally using

    $ middleman server

from within the "website" directory. The site will then be rendered. 
You can access it on
[````http://localhost:4567````](http://localhost:4567).

Deployment
----------

For deployment, you can build the website using 

    $ middleman build

This will create a "website/build" directory that contains all files. It
can be copied into an adequate web root directory and served by a
webserver. 

The whole thing is also automated in the provided Rakefile. You can run

    $ rake gen_deploy

to (re-)generate the whole site and copy it over to ````~/html````. A webserver 
can serve this directory in a production setting.

On FreeBSD 10, you need to install GCC in order to be able to install
the libv8 gem. I did approximately this:

    $ pkg install gmake gcc
    $ export CXX=/usr/local/bin/g++47 
    $ export LD_FLAGS=-Wl,-rpath=/usr/local/lib/gcc47
    $ bundle install
