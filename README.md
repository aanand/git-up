git-up
======

So `git pull` merges by default, when it [should really rebase](http://www.gitready.com/advanced/2009/02/11/pull-with-rebase.html). You can [ask it to rebase instead](http://d.strelau.net/post/47338904/git-pull-rebase-by-default), but it still won't touch anything other than the currently checked-out branch. If you're tracking a bunch of remote branches, you'll get non-fast-forward complaints next time you push.

Solve it once and for all:

![gem install git-up](http://dl.dropbox.com/u/166030/nonsense/git-up.png)

although
--------

`git-up` might mess up your branches, or set your chest hair on fire, or be racist to your cat, I don't know. It works for me.

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

### `git-up.fetch.prune [true|false]`

By default, `git-up` will append the `--prune` flag to the `git fetch` command if your git version supports it (1.6.6 or greater), telling it to [remove any remote tracking branches which no longer exist on the remote](http://linux.die.net/man/1/git-fetch). Set this option to `false` to disable it.

### `git-up.fetch.all [true|false]`

Normally, `git-up` will only fetch remotes for which there is at least one local tracking branch. Setting this option will it `git-up` always fetch from all remotes, which is useful if e.g. you use a remote to push to your CI system but never check those branches out.

### `git-up.rebase.arguments [string]`

If this option is set, its contents will be used by `git-up` as additional arguments when it calls `git rebase`. For example, setting this to `--preserve-merges` will recreate your merge commits in the rebased branch.

### `git-up.rebase.log-hook "COMMAND"`

Runs COMMAND every time a branch is rebased or fast-forwarded, with the old head as $1 and the new head as $2. This can be used to view logs or diffs of incoming changes. For example: `'echo "changes on $1:"; git log --oneline --decorate $1..$2'`
