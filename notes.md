




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


#### GPG for git

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
 

##### Other Git Encryption Solutions:

`git-remote-gcrypt`
`git-secret`
`git-crypt`

BlackBox by StackOverflow



