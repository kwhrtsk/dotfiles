## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

#
# PATH
#
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export PATH="$HOME/tools/bin:$PATH"

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

# exclude / from default WORDCHARS
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export EDITOR=vim

function rspec() {
  if [ -e ./bin/rspec ]; then
    echo "./bin/rspec"
    ./bin/rspec $@
  elif [ -e Gemfile ]; then
    echo "bundle exec rspec"
    bundle exec rspec $@
  else
    "rspec"
    rspec $@
  fi
}

# golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
eval "$(anyenv init -)"

# rust/cargo
export PATH=$HOME/.cargo/bin:$PATH
