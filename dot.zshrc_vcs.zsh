autoload -U colors; colors

function git-prompt {
  local branchname branch st remote pushed upstream
  branchname=`git symbolic-ref --short HEAD 2> /dev/null`
  if [ -z $branchname ]; then
    return
  fi
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch="%{${fg[green]}%}($branchname)%{$reset_color%}"
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    branch="%{${fg[yellow]}%}($branchname)%{$reset_color%}"
  else
    branch="%{${fg[red]}%}($branchname)%{$reset_color%}"
  fi

  remote=`git config branch.${branchname}.remote 2> /dev/null`

  if [ -z $remote ]; then
    pushed=''
  else
    upstream="${remote}/${branchname}"
    if [[ -z `git log ${upstream}..${branchname}` ]]; then
      pushed="%{${fg[green]}%}[up]%{$reset_color%}"
    else
      pushed="%{${fg[red]}%}[up]%{$reset_color%}"
    fi
  fi

  echo "$branch$pushed"
}

function svn-prompt {
  local name st color stt
  st=`LANG=C svn status --depth immediates 2>&1`
  if [[ $st =~ "is not" ]]; then
    return
  fi
  stt=""
  if [[ -n `echo $st | grep "^\s\?[CADM]"` ]];then
    color=${fg_bold[red]}
    if [[ -n `echo $st | grep "^C"` ]];then
      stt="${stt}C"
    fi
    if [[ -n `echo $st | grep "^A"` ]];then
      stt="${stt}A"
    fi
    if [[ -n `echo $st | grep "^D"` ]];then
      stt="${stt}D"
    fi
    if [[ -n `echo $st | grep "^\s\?M"` ]];then
      stt="${stt}M"
    fi
  elif [[ -n `echo $st | grep "^\?"` ]];then
    color=${fg[yellow]}
    stt="?"
  else
    color=${fg[green]}
    stt="N"
  fi
  echo "(%{$color%}$stt%{$reset_color%})"
}

function vcs-prompt {
  git-prompt
	svn-prompt
}

RPROMPT='`vcs-prompt`%{$fg_bold[cyan]%}[%~]%{$reset_color%}'
setopt prompt_subst
