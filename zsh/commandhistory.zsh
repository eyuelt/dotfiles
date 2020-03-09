# This maintains an in-memory timing history of the commands run in the current
# shell session.

export g_timing_history

add_entry() {
  # only define it if it's not already defined. don't want to reset the history
  # every time zshrc is sourced.
  if [[ -z $g_timing_history ]]
  then
    g_timing_history=()
  fi
  local header="======"
  local command_text="Command: \`${1}\`"
  local start_time="Start:   ${2}"
  g_timing_history+="${header}\n${command_text}\n${start_time}\n"
}

update_previous_entry() {
  local finish_time="Finish:  ${1}"
  if [[ -n ${g_timing_history[-1]} ]]
  then
    g_timing_history[-1]="${g_timing_history[-1]}${finish_time}\n"
  fi
}

recent_command_history() {
  local num_elems_to_show=10
  local num_elems_available="${#g_timing_history[@]}"
  if [[ $num_elems_available -lt $num_elems_to_show ]]
  then
    num_elems_to_show=$num_elems_available
  fi
  echo "$g_timing_history" | less
}

########## Zsh Hook Functions ##########
# These are added to precmd_functions in init.zsh.
# See http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions.

# Executed before each prompt.
precmd__commandhistory() {
  update_previous_entry "$(date +'%Y/%m/%d - %H:%M:%S')"
}

# Executed after the user enters a command.
preexec__commandhistory() {
  add_entry "$1" "$(date +'%Y/%m/%d - %H:%M:%S')"
}
