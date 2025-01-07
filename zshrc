# uncomment this and last line for profiling
# zmodload zsh/zprof

fpath+=~/.zsh/functions

. ~/.zsh/functions/.bourne-apparix

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# same as bash when navigating words no the command line
autoload -U select-word-style
select-word-style bash

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

export VISUAL=nvim
export GIT_EDITOR=nvim
bindkey -e # to keep emacs keybindings on the command line

autoload edit-command-line; zle -N edit-command-line
bindkey "^X^E" edit-command-line

. ~/.zsh/aliases

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  fpath+=$(brew --prefix)/share/zsh/site-functions
fi

# turn on zsh extended glob 
setopt extended_glob

# The following lines were added by compinstall
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/Users/joao/.zshrc'

autoload -Uz compinit
# compinit
# segundo https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
# fica mais rápido porque só corre uma vez por dia
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# Outra versão:
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
  touch ~/.zcompdump
else
  compinit -C
fi
# end of lines added by compinstall

# add / to autocompletion of dirs. i.e ../
zstyle ':completion:*' special-dirs true

# Left side prompt
PROMPT='%T - [%1d] '
# Right side prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '(%F{green}%b%f) %r'
zstyle ':vcs_info:*' enable git

# search on up/down arrows
bindkey '^[[A' up-line-or-search # up arrow bindkey
bindkey '^[^[[A' up-history # up arrow + option bindkey
bindkey '^[[B' down-line-or-search # down arrow
bindkey '^[^[[B' down-history # down arrow + option bindkey

# better npm completion
. ~/.zsh/functions/zsh-better-npm-completion.plugin.zsh
compdef rtmux=ssh
compdef rgit=git

export PATH="${PATH}:/Users/joao/reps/cob/utils/cob/bin"
export PATH="${PATH}:/Applications/IntelliJ IDEA.app/Contents/MacOS"
source "/Users/joao/reps/cob/utils/cob/libexec/../completions/cob.zsh"
cob() {
  local command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  shell)
    eval `cob "sh-$command" "$@"`;;
  *)
    command cob "$command" "$@";;
  esac
}

# turn on asdf
source "$(brew --prefix asdf)/libexec/asdf.sh"
# set JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.zsh

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

# 1password cli completion
eval "$(op completion zsh)"; compdef _op op

# uncomment this and first line for profiling
# zprof

# begin cob-cli completion
. <(cob-cli --completion)
# end cob-cli completion

# begin cob-cli completion
. <(cob-cli --completion)
# end cob-cli completion
