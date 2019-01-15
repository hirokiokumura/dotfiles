# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u

autoload -Uz colors; colors
#lsコマンドの色を変更
export LSCOLORS=gxfxcxdxbxegedabagacad

HISTFILE=~/.zsh_history #履歴ファイルの設定
HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
SAVEHIST=1000000 # ファイルに何件保存するか
setopt no_beep
setopt auto_cd # ディレクトリ移動（cd）を便利にする
setopt auto_pushd # $ cd - でTabを押すと、ディレクトリの履歴が見れる
setopt extended_history # 実行時間とかも保存する
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない 
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # historyコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開する
setopt inc_append_history # 履歴をインクリメンタルに追加

if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

# [【GCE】【gcloud】いま、どのプロジェクトなのかbashのプロンプトに表示する - cameong’s blog](http://cameong.hatenablog.com/entry/2016/07/29/123037)
function gcp_info {
    if [ -f ~/.config/gcloud/active_config ]; then
        cat  ~/.config/gcloud/active_config
    else
        echo "--"
    fi
}

# [superbrothers/zsh-kubectl-prompt: Display information about the kubectl current context and namespace in zsh prompt.](https://github.com/superbrothers/zsh-kubectl-prompt)
source /usr/local/etc/zsh-kubectl-prompt/kubectl.zsh
RPROMPT='%{$fg[green]%}(gcloud:$(gcp_info))%{$fg[yellow]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH

# peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# ghq+peco
function ghql() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
      pwd
    fi
  fi
}

zle -N ghql
bindkey '^g' ghql
