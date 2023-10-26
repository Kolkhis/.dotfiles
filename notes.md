
## Packages to install when I have Linux on desktop:
#### (Distro? Linux Mint??)

* Awesome WM (Window Manager) 



   
### Core utils to remember
<details>
<summary>Commands</summary>

* `cat`

* `read`

* `grep`

* `tr`

* `echo`

* `sed`

* `awk`

* ... what else?
</details>

### Timezone change
#### Get timezone for system:
    * timedatectl
#### Find your timezone:
    * timedatectl list-timezones
#### Change it:
    * timedatectl set-timezone America/New_York


### Tmux vs Screen
#### Multiple user session:
* Both have multi-user support
* Screen allows users to share a session, but be in different windows
      * screen -r sessionowner/[pid.tty.host]
* Tmux session allows users to share a session, but switchig windows switches for both users.

* attach to existing session in tmux:
      * `$ tmux attach -t 0`
      * Where 0 is the target session from `tmux ls`





### Cool Vim Tips/Tricks

Putting ! at the end of the command in vim toggles the command on and off.

`"tyy` <- yank line to register t
`@t` <- play register as macro

`q[char]` <- start recording a macro in the [char] register. q again to stop recording.
`@[char]` <- play the macro

`:.![cmd]` <- use the current line as stdin for `[cmd]`, stdout on current line

`<C-o> p` <- quickly pastes register while in insert mode

<details>
<summary>GPG for git</summary>

##### Plain GPG Protected Credential Helper:
1. Set git to use gpg
`$ git config --global credential.credentialStore gpg`

1. Generate gpg key
    1. Run `$ gpg --full-generate-key`
    1. Specify the type. RSA/whatever (default) is good.
    1. Specify key size (4096)
    1. Enter when key will expire
    1. Verify
    1. Enter User info (Email should be the same as GH account)
    1. Set a password
1. Get the secret key
`$ gpg --list-secret-keys --keyid-format=long`
It will look something like `rsa4096/<secret_key>` under the `sec` section. Only take the key.

1. Init the password with the secret key
`$ pass init <secret_key>`

1. Add the public key to GH account.
    * Get the public key with `$ gpg --armor --export <secret_key>`.
        * ` > gpg_key` for easy copypasta
    * Profile > Settings > SSH and GPG keys. Paste key.
 
</details>

<details>
#<summary> Other Git Encryption Solutions:</summary> 
/
`git-remote-gcrypt`
`git-secret`
`git-crypt`

BlackBox by StackOverflow

</details>



### Git Commit Messages
<details>
<summary>Git commit message convention</summary>
[type]: [description]

[body]

Where:

[type]: Indicates the type of the commit. It should be one of the following:

* feat: A new feature or functionality added.

* fix: A bug fix or error correction.

* docs: Documentation updates or changes.

* style: Changes to code formatting, indentation, etc.

* refactor: Code refactoring or restructuring without adding new features or fixing bugs.

* test: Adding or updating tests.

* chore: Maintenance tasks or other miscellaneous changes.


[description]: A brief and concise description of the change made in the commit. It should start with a capitalized verb and should not exceed 50 characters.

[body] (optional): A more detailed description of the changes made in the commit. This part is optional but can be useful for providing additional context or information about the changes.
</details>

### Tmux Commands
<details>
<summary> Session Management:</summary>

    * tmux new-session: Create a new session.

    * tmux attach-session: Attach to an existing session.

    * tmux switch-client: Switch to a different client in a session.

    * tmux list-sessions: List existing sessions.

    * tmux detach-client: Detach the current client from the session.

    * tmux kill-session: Terminate a session.

    * tmux has-session: Check if a session exists.


<summary> Window Management: </summary>

    * tmux new-window: Create a new window.

    * tmux select-window: Switch to a specific window.

    * tmux last-window: Switch to the previously used window.

    * tmux next-window: Switch to the next window.

    * tmux previous-window: Switch to the previous window.

    * tmux list-windows: List existing windows.

    * tmux kill-window: Close the current window.


<summary> Pane Management: </summary>

    * tmux split-window: Split the current pane into two vertical panes.

    * tmux split-window -h: Split the current pane into two horizontal panes.

    * tmux swap-pane -[UDLR]: Swap panes with the specified direction (Up, Down, Left, Right).

    * tmux select-pane -[UDLR]: Select the pane in the specified direction.

    * tmux select-pane -t <pane-number>: Select a specific pane by number.

    * tmux resize-pane -[UDLR] <size>: Resize the current pane in the specified direction by size.

    * tmux kill-pane: Close the current pane.

<summary> Miscellaneous Commands:</summary>

    * tmux list-keys: List all keybindings.

    * tmux list-commands: List all commands.

    * tmux info: Display information about the current session, window, or pane.

    * tmux source-file <file>: Load a configuration file.


<summary> Session, Window, and Pane Indexing:</summary>

    * tmux choose-session: Interactively choose a session.

    * tmux choose-window: Interactively choose a window.

    * tmux choose-pane: Interactively choose a pane.

    * tmux switch-client -t <target-client>: Switch to a specific client (session or window).

<summary> Copy Mode (for copying text):</summary>

    * tmux copy-mode: Enter copy mode.

    * tmux send-keys -X copy-selection: Copy selected text to the clipboard.

</details>

 Invisible disability gaining visible ability through coding

[![twitter](https://img.shields.io/badge/Twitter-blue?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/null_kol)
[![twitch](https://img.shields.io/badge/Twitch-purple?style=for-the-badge&logo=twitch&logoColor=white)](https://twitch.tv/kolkhis)
[![ko-fi](https://img.shields.io/badge/kofi-pink?style=for-the-badge&logo=kofi&logoColor=white)](https://ko-fi.com/kolkhis)


