#. ~/.shrc
#BLOCKSIZE=K;    export BLOCKSIZE
#EDITOR=vi;      export EDITOR
#PAGER=more;     export PAGER
#
## set ENV to a file invoked each time sh is started for interactive use.
#ENV=$HOME/.shrc; export ENV
#BASH_ENV=$HOME/.shrc; export BASH_ENV
#
##if [ -f ~/.shrc ]; then
##    source ~/.shrc
##fi
#
#if [ -f ~/.bashrc ]; then
#    source ~/.bashrc
#fi
#
## remove /usr/games and /usr/X11R6/bin if you want
##PATH=/sbin:/usr/opt/bin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin:/usr/glocal/bin:/usr/kde/3.5/bin:~/local/dwm-5.7.2
#
##PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/opt/bin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/opt/bin:/usr/X11R6/bin:$HOME/bin:/usr/glocal/bin:~/downloads/mystuff/skype/skype-1.3.0.53:~/shell_skript:~/local/dwm-5.7.2
#
## set PATH so it includes user's private bin if it exists
##if [ -d ~/bin ] ; then
##    PATH=~/bin:"${PATH}"
##fi
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
#
#export PATH
#
## do the same with MANPATH
##if [ -d ~/man ]; then
##    MANPATH=~/man:"${MANPATH}"; export MANPATH
##fi

exec cd dot-files
exec git pull origin master

if [ "$?" = "0" ]; then
	exec startx &
else
	echo "Error in update... " 1>&2
	exec startx &
fi

cd dot-files
git push origin master


