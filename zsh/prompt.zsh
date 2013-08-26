git_repo_info() {
  git rev-parse --git-dir 1>/dev/null 2>/dev/null
  if [[ $? == 0 ]]
  then
    echo -n " on "
    echo -n "$(git symbolic-ref --short HEAD 2>/dev/null)" || echo -n "(detached HEAD)"

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
  fi
}


export PROMPTLINE1='%B%n%b in %U%~%u$(git_repo_info)'
export PROMPTLINE2='> '

precmd() {
  # The '\e[K' sequence erases to the end of the line. This keeps precmd
  # from outputting extraneous spaces, which cause wrapping issues
  print -n "\e[K\n";

  print -P $PROMPTLINE1;
}

export PROMPT=$PROMPTLINE2
