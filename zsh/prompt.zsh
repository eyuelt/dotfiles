PROMPTLINE1='%B%n%b[%U%c%u]%#'
PROMPTLINE2='> '

precmd() {
  # The '\e[K' sequence erases to the end of the line. This keeps precmd
  # from outputting extraneous spaces, which cause wrapping issues
  print -n "\e[K\n";

  print -P $PROMPTLINE1;
}

export PROMPT=$PROMPTLINE2
