
# Aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias dc='cd'

# Some shortcuts for different directory listings
alias ls='ls --show-control-char'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

PROMPT=$'\n%{\e[32m%}%n@%m:\n%{\e[m%}$ '
RPROMPT=$'%{\e[1;36m%}[%~]%{\e[m%}'
PROMPT2="%_%%% "

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
 
 
## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
EDITOR=vim

setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 
setopt nolistbeep
unsetopt NOMATCH

alias -s pdf=c

precmd() {
  echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
}

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
[ -f ~/.zshrc.vcs ] && source ~/.zshrc.vcs
