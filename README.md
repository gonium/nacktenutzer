nacktenutzer
============

Getting started
---------------

The site is generated using [Middleman](www.middlemanapp.com). The easiest (and
cleanest) way of getting everything is using RVM and bundler:

    $ rvm use 2.0.0@nacktenutzer --create
    $ gem install bundler
    $ bundle install

This step can take some time. Then, create a "nutzer.yml" configuration
file in the "data" directory - you can simply copy the
nutzer.yml_template and edit it. Afterwards, you should be able to build
and serve the site locally using

    $ middleman server

The site will then be rendered. You can access it on
[````http://localhost:4567````](http://localhost:4567).

Notes
-----

See http://middlemanapp.com/advanced/custom/
