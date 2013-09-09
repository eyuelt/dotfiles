C0="\033[30m"
C1="\033[31m"
C2="\033[32m"
C3="\033[33m"
C4="\033[34m"
C5="\033[35m"
C6="\033[36m"
C7="\033[37m"
CRESET="\033[m"

username() {
  echo -n "$C3%n$CRESET"
}

directory() {
  echo -n " in "
  echo -n "$C5%U%~%u$CRESET"
}

git_repo_info() {
  git rev-parse --git-dir 1>/dev/null 2>/dev/null
  if [[ $? == 0 ]]
  then
    echo -n " on "
    echo -n "$C2$(git symbolic-ref --short HEAD 2>/dev/null)" || echo -n "(detached HEAD)$CRESET"

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


export PROMPTLINE1='$(username)$(directory)$(git_repo_info)'
export PROMPTLINE2='> '

precmd() {
  # The '\e[K' sequence erases to the end of the line. This keeps precmd
  # from outputting extraneous spaces, which cause wrapping issues
  print -n "\e[K\n";

  print -P $PROMPTLINE1;
}

export PROMPT=$PROMPTLINE2
