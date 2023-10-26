
# Installing the Exercism CLI Tool

##### Official guide is [here](https://exercism.org/cli-walkthrough).

Download the release for your OS and system architecture from the [releases page](https://github.com/exercism/cli/releases/tag/v3.2.0).

Navigate to a folder to install, or make one (`mkdir -p ~/install/exercism/; cd ~/install/exercism/`)
##### This is my method of avoiding tarbombs.

Then, run `wget` for the tarball, and unzip it:
```bash
wget https://github.com/exercism/cli/releases/download/v3.2.0/exercism-3.2.0-linux-x86_64.tar.gz
tar -xf ./exercism-3.2.0-linux-x86_64.tar.gz
```

Then, copy the executable to `~/bin/`:
```bash
mkdir -p ~/bin/
cp ./exercism ~/bin/
```

Make sure `~/bin/` is in your PATH:
```bash
echo 'export PATH=~/bin:$PATH' >> ~/.bash_aliases  # Or .bashrc/.bash_profile
```

Then you need to configure exercism with your token, found on the [settings page](https://exercism.org/settings/api_cli).
```bash
exercism configure --token=<your_api_token>
```

Then you're done.

Read up on how to [do exercises locally](https://exercism.org/docs/using/solving-exercises/working-locally).

