# The HMCTS Way

<a href="https://gitpod.io/#https://github.com/hmcts/hmcts.github.io">
  <img
    src="https://img.shields.io/badge/Contribute%20with-Gitpod-908a85?logo=gitpod"
    alt="Contribute with Gitpod"
  />
</a>

## Getting started

There are two ways to run this site locally: Gitpod (no setup required) or a local installation.

### Option 1: Gitpod (recommended)

Gitpod gives you a ready-to-use dev environment in your browser with no local setup needed.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/hmcts/hmcts.github.io)

### Option 2: Local installation

**Prerequisites:** macOS ships with an old system Ruby that won't work here. You need Ruby 3.3.0, managed via [rbenv].

**1. Install rbenv and Ruby 3.3.0**

```bash
brew install rbenv ruby-build
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc
rbenv install 3.3.0
rbenv local 3.3.0
```

**2. Install dependencies**

```bash
gem install bundler
bundle install
```

## Making changes

Edit the source files in the `source` folder. Each section of the site is an `.html.md.erb` file.

### Adding content to an existing page

Content is split across multiple markdown files and manually included in `source/index.html.md.erb`. To add a new file (e.g. `source/documentation/agile/scrum.md`), add this line in the appropriate place in that file:

```
<%= partial 'documentation/agile/scrum' %>
```

### Adding a new page

Create a file with a `.html.md` extension anywhere in the `source` directory. For example, `source/about.html.md` will be served at <http://localhost:4567/about.html>.

## Preview

Start a local server that auto-reloads when you save changes:

```bash
bundle exec middleman server
```

Then open <http://localhost:4567> in your browser.

## Build

To generate static HTML files (e.g. to publish without a build script):

```bash
bundle exec middleman build
```

This creates a `build` folder containing the compiled HTML and assets.

## Publishing

```bash
bundle exec rake publish
```

[rbenv]: https://github.com/rbenv/rbenv
