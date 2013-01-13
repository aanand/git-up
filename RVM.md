Known RVM issues
================

Under RVM some users have [reported](https://github.com/aanand/git-up/issues/32) that running `git-up` works fine, but
running `git up` results in one of many issues, the most common being:

    spawn.rb:187:in `_pspawn': Invalid command name (ArgumentError)

cause
-----

The underlying cause is a combination of the way RVM sets the correct
ruby interpreter in the environment, and the way git interprets and
executes `git up`.

When you run `git [some command]` git will first look internally to see
if it can fulfil the command, then it will attempt to "shell out" and run
whatever `git-[some command]` executable it can find in your $PATH.

When git "shells out" all of the environmental variables will be
exposed, and it will be able to find our `git-up` executable in the $PATH.
However because of the way RVM magically sets your ruby interpreter,
when `git-up` is ran `ruby` still points to the non-RVM system default.

workaround
----------

To fix this we need to make sure that RVM gets to do it's business
before `git-up` is ran.

RVM provides a handy way of doing this called "wrappers", so let's
generate a wrapper for git-up like so:

    rvm wrapper [ruby-version]@[gemset-name] --no-prefix git-up

Next we need to make sure that git finds our wrapper first, to do this
we can make use of the `/usr/libexec/git-core` directory that git uses
for some of it's own commands.

    sudo ln -s $HOME/.rvm/bin/git-up /usr/libexec/git-core/git-up

Finally we need to modify our wrapper to prevent bundler issues when we
are working on ruby projects, so open that file in your favourite
editor, find this line:

    exec git-up "$@"

and change it to:

    ruby `which git-up` "$@"

This may seem strange, but it bypasses `ruby_noexec_wrapper` which
may cause issues if you are working in a project with a Gemfile.
