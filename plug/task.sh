export TASKDATA="$XDG_DATA_HOME"/task
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc

__ta () {
  task add $(task context show|cut -d \' -f 4) $@
}

alias tl='__ta priority:L'
alias tm='__ta priority:M'
alias to='__ta priority:H'
alias td='task done'
alias ts='task summary'
alias tc='task context'
