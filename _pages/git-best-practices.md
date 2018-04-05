---
permalink: /git-best-practices
title: Git Best Practices
---

# Git Best Practices

The basis for conducting government projects in digital space was described in the [Service Manual](https://www.gov.uk/service-manual). Contributing to HMCTS projects is important. This is an addendum to [Maintaining version control in coding](https://www.gov.uk/service-manual/technology/maintaining-version-control-in-coding) from .

[Git style guide](https://github.com/alphagov/styleguides/blob/master/git.md) contains bare set of principles. At HMCTS we propose:

 1. Everyone should be able to build and test projects hosted on GitHub.
 1. Project issues should have corresponding issues within GitHub.
 1. Do not mess with the repository and conduct experiments in your own fork.
 1. Speed-up understanding and simplify the message, a.k.a. "explain it like I'm 5"
    1. Craft your commits as life would depend on it.
    1. Describe situational context in the pull request.
    1. Make every change obvious.
    1. Do not force me to click into _Yet Another Ticketing System_.
    1. It is better to write simple code than use smart-looking,language-oriented quirky code.


# Prepare your environment

Although trivial, it is still quite often an ignored aspect of development. Configuring your workspace is like preparing pens, brushes, paints, and other tools before their use. New GUI for `git` is your tool and you are responsible for the results it produces.


## Identify yourself

Real names and working email addresses are preferred over nicknames and non-working spam-traps.
Especially when it comes to coding in the open, anyone should be able to reach you in regards
to your contribution.

In vanilla `git` it takes two commands:

```bash
git config --global user.name "John Doe"
git config --global user.email john.doe@hmcts.net
```

Git uses plain text for storing its configuration, so the file can be edited directly with text
editor of choice.

```bash
vim ~/.gitconfig
```


## Use shortcuts and aliases

Save time and increase productivity by typing less. Git is extensible enough to let you define your own set of aliased sub-commands.

In this example the main `.gitconfig` refers to two other files: `.git-commit-template` and `.gitignore-global` that are in the same directory, which usually is `$HOME`.

`.git-commit-template` guides preferred narration style for a commit message and can be enabled by running:

```bash
git config --global commit.template ~/.git-commit-template
```

Common paths can be ignored across all the projects:

```bash
git config --global core.excludesfile ~/.gitignore-global
```

For more information see `git help config`.


### Sample files

**`.gitconfig`**:
```text
[user]
	name = John Doe
	email = john.doe@hmcts.net
[core]
	editor = vim
[alias]
	git = !exec git
	br = branch
	bv = branch -vv
	ce = commit --no-edit
	ci = commit --verbose
	fix = commit --fixup
	fixa = commit -a --fixup
	amend = commit --verbose --amend
	refresh = commit --amend --no-edit -u
	co = checkout
	d = diff
	ds = diff --cached
	dw = diff --word-diff
	dsw = diff --staged --word-diff
	f = fetch
	fa = fetch --all
	fav = fetch --all -v
	m = merge
	mi = merge --no-ff --no-edit
	log = log --use-mailmap
	lop = log -p --ignore-all-space --ignore-blank-lines
	hist = log --pretty=format:'%C(reverse blue white)%h%C(reset)%C(auto)%d%C(reset) %C(blue)%ar%C(reset) %s %C(cyan)%aN' --graph --full-history
	topo = !git hist --all --simplify-by-decoration
	rellog = log --pretty=tformat:'%h %d %s'
	prmsg = log --reverse --pretty=tformat:"## %s ##%n%n%b"
	r = reset
	rh = reset --hard
	rhu = reset --hard @{u}
	st = status
	s = status -s
	type = cat-file -t
	dump = cat-file -p
	hide = update-index --assume-unchanged
	unhide = update-index --no-assume-unchanged
	please = push --force-with-lease
	k = !gitk --all
[push]
	default = simple
[rerere]
	enabled = true
[merge]
	log = true
	summary = true
[apply]
	whitespace = warn
[mergetool]
	keepBackup = false
[commit]
	template = /home/john/.git-commit-template
[rebase]
	autoSquash = true
```

**`.git-commit-template`**:
```text
# If applied, this commit will...

# Explain why this change is being made

# Provide links to any relevant tickets, articles or other resources
```

**`.gitignore-global`**:
```text
*~
*.iml
.svn/
.DS_Store
.idea/
nbproject/
.gradletasknamecache
```


# Making a change

Feature branch should tell a story with its commits. This helps understanding how the application was developed, what decisions were made, and what was the context for the situation at hand. Whether it is for future self, or on-boarding new developers, everyone benefits from clean commit history.

Find preferred style of narration and start making small and obvious changes, like re-wrapping inconsistent code indentation, or reformatting style; the simpler, the better. The aim is to create a stream of logically coherent commits where each of them introduces an atomic change. This is well described in [Making a sausage](,
) technique which later is used in [post-production editing](https://sethrobertson.github.io/GitPostProduction/gpp.html).

A commit message should answers following questions:

- What is being changed? (very briefly, in the subject line; technical details can be read from its
  patch)
- Why the change is needed? What are the benefits? How does it help in achieving the goal?
- What are the potential flaws, improvements, etc. What to look out for?

These simple rules help improving quality of development progress.

More to read:
* [Why we code in the open](https://mojdigital.blog.gov.uk/2017/02/21/why-we-code-in-the-open/)