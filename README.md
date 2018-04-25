# Myst Language Website

This repository contains the source for the Myst programming language home page, available at https://myst-lang.org.


# Development

To run the site locally, simply start up a static webserver within the `public/` folder. My favorite is the ruby gem `asdf`:

```shell
$ gem install asdf # if you need to
$ cd public/
$ asdf
```

If you are making changes to the site, you'll need to be running `listen` (another Ruby gem). To help get set up, this project provides a `Gemfile` for Bundler.

```shell
$ gem install bundler # if you don't have bundler installed.
$ bundle # Install dependencies
$ ruby listener.rb # listen for changes
```

If you are making changes to the css (.styl files), you will need [Stylus](http://stylus-lang.com/)


The source for the website lives in the `src/` folder. This includes the source for the pages and other dynamic content that needs to be compiled. Static assets (images, etc.) are kept in the `public/` folder.
