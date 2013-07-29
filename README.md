dotfiles
========

Dotfile version control and organization made easy.

## install

Run this:

```sh
git clone https://github.com/eyuelt/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/setup
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/setup`.

## components

There are a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/setup`.

## thanks

I initially tried forking [Zach Holman](http://github.com/holman)'s 
[dotfiles](http://github.com/holman/dotfiles) project and using that as my own,
but after spending some time attempting to remove what I didn't need and adapt it
for my uses, I figured that it would be easier to start my own dotfiles project,
which I could then modify by picking and choosing individual things from others'
dotfiles projects. This way, I would actually know everything that's going on in my
project and would be sure to only add topics that I need and functions or aliases
that I actually use frequently. I liked his project a lot though, so I mimicked the
structure of his project and borrowed heavily from it (including much of the text
of this readme). Also, you should check out his
[awesome post](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)
on dotfiles projects.
