#!/bin/bash
#
# Load the Terminal.app profile and set it as the default profile.
# Taken from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

PROFILE_NAME="Solarized Dark"
PROFILE_FILE_PATH="$DOTFILES/osx/$PROFILE_NAME.terminal"

osascript << EOD

tell application "Terminal"
    local initialOpenedWindows
    local allOpenedWindows
    set profileName to "$PROFILE_NAME"

    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list
        of available terminal themes (note: this will open two
        additional terminal windows). *)
    do shell script "open '$PROFILE_FILE_PATH'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set profileName

    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window

    (* Close the newly opened windows and change the theme for
        the initially open windows to remove the need to close
        them in order for the custom theme to be applied. *)
    local windowID
    repeat with windowID in allOpenedWindows
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set profileName
        end if
    end repeat
end tell

EOD
