# Installing

Clone this repository somewhere, i.e.:

    git clone git@github.com/acornejo/dotfiles.git $HOME/.dotfiles

Next, run the included `dot-restore` to create all appropriate links:

    $HOME/.dotfiles/bin/dot-restore

Enjoy!

# Uninstalling

First, clean-up the links using the included `dot-clean` script:

    $HOME/.dotfiles/bin/dot-clean

Next, delete the repository

    rm -fr $HOME/.dotfiles

# Customizing

Fork this repository and add your own dotfiles!

To prevent certain files (like this readme) from being linked, list them
inside an `.exclude` file inside the containing directory.

Create a '.linkdir' file inside any directory that you wish to to link,
instead of just linking the individual files it contains (default
behavior).

Use '.hook-pre' and '.hook-post' scripts to perform any additional
configuration steps you want to perform before restoring a folder from
your dotfiles.

# Per-Host or Per-OS customization

Use directories named host-${HOST} and uname-${OS} inside your dotfiles
directory, with the corresponding `.hook-pre` and `.hook-post` scripts
if needed. For example, create a directory called `host-macbookalex` to
store all dotfiles specific to a machine named `macbookalex`, and create
a directory called `uname-Linux` to store all dotfiles specific to Linux
machines.
