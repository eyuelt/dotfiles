alias c='clear'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias emacs='emacs -nw'
alias diff='diff -bB'

if [ "$(uname -s)" = "Darwin" ]
then
  alias ls='ls -G'
else if [ "$(uname -s)" = "Linux" ]
  alias ls='ls --color'
fi

alias sudo='sudo_env'
