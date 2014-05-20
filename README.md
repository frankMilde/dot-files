dot-files
=========
This repository includes mostly various *rc and conf files of my linux/dwm
set up. Just clone this repo and run 

    $ cd dot-files
		$ stow bash
		$ stow vim

to install, for example, the bashrcs and .vim files into your 

For more on how to handle your dot files with [GNU
stow](http://www.gnu.org/software/stow/) see this nice
[article](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

The `stow` technique will not work with dwm and dmenu. These have to be put
into `~/local/stow/dmenu-4.0` and `~local/stow/dwm-6.0/` where `stow` has to be run from
there.

To-Dos
======
It would be more concise to have a repo of my `~/local/` folder up on github
as well to address the dwm issue.
