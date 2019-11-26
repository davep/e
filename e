#!/bin/bash

############################################################################
# e - Edit a file with GNU Emacs, assuming that I'm already running
# emacsclient on my main workstation. See:
#
# https://github.com/davep/longmacs.el
#
# for a tool to get the Emacs server up and running.
#
# This tool will call a local emacsclient if run locally; or will attempt to
# ssh back to the workstation from a server and use tramp to edit a file.
# Note that it is assumed that all relevant config and keys are set in
# ~/.ssh on all relevant machines to make this a seamless operation.

# How to call on the Emacs client.
EMACS_CLIENT="emacsclient --alternate-editor=emacs --no-wait"

# Figure out the name/IP of the remote machine.
function remote_machine {
    echo $SSH_CLIENT | cut -d " " -f 1
}

# Are we working remotely?
function working_remote {
    [ -n "$(remote_machine)" ]
}

# If the file can't be written to, sudo it.
function sudo_maybe {
    # If there's a writeable file...
    if [ -w "$1" ]
    then
        # ...don't try and sudo
        echo ""
    # If there is a file (which isn't writeable)...
    elif [ -f "$1" ]
    then
        # ...try and sudo to it.
        echo "|sudo:$(hostname)"
    fi
}

# Edit a file, via tramp, on a remote machine.
function remote_emacs {
    ssh $(remote_machine) "$EMACS_CLIENT \"/ssh:$(hostname)$(sudo_maybe "$1"):$(realpath "$1")\""
}

# Edit a file locally.
function local_emacs {
    if pgrep -q [Ee]macs;
    then
        $EMACS_CLIENT "$@"
    else
        emacs "$@" &
    fi
}

# Are we working remotely?
if working_remote
then
    # We are, call back to the workstation.
    remote_emacs "$@"
else
    # We're editing a file on the workstation.
    local_emacs "$@"
fi

### e ends here
