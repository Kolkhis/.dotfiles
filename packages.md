# Package List for Ubuntu Server Workstation

## Getting Explicitly Installed Packages
```bash
apt-mark showmanual
```
"Bootstrapping" script at the bottom.

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
* cmatrix

## Programming
* jq (jquery - install )
* python3.10-venv
* python3-pip
* gopls

Needed for compiling Vim:
* clang
* libtool-bin clang libpython3-dev
* libpython3-dev (python support)
```bash
sudo apt-get update && sudo apt-get install clang libtool-bin libpython3-dev -y
```

## Other Packages
>> These are package either unavailable or not up-to-date on `apt`, or have extra requirements.
* nvim (latest neovim - see below)
* nvm (node version manager - see below)
* mods (charmbracelet/mods - see below)
* golang1.21+ (use install script)
* libssl1.1 (use install script) >>> For Cody (sg.nvim)
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
python3.10-venv python3-pip gopls clang libtool-bin libpython3-dev -y
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


## Package Install Script
```bash
#!/bin/bash


install_libssl1.1() {
    curl -fsSL -o /tmp/libssl1.1_1.1.0g-2ubuntu4_amd64.deb http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
    if [[ -f /tmp/libssl1.1_1.1.0g-2ubuntu4_amd64.deb ]]; then
        printf "Download successful, attempting to install libssl1.1\n"
        if sudo dpkg -i /tmp/libssl1.1_1.1.0g-2ubuntu4_amd64.deb; then
            printf "Install was successful.\n"
            return 0
        else
            printf "There was an issue with the libssl1.1 installation.\n"
            return 1
        fi
    else
        printf "There was a problem downloading libssl1.1"
        return 1
    fi
    return 0
}


go_install() {
    mkdir -p ~/install/go
    cd ~/install/go || exit
    if [[ ! -f /tmp/go1.21.1.linux-amd64.tar.gz ]]; then
        curl -fsSL -o /tmp/go1.21.1.linux-amd64.tar.gz https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
    fi
    if [[ -f /tmp/go1.21.1.linux-amd64.tar.gz ]]; then
        sudo tar -C /usr/local -xzf /tmp/go1.21.1.linux-amd64.tar.gz
        go_path_exists=false
        for file in ~/.bash*; do
            if [[ $file == "$HOME/.bash_history" ]] || [[ $file == "$HOME/.bash_logout" ]]; then
                continue
            fi
            if grep -q "export PATH=\$PATH:/usr/local/go/bin" "$file"; then
                go_path_exists=true
            fi
        done
        if [[ ! $go_path_exists ]]; then
            echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
        fi
        source "$HOME/.bashrc"
        go version
    else
        echo "There was a problem downloading Go."
    fi
    cd - || return 1
    return 0
}


install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install node
    return 0
}


install_neovim() {
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update
    sudo apt-get install neovim -y
    return 0
}


install_mods() {
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt-get install mods
    return 0
}


sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install stow gcc unzip tree entr w3m lolcat \
lynx tmux screen tldr fzf shfmt ncal nodejs npm xterm visidata \
python3.10-venv python3-pip gopls clang libtool-bin libpython3-dev -y

install_nvm
install_libssl1.1
go_install
install_neovim
install_mods

```
