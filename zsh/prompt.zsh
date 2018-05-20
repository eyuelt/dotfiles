C0="\033[30m"
C1="\033[31m"
C2="\033[32m"
C3="\033[33m"
C4="\033[34m"
C5="\033[35m"
C6="\033[36m"
C7="\033[37m"
CRESET="\033[m"

prompt_username() {
  echo -n "$C3%n$CRESET"
}

prompt_computer_name() {
  if [[ -n $NICKNAME ]]
  then
    echo -n "@$C1$NICKNAME$CRESET"
  fi
}

prompt_screen_info() {
  if [[ -n $STY ]]
  then
    echo -n "[$C6$STY$CRESET]"
  fi
}

prompt_directory() {
  echo -n " in "
  echo -n "$C5%U%~%u$CRESET"
}

prompt_git_repo_info() {
  inworkingtree="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [[ $? == 0 && $inworkingtree == 'true' ]]
  then
    echo -n " on "
    echo -n "$C2$(git symbolic-ref --short HEAD 2>/dev/null || (git symbolic-ref HEAD 2>/dev/null | cut -d / -f3 && [[ ${pipestatus[1]} -eq 0 ]]) || echo -n '(detached HEAD)')$CRESET"

    echo -n "$C5"
    changes=$(git status --short)
    if [[ -z $changes ]]
    then
      echo -n "."
    else
      if [[ -n "$(git status -s | grep '^[^? ]')"  ]]  #there are staged changes
      then
        echo -n "⇡"
      fi
      if [[ -n "$(git status -s | grep '^.[^? ]')" ]]  #there are unstaged changes
      then
        echo -n "⇣"
      fi
      if [[ -n "$(git status -s | grep '^??')" ]]      #there are untracked files
      then
        echo -n "?"
      fi
    fi
    echo -n "$CRESET"
  fi
}

# display a symbol if x-forwarding is enabled
prompt_x_symbol() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
    then
        if [ -n "$DISPLAY" ]
        then
            echo -n "$C6⦿$CRESET"
        fi
    fi
}

prompt_line_1='┌─$(prompt_x_symbol) $(prompt_username)$(prompt_computer_name)$(prompt_screen_info)$(prompt_directory)$(prompt_git_repo_info)'
prompt_line_2='└> '

# This function is executed by zsh before each prompt.
precmd() {
  # The '\e[K' sequence erases to the end of the line. This keeps precmd
  # from outputting extraneous spaces, which cause wrapping issues
  print -n "\e[K\n";

  print -P $prompt_line_1;
}

# This envvar defines the zsh prompt.
export PROMPT=$prompt_line_2
