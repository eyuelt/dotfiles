
########## Zsh Hook Functions ##########
# See http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions.

# Executed before each prompt.
precmd_functions=(precmd__commandhistory precmd__prompt)

# Executed after the user enters a command.
preexec_functions=(preexec__commandhistory)

# Executed after the user enters a command but before it is executed.
zshaddhistory_functions=(zshaddhistory__prompt)
