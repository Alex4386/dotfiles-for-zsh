# dotfiles-for-zsh
my dot files for starting up development environment

## Install homebrew (macOS Only)
### Install Xcode commandline tools
```sh
xcode-select --install
```

### Install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Nerd font
Install `FantasqueSansMono` from https://www.nerdfonts.com/font-downloads  
If you are using macOS, use homebrew to install.  
```sh
brew tap homebrew/cask-fonts
brew install --cask font-fantasque-sans-mono-nerd-font
```

## Configure zsh - Part.1

### Install zsh
If you are using macOS 10.15+, Skip this step.

### Install oh-my-zsh
It's a piece of cake right?
```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Configure macOS stock Terminal  
If you use stock terminal rather then iTerm2, Configure this:  

<img width="779" alt="image" src="https://user-images.githubusercontent.com/27724108/114173431-1f934a00-9972-11eb-91f1-9afa6454dbde.png">

And make sure you set the font!  

<img width="779" alt="image" src="https://user-images.githubusercontent.com/27724108/114179107-89fbb880-9979-11eb-998e-62e828e83dde.png">

You are all set!


## Configure zsh -Part.2
### Setup Powerlevel10k
Install powerlevel10k by copying this command
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Setup ZSH Syntax highlighter
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Setup ZSH Autosuggestions
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Copy dotfiles
Just becareful while copying `.zshrc`.  
run diff between them if you have any additional configs there.

### Restart zsh
Run `exec zsh`.  

## Setup GnuPG

### Install GnuPG

#### macOS
```
brew install gpg pinentry-mac
```

#### Ubuntu
Later....

### Setting up GnuPG to use pinentry-mac (macOS)
```
echo 'pinentry-program $(brew --prefix)/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf
echo 'use-agent' > ~/.gnupg/gpg.conf
```

### Check Privkey on Smartcard
```
gpg --edit-card
```

### Fetch Pubkey via Smartcard
```
fetch
q
```

### Setup git to use gpg signing
*Casing is a requirement if you are using git 2.2+*
```
git config --global commit.gpgSign true
git config --global user.signingKey <Your Signing Key>
```

### Setup GPG TTY
Copy `dotfiles/.setup-gpg.zsh` to your home dir.

## Install Rustup
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install VSCode
Install one from https://code.visualstudio.com

### Setup Terminal font
Find for `Terminal > Integrated > Font Family`.  
Set it to: `'FantasqueSansMono Nerd Font', monospace`

### Install Extensions
#### Install LiveShare
For peer-programming, Install Live Share.

#### Install Remote - SSH
For better remote live-deployments, Install Remote-SSH

#### Install Tabnine
For better autocompletes, install tabnine.

#### Install Rust
Install Rust extensions for Rust programming language support.  
  
By the way, I recommend you to code Rust on Jetbrains CLion.  
Even though that's resource hungry. That's plain better.

#### Install GitHub Pull Requests and Issues
You use github right? install it.

#### Install GitLens
For better insight in git, You should install gitlens.

#### Install pylance
Since you code Python, You need to install pylance.  

#### Install ESLint
For better linting in nodeJS programming, Install ESLint.



# Done.