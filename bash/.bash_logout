#
# ~/.bash_logout
#
source ${HOME}/local/bin/logout-git-pushes.sh
kill $SSH_AGENT_PID
exit
shutdown -h now
