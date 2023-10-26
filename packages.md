# Package List for Ubuntu Server Workstation

### Basic Tools
* stow
* gcc
* unzip
* tree
* w3m
* lolcat
* lynx
* golang
* tmux
* screen
* tldr
* fzf
* shfmt
* netstat
* parallel <- Check this out. It's apparently sick.
* nodejs
* npm

* jq (jquery)
* python3.10-venv
* nvim ( sudo add-apt-repository ppa:neovim-ppa/unstable -y )
* cargo (rust) - `curl https://sh.rustup.rs -sSf | sh`

```bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install stow gcc unzip tree w3m lolcat lynx tmux screen tldr fzf shfmt netstat nodejs npm -y
```

* charmbracelet/mods (ChatGPT from the command line)
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt-get update && sudo apt-get install mods
```

... probably more that I can't think of right now. Is there a better way to get a list of packages
that were *explicitly* installed by the user with `Advanced Packaging Tool` (apt)?

### Tools to check out
* KeePassXC
* traefik
* vault

### Totally unrelated things to check out
L3MON - [Android Hax](https://www.golinuxcloud.com/l3mon-hack-android-mobile-remotely/)
JuiceSSH - [SSH client for Android](https://juicessh.com/)






