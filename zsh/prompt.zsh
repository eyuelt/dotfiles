# Note: It is important that PROMPT is short because when the window is resized
# to be shorter than the length of PROMPT, weird things happen (mainly the lines
# above the prompt get overwritten and the prompt gets duplicated). We avoid
# this issue by printing most of the prompt info via precmd instead of using the
# PROMPT variable.

# This script uses ANSI escape codes (https://en.wikipedia.org/wiki/ANSI_escape_code).
# See http://ascii-table.com/ansi-escape-sequences-vt-100.php for a list of ANSI escape codes.

# constants
# TODO: move these somewhere else
C0="%{\033[30m%}"  # black
C1="%{\033[31m%}"  # red
C2="%{\033[32m%}"  # green
C3="%{\033[33m%}"  # yellow
C4="%{\033[34m%}"  # blue
C5="%{\033[35m%}"  # magenta
C6="%{\033[36m%}"  # cyan
C7="%{\033[37m%}"  # white
CRESET="%{\033[m%}"

# global variables
g_prev_command_exit_code=0


########## Prompt helper functions ##########

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
  local inworkingtree="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [[ $? == 0 && $inworkingtree == 'true' ]]
  then
    echo -n " on "
    echo -n "$C2$(git symbolic-ref --short HEAD 2>/dev/null || (git symbolic-ref HEAD 2>/dev/null | cut -d / -f3 && [[ ${pipestatus[1]} -eq 0 ]]) || echo -n '(detached HEAD)')$CRESET"

    echo -n "$C5"
    local changes=$(git status --short)
    if [[ -z $changes ]]
    then
      echo -n "."
    else
      if [[ -n "$(git status -s | grep '^[^? ]')"  ]]  # there are staged changes
      then
        echo -n "⇡"
      fi
      if [[ -n "$(git status -s | grep '^.[^? ]')" ]]  # there are unstaged changes
      then
        echo -n "⇣"
      fi
      if [[ -n "$(git status -s | grep '^??')" ]]      # there are untracked files
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
# redraw issues on Linux when resizing the window when RPROMPT is set. Note that
# this assumes left prompt has already been drawn.
display_rprompt() {
  local prompt_len="${#$(strip_ansi_escape_sequences ${(%%e)prompt_line_1})}"
  local rprompt_len="${#$(strip_ansi_escape_sequences ${(e)rprompt})}"
  local right_shift_len="$(($COLUMNS - $prompt_len - $rprompt_len))"
  if [[ $right_shift_len -lt 0 ]]
  then
    right_shift_len=1
  fi
  # creates a string made up of $right_shift_len spaces
  local spacer="$(head -c $right_shift_len < /dev/zero | tr '\0' ' ')"
  print -n "$spacer"
  print -n "${(e)rprompt}"
}

# This prints the top line of the prompt (includes $prompt_line_1 and $rprompt).
# Note: This is pretty slow. Try to minimize calling this.
print_precmd_line() {
  print -n "\e[2K"
  print -nP $prompt_line_1
  if [[ -n $rprompt ]]
  then
    print -n "$(display_rprompt)"
  fi
}

########## Zsh Hook Functions ##########
# These are added to precmd_functions in init.zsh.
# See http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions.

# Executed before each prompt.
precmd__prompt() {
  g_prev_command_exit_code=$?  # Note: this must be the first line in precmd
  precmd_line="$(print_precmd_line)"
  # 1. Print a blank line before the prompt (this blank line must be cleared
  #    with '\e[2K' or it will be full of whitespace and cause wrapping issues).
  # 2. Print the first line of the prompt (which includes rprompt if defined).
  # 3. Move the cursor down one line so that $prompt_line_2 is printed in the
  #    right position.
  print -n "\e[2K\n${precmd_line}\n"
}


########## Prompt definition ##########

prompt_line_1='┌─$(prompt_x_symbol) $(prompt_username)$(prompt_computer_name)$(prompt_screen_info)$(prompt_directory)$(prompt_git_repo_info)'
prompt_line_2='└> '

rprompt=''

# This envvar defines the actual zsh prompt.
export PROMPT=$prompt_line_2
