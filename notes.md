




#### Core utils to remember

* cat
* read
* grep
* tr
* echo 
* sed
* awk
* ... what else?


### Timezone change
#### Get timezone for system:
timedatectl
#### Find your timezone:
timedatectl list-timezones
#### Change it:
timedatectl set-timezone America/New_York


### Tmux vs Screen
#### Multiple user session:
* Both have multi-user support
* Screen allows users to share a session, but be in different windows
* Tmux session allows users to share a session, but switchig windows switches for both users.

* attach to existing session in tmux:
    - `$ tmux attach -t 0`
    - Where 0 is the target session



nvim

"tyy <- yank line to register t
@t <- play register as macro
