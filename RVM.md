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
before `git-up` is run.

RVM provides a handy way of doing this called "wrappers". We need to know
which gemset we're using in rvm. If we're just using a default, just run
`rvm list gemsets` to check. The default is shown with `=>`.

Once we know our gemset, we can generate a wrapper for git-up:

    rvm wrapper [ruby-version@gemset-name] --no-prefix git-up

It'll usually respond, telling us the rvm bin folder where the wrapper has been
saved: something like `$HOME/.rvm/bin` or `/usr/local/rvm/bin`.

Next we need to make sure that git finds _our wrapper first_. To do this
we can make use of the `/usr/libexec/git-core` directory that git uses
for some of its own commands. Substitute the rvm bin folder from the previous
command here:

    sudo ln -s [rvm-bin-folder]/git-up /usr/libexec/git-core/git-up

Finally we need to modify our wrapper to prevent bundler issues when we
are working on ruby projects. So, in your favourite editor, open the `git-up`
file from the rvm bin directory. Find this line:

    exec git-up "$@"

and change it to:

    ruby `which git-up` "$@"

This may seem strange, but it bypasses `ruby_noexec_wrapper` which
may cause issues if you are working in a project with a Gemfile.
