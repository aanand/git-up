git-up(1) -- fetch and rebase all locally-tracked remote branches
=================================================================

SYNOPSIS
--------

`git pull` has two problems:

* It merges upstream changes by default, when it's really more polite to [rebase over them](http://www.gitready.com/advanced/2009/02/11/pull-with-rebase.html), unless your collaborators enjoy a commit graph that looks like bedhead.
* It only updates the branch you're currently on, which means `git push` will shout at you for being behind on branches you don't particularly care about right now.

Solve them once and for all.

INSTALL
-------

    $ gem install git-up

Windows support is predictably absent. Try the [Python port](https://github.com/msiemens/PyGitUp), which was started for that reason.

USE
---

![$ git up](http://dl.dropbox.com/u/166030/git-up/screenshot.png)

ALTHOUGH
--------

`git-up` might mess up your branches, or set your chest hair on fire, or be racist to your cat, I don't know. It works for me.

DIFFICULTIES
------------

### Windows
Windows support is an ongoing pain. Have a look at [this ticket](https://github.com/aanand/git-up/issues/34) if you really need it, or if you're bored.

### spawn.rb:187:in `_pspawn': Invalid command name (ArgumentError)

If you're using RVM and you get this error, [read this](https://github.com/aanand/git-up/blob/master/RVM.md).

CONFIGURATION
-------------

`git-up` has a few configuration options, which use git's configuration system. Each can be set either globally or per-project. To set an option globally, append the `--global` flag to `git config`, which you can run anywhere:

    git config --global git-up.bundler.check true

To set it within a project, run the command inside that project's directory and omit the `--global` flag:

    cd myproject
    git config git-up.bundler.check true

### git-up.bundler.check [true|false]

Default: **false**. If **true**, git-up will check your app for any new bundled gems and suggest a `bundle install` if necessary.

### git-up.bundler.autoinstall [true|false]

Default: **false**. If **true**, and if `git-up.bundler.check` is also set to **true**, git-up will run `bundle install` for you if it finds missing gems.

### git-up.fetch.prune [true|false]

Default: **true**. Append the `--prune` flag when running `git fetch`, if your git version supports it (1.6.6 or greater), telling it to [remove any remote tracking branches which no longer exist on the remote](http://linux.die.net/man/1/git-fetch).

### git-up.fetch.all [true|false]

Default: **false**. Normally, git-up will only fetch remotes for which there is at least one local tracking branch. Setting this option to **true** will make git-up always fetch from all remotes, which is useful if e.g. you use a remote to push to your CI system but never check those branches out.

### git-up.rebase.arguments [string]

Default: **unset**. Additional arguments to pass to `git rebase`. For example, setting this to `--preserve-merges` will recreate your merge commits in the rebased branch.

### git-up.rebase.auto [true|false]

Default: **true**. If this option is set to **false**, git-up will not rebase branches for you. Instead, it will print a message saying they are diverged and let you handle rebasing them later. This can be useful if you have a lot of in-progress work that you don't want to deal with at once, but still want to update other branches.

### git-up.rebase.log-hook "COMMAND"

Default: **unset**. Runs **COMMAND** every time a branch is rebased or fast-forwarded, with the old head as **$1** and the new head as **$2**. This can be used to view logs or diffs of incoming changes. For example: `'echo "changes on $1:"; git log --oneline --decorate $1..$2'`
