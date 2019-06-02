# Note: It is important that PROMPT is short because when the window is resized
# to be shorter than the length of PROMPT, weird things happen (mainly the lines
# above the prompt get overwritten and the prompt gets duplicated). We avoid
# this issue by printing most of the prompt info via precmd instead of using the
# PROMPT variable.

# This script uses ANSI escape codes (https://en.wikipedia.org/wiki/ANSI_escape_code).
# See http://ascii-table.com/ansi-escape-sequences-vt-100.php for a list of ANSI escape codes.

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

# This function displays a right-side prompt that is level with the first line
# of the prompt. This is different from the built-in RPROMPT var, which writes
# on the last line of the prompt (the same line as the command). This avoids the
# redraw issues on Linux when resizing the window when RPROMPT is set.
display_rprompt() {
  rprompt_len="${#$(strip_ansi_escape_sequences ${rprompt})}"
  print -n "\e7"                     # saves the cursor position
  print -n "\e[1000C"                # moves the cursor to the right 1000 times (or until it reaches the right side of the screen) TODO: use $COLUMNS
  print -n "\e[${rprompt_len}D"      # moves the cursor back to the left <length_of_rprompt> times
  print -n "${rprompt}"              # prints out $rprompt
  print -n "\e8"                     # restores the original cursor position
}

prompt_line_1='┌─$(prompt_x_symbol) $(prompt_username)$(prompt_computer_name)$(prompt_screen_info)$(prompt_directory)$(prompt_git_repo_info)'
prompt_line_2='└> '

rprompt=''

# This function is executed by zsh before each prompt.
precmd() {
  # The '\e[K' sequence erases to the end of the line. This keeps precmd from
  # outputting extraneous spaces, which cause wrapping issues
  print -n "\e[K\n";

  print -nP $prompt_line_1;

  if [[ -n $rprompt ]]
  then
    display_rprompt
  fi

  print -n "\n"
}

# This envvar defines the actual zsh prompt.
export PROMPT=$prompt_line_2
