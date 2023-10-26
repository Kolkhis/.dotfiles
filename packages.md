# Package List for Ubuntu Server Workstation


## Getting Explicitly Installed Packages
```bash
apt-mark showmanual
```


## Basic Tools
* stow
* gcc
* unzip
* tree
* entr
* w3m
* lolcat
* lynx
* tmux
* screen
* tldr
* fzf
* shfmt
* netstat
* ncal - calendar
* nodejs
* npm
* xterm
* visidata
* youtube-dl


## Programming
* jq (jquery - install )
* python3.10-venv
* python3-pip


## Other Packages
>> These are package either unavailable or not up-to-date on `apt`, or have extra requirements.
* nvim (latest neovim - see below)
* nvm (node version manager - see below)
* mods (charmbracelet/mods - see below)
* golang1.21+ (use install script)
* libssl1.1 (use install script) >>> For Cody
    * NOTE: The install script is for amd64 compatible systems; 
      you'll need to install the ARM package if you're on an ARM system (ARM Mac or a RasbperyPi: 
      (`http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb`)
* cargo (rust)
    * `curl -fsSL https://sh.rustup.rs | sh`

### Basic Package Installation
```bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install stow gcc unzip tree entr w3m lolcat \
lynx tmux screen tldr fzf shfmt ncal nodejs npm xterm visidata \
python3.10-venv python3-pip -y
```

### Installing Other Packages (packages not up-to-date or unavailable on `apt`)
* charmbracelet/mods (ChatGPT from the command line)
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt-get update && sudo apt-get install mods
```

* nvm (Node Version Manager)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash )
exec bash -l
nvm install node
```

* nvim
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim -y
```

### Tools to check out
* parallel <- Check this out. It's apparently sick.
* KeePassXC
* traefik
* vault


### Totally unrelated things to check out
L3MON - [Android Hax](https://www.golinuxcloud.com/l3mon-hack-android-mobile-remotely/)
JuiceSSH - [SSH client for Android](https://juicessh.com/)


Static site generator (available on pip):
mkdocs 
mkdocs-material
mkdocs-awesome-pages-plugin

Learning hacking stuff:
TryHackMe and pentesterlab
When looking for XSS also look for SSTI or CSTI

