#------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias dc='cd'

case "${OSTYPE}" in
darwin*)
  alias ls="ls -FG"
  ;;
linux*)
  alias ls='ls --show-control-char -F --color'
  ;;
esac

#------------------------------------------------------------------------
# コマンドプロンプトの設定
#------------------------------------------------------------------------

PROMPT=$'\n%{\e[32m%}%n@%m:\n%{\e[m%}$ '
RPROMPT=$'%{\e[1;36m%}[%~]%{\e[m%}'
PROMPT2="%_%%% "

#------------------------------------------------------------------------
# コマンド履歴関係
#------------------------------------------------------------------------

# 履歴検索時にカーソル位置を行末に
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
 
HISTFILE=~/.zsh_history # 履歴を保存するファイル
HISTSIZE=100000         # メモリ内の履歴の数
SAVEHIST=100000         # HISTFILEに保存する履歴の数

# root作業時は履歴を残さない
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

setopt extended_history # 履歴ファイルに時刻も記録
setopt hist_ignore_dups # 直前と同じコマンドは履歴に追加しない
setopt share_history    # 履歴を複数の端末で共有
setopt nolistbeep       # 補完候補表示時にビープ音を鳴らさない
setopt append_history   # 複数の端末利用時の履歴を上書きでなく追加

#------------------------------------------------------------------------
# その他の設定
#------------------------------------------------------------------------

export LANG=ja_JP.UTF-8 # 言語設定を日本語UTF-8に

# 補完候補をメニューから選択できるように
zstyle ':completion:*:default' menu select=1

# cd -<TAB>でディレクトリスタックを補完候補に 
DIRSTACKSIZE=100
setopt AUTO_PUSHD
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# コマンド特有の補完を有効に
autoload -U compinit && compinit

# ワイルドカードがマッチしていなくてもコマンドを実行(scp用)
unsetopt NOMATCH 
EDITOR=vim

# 拡張子判別実行
alias -s rb=ruby
alias -s py=python
alias -s pdf=open
alias -s bib=open

# タブの設定
set tabstop=2
set shiftwidth=2
set expandtab

#------------------------------------------------------------------------
# その他の設定の読み込み
#------------------------------------------------------------------------

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine # ローカル設定
[ -f ~/.zshrc_vcs.zsh ] && source ~/.zshrc_vcs.zsh
