git-up
======

`git pull` has two problems:

* It merges upstream changes by default, when it's really more polite to [rebase over them](http://www.gitready.com/advanced/2009/02/11/pull-with-rebase.html), unless your collaborators enjoy a commit graph that looks like bedhead.
* It only updates the branch you're currently on, which means `git push` will shout at you for being behind on branches you don't particularly care about right now.

Solve them once and for all.

install
-------

    $ gem install git-up

use
---

![$ git up](http://dl.dropbox.com/u/166030/git-up/screenshot.png)

although
--------

`git-up` might mess up your branches, or set your chest hair on fire, or be racist to your cat, I don't know. It works for me.

difficulties
------------

### Windows
Windows support is an ongoing pain. Have a look at [this ticket](https://github.com/aanand/git-up/issues/34) if you really need it, or if you're bored.

### spawn.rb:187:in `_pspawn': Invalid command name (ArgumentError)

If you're using RVM and you get this error, [read this](https://github.com/aanand/git-up/blob/master/RVM.md).

configuration
-------------

`git-up` has a few configuration options, which use git's configuration system. Each can be set either globally or per-project. To set an option globally, append the `--global` flag to `git config`, which you can run anywhere:

    git config --global git-up.bundler.check true

To set it within a project, run the command inside that project's directory and omit the `--global` flag:

    cd myproject
    git config git-up.bundler.check true

### `git-up.bundler.check [true|false]`

If set to `true`, `git-up` will check your app for any new bundled gems and suggest a `bundle install` if necessary.

It slows the process down slightly, and therefore defaults to `false`. 

### `git-up.bundler.autoinstall [true|false]`

If you're even lazier, you can tell `git-up` to run `bundle install` for you if it finds missing gems. Make sure `git-up.bundler.check` is also set to `true` or it won't do anything.

### `git-up.bundler.local [true|false]`

If you've `bundle package`-ed your project gems, you can tell `git-up` to run `bundle install --local` for you if it finds missing gems. Much faster than just a plain old `bundle install`. Make sure `git-up.bundler.autoinstall` is also set to `true` or it won't do anything.

### `git-up.bundler.rbenv [true|false]`

If you have rbenv installed, you can tell `git-up` to run `rbenv rehash` for you after it installs your gems so any binaries will be available right away. Make sure `git-up.bundler.autoinstall` is also set to `true` or it won't do anything.

### `git-up.fetch.prune [true|false]`

By default, `git-up` will append the `--prune` flag to the `git fetch` command if your git version supports it (1.6.6 or greater), telling it to [remove any remote tracking branches which no longer exist on the remote](http://linux.die.net/man/1/git-fetch). Set this option to `false` to disable it.

### `git-up.fetch.all [true|false]`

Normally, `git-up` will only fetch remotes for which there is at least one local tracking branch. Setting this option will it `git-up` always fetch from all remotes, which is useful if e.g. you use a remote to push to your CI system but never check those branches out.

### `git-up.rebase.arguments [string]`

If this option is set, its contents will be used by `git-up` as additional arguments when it calls `git rebase`. For example, setting this to `--preserve-merges` will recreate your merge commits in the rebased branch.

### `git-up.rebase.auto [true|false]`

If this option is set to false, `git-up` will not rebase branches for you. Instead, it will print a message saying they are diverged and let you handle rebasing them later. This can be useful if you have a lot of in-progress work that you don't want to deal with at once, but still want to update other branches.

### `git-up.rebase.log-hook "COMMAND"`

Runs COMMAND every time a branch is rebased or fast-forwarded, with the old head as $1 and the new head as $2. This can be used to view logs or diffs of incoming changes. For example: `'echo "changes on $1:"; git log --oneline --decorate $1..$2'`
