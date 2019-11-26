# e

Edit a file with Emacs, assuming that I'm already running `emacsclient` on
my main workstation. See:

https://github.com/davep/longmacs.el

for a tool to get the Emacs server up and running.

This tool will call a local `emacsclient` if run locally; or will attempt to
`ssh` back to the workstation from a server and use tramp to edit a file.
Note that it is assumed that all relevant config and keys are set in
`~/.ssh` on all relevant machines to make this a seamless operation.

[//]: # (README.md ends here)
