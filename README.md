git-up
======

So `git pull` merges by default, when it [should really rebase](http://www.gitready.com/advanced/2009/02/11/pull-with-rebase.html). You can [ask it to rebase instead](http://d.strelau.net/post/47338904/git-pull-rebase-by-default), but it still won't touch anything other than the currently checked-out branch. If you're tracking a bunch of remote branches, you'll get non-fast-forward complaints next time you push.

Solve it once and for all:

![gem install git-up](http://dl.dropbox.com/u/166030/nonsense/git-up.png)

although
--------

`git-up` might mess up your branches, or set your chest hair on fire, or be racist to your cat, I don't know. It works for me.

