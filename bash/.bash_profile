source ${HOME}/local/bin/startup-gpg-agent.sh

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

source ${HOME}/local/bin/startup-git-pulls.sh
source ${HOME}/local/bin/startup-check-arch-updates.sh

if [ "$(tty)" = "/dev/tty1" ]; then
	startx
fi
