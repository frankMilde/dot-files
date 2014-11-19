# set ENV to a file invoked each time sh is started for interactive use.
ENV=$HOME/.shrc; export ENV
BASH_ENV=$HOME/.shrc; export BASH_ENV

if [ -f ~/.shrc ]; then
    source ~/.shrc
fi

#   Paths {{{
PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/opt/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/opt/bin:/usr/X11R6/bin:/usr/glocal/bin:$GOROOT/bin:$GOPATH/bin:$HOME/local/bin:
#$HOME/documents/shell_skript/:$HOME/local/go/bin/:$HOME/local/bin/

# set PATH so it includes user's private bin if it exists
#if [ -d ~/bin ] ; then
#    PATH=~/bin:"${PATH}"
#fi

export PATH

export GOPATH=$HOME/go
#export CPP_INCLUDE_PATH=$HOME/bin/boost_1_51_0_withStatic
#export LD_LIBRARY_PATH=$HOME/bin/boost_1_51_0_withStatic/stage/lib:$LDLIBRARY_PATH
#Latest:
#export CPP_INCLUDE_PATH=$HOME/bin/boost_1_51_0/include
#export LD_LIBRARY_PATH=$HOME/bin/boost_1_51_0/lib:$LDLIBRARY_PATH

#export CPP_INCLUDE_PATH=$HOME/bin/boost_1_54_0/include
#export CPP_INCLUDE_PATH=$HOME/bin/boost_1_54_0/boost
#export LD_LIBRARY_PATH=$HOME/bin/boost_1_54_0/libs:$LDLIBRARY_PATH
#}}}

#   locales and standart editors {{{
BLOCKSIZE=K;    export BLOCKSIZE
EDITOR=vim;     export EDITOR
PAGER=more;     export PAGER

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

GPG_TTY=$(tty)
export GPG_TTY
#}}}

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Learn something new, each time you open a shell
#echo "Did you know that:"; whatis $(ls /bin | shuf | head -1)

#   customize the prompt {{{
# http://linuxconfig.org/Bash_prompt_basics

NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)

function red(){
	echo -e $RED$*$NORMAL
}
function redBold(){
	echo -e $RED$BOLD$*$NORMAL
}
function green() {
    echo -e "$GREEN$*$NORMAL"
}
function yellowBold() {
    echo -e "$YELLOW$BOLD$*$NORMAL"
}

function display() {
	RC=$?
	user=`whoami`; 
	machine=`hostname`; 
	if [[ $machine != arch || $user != frank ]]; then 
		echo; 
		echo \
			"${GREEN}${BOLD}${user}${NORMAL}${BOLD}@${NORMAL}${RED}${BOLD}${machine}${NORMAL}";
	else 
		echo; 
	fi;

	if [[ ${RC} != 0 ]]; then 
		redBold "ERROR ${RC}"; 
	fi
}

PROMPT_COMMAND="display"
export PS1="\[$YELLOW$BOLD\][\!]\[$NORMAL\]/\W:\$"
#}}}

#   history {{{
unset HISTFILESIZE
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="&:[ ]*:exit:?:??:vi"
shopt -s histappend #append to history
#}}}

# use vi style on command line {{{
# for more see
# http://www.catonmat.net/blog/bash-vi-editing-mode-cheat-sheet/
# http://www.catonmat.net/blog/the-definitive-guide-to-bash-command-line-history/
set -o vi
#}}}

# raise an error if you try to overwrite an existing file by output {{{
# redirection
#$ echo two > afile
#bash: afile: cannot overwrite existing file
#}}}

# force the redirection: $ echo two >| afile {{{
#http://askubuntu.com/questions/236478/how-do-i-make-bash-warn-me-when-overwriting-an-existing-file
set -o noclobber
#}}}

# get remote backspace working in vim according to {{{
# http://blog.feradz.com/index.php/2011/06/20/backspace-in-vim-does-not-work/
# http://hints.macworld.com/article.php?story=20040930002324870
stty erase "^?"
#}}}

#---------------------------------------------------------------------------
#   Alias
#---------------------------------------------------------------------------
#   bash command alias {{{
alias c=clear
alias e=exit
alias h='history'
alias bc='bc -l'
alias df='df -H'
alias du='du -ch'
alias ps='ps auxww|less'
alias psf='ps|grep frank'
alias ls='ls -1 --group-directories-first --color'
alias ll='ls -l --group-directories-first --color'
alias l.='ls -d .* --group-directories-first --color'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias pgrep='pgrep --color=auto'
alias mkdir='mkdir -pv'
alias keyinput='od -c'
#}}}

#   bash programs {{{
alias vi='vim'
alias vie='vim -c :e.'
alias qstat='qstat -c | grep -A 2 frank'
alias quota="quota -s 2>/dev/null|awk 'NR>3 {print \"usage    limit    free\"; print \$1/1000 \"G  \" \$2/1000 \"G  \" (\$2-\$1)/1000 \"G\"}'"
alias git='hub'
alias stow='stow -v'
alias sgit=smartgithg
alias tastatur='setxkbmap -model pc104 -layout us'
alias untarz="tar xfvz"
alias tarz="tar cfvz"
alias untar="tar xfv"
alias tarArchive="tar cfv"
alias vnc='vncserver -geometry 1280x1024'
alias vncbig='vncserver -geometry 1920x1200'
alias killvnc='vncserver -kill :1'
#}}}

#   wrapper {{{
alias rm='rm-wrapper.sh' 
alias mc='. ~/local/bin/mc-wrapper.sh'
alias zippen="zippen.sh"
alias open="open.sh"
alias thunderbird=use-thunderbird-with-gpg-agent.sh
#alias make=colormake
alias gpgusb='gpg --no-default-keyring --secret-keyring /media/sdb1/.gnupg/secring.gpg --keyring /home/frank/.gnupg/pubring.gpg '
alias gpgusb-signwithTU='gpg --no-default-keyring --secret-keyring /media/sdb1/.gnupg/secring.gpg --keyring /home/frank/.gnupg/pubring.gpg --local-user 0xBC851EED5F288073 '
alias gpgusb-signwithGMX='gpg --no-default-keyring --secret-keyring /media/sdb1/.gnupg/secring.gpg --keyring /home/frank/.gnupg/pubring.gpg --local-user 0x983A8842AB1B2ADD '
#}}}

#   files {{{
alias important='vim ~/documents/important.txt'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias screenrc='vim ~/.screenrc'
alias xsession='vim ~/.xsession'
alias xinit='vim ~/.xinitrc'
#}}}

#   todo app {{{
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
alias t="todo -d ~/local/stow/todo.txt_cli-2.10/todo.cfg"
#}}}

#   functions {{{
function scr {
    if screen -ls | grep -q Main; then
        screen -xr Main
    else
        screen -S Main
    fi
}
function usb() {
	pmount -e /dev/sdb > /dev/null 2>&1
	if [[ "$?" -ne 0 ]]; then
		pmount -e /dev/sdb1
		cd /media/sdb1
	else
		cd /media/sdb
	fi
}
function nousb() {
	cd 
	pumount /media/sdb > /dev/null 2>&1
	if [[ "$?" -ne 0 ]]; then
		pumount /media/sdb1
	fi
}
function cdd(){
	local dir="$(/bin/ls | grep $1)"
	cd "${dir}"
}
function v(){
	local file="$(/bin/ls | grep $1)"
	vi "${file}"
}
function pass() {
	usb
	v xk
}
#}}}
