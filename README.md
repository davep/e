# e

Command for running GNU Emacs. Because I almost never work *on* a remote
server, if I'm working on a remote server, I needed a command that could
open a file in my local Emacs while I'm in a shell on a remote machine. `e`
is the solution to this.

It makes the following assumptions:

- GNU Emacs is running locally with the Emacs server running.
- `sshd` is running on the local machine and the servers can connect back.
- Public keys have been placed in all the right places (although GNU Emacs
  will take care of prompting for a password if required, but that'd get
  very old very quick).

When run, `e` then uses `ssh` to call back to the local machine, running
`emacsclient` and passing it a `tramp` filename. It also does some simple
tests to check if it should ask `tramp` to `sudo` the edit too (so watch out
for that: an attempt to edit a file you don't own might actually work if you
have `sudo` rights on the remote machine).

It also works locally too, opening a file in a locally-running Emacs server,
or kicking off a new copy of Emacs if one isn't available.

[//]: # (README.md ends here)
