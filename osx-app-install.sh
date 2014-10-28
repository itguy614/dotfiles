#!/bin/bash

# Install Xcode command line tools
echo "Installing Xcode Command Line Tools..."
xcode-select -p
if [[ $? -ne 0 ]]; then
  xcode-select --install
fi

xcodebuild -version
if [[ $? -ne 0 ]]; then
    # Accept Xcode license
    sudo xcodebuild -license
fi

# Update all OSX packages
sudo softwareupdate -i -a

# Install Homebrew
echo "Installing Homebrew..."
brew --version
if [[ $? -ne 0 ]]; then
    # Clean-up failed Homebrew install
    rm -rf "$(brew --prefix)/Cellar" "$(brew --prefix)/.git"
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi
brew update # Update Homebrew recipes
brew upgrade

# Update default unix tools
echo "Homebrew: updating default unix tools..."
brew install coreutils # Install GNU core utilities (those that come with OS X are outdated)
brew install findutils # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install bash # Install Bash 4
brew tap homebrew/dupes # Install more recent versions of some OS X tools
brew tap homebrew/versions
brew install homebrew/dupes/grep
$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH # update the $PATH in your ~/.bash_profile

# Install Homebrew binaries
echo "Homebrew: installing binaries..."
binaries=(
  bash
  bash-completion
  bash-git-prompt
  bmon
  composer
  dnsmasq
  drush
  git-flow-avh
  grep
  htop
  mackup
  mcrypt
  node
  osxutils
  tree
  watch
  wget
  xquartz
  zsh
)
brew install ${binaries[@]}
echo "Homebrew: cleaning up..."
brew cleanup

# htop-osx requires root privileges to correctly display all running processes.
sudo chown root:wheel "$(brew --prefix)/bin/htop"
sudo chmod u+s "$(brew --prefix)/bin/htop"

echo "Homebrew: installing php..."
brew tap homebrew/php
phpinstall=(
  php55
  php55-mcrypt
)
brew install ${phpinstall[@]}

# Install fonts and applications with Homebrew Cask
echo "Homebrew: installing Homebrew Cask..."
brew install caskroom/cask/brew-cask # install Cask
brew tap caskroom/versions # install beta versions with Cask
brew tap caskroom/fonts # install fonts with Cask

# Install fonts (https://github.com/caskroom/homebrew-fonts/tree/master/Casks)
echo "Homebrew Cask: installing fonts..."
fonts=(
  font-anka-coder
  font-anonymous-pro
  font-dejavu-sans
  font-droid-sans-mono
  font-droid-sans
  font-fontawesome
  font-inconsolata
  font-input
  font-roboto
  font-source-sans-pro
  font-terminus
  font-ubuntu
)
brew cask install ${fonts[@]}

# Install applications
echo "Homebrew Cask: installing apps..."
apps=( # Apps
  adobe-creative-cloud
  alfred
  atext
  atom
  boom
  caffeine
  chicken
  dash
  diffmerge
  evernote
  firefox
  flash
  flash-player
  geektool
  google-chrome
  google-drive
  growl-fork
  iterm2
  lastpass-universal
  # prey
  # qlcolorcode
  # qlstephen
  # qlmarkdown
  # quicklooks-json
  # qlprettypatch
  # quicklooks-csv
  royal-tsx
  sequel-pro
  skitch
  skype
  slack
  sourcetree
  spotify
  sublime-text3
  tagspaces
  tunnelblick
  vagrant
  virtualbox
)
brew cask install --appdir="/Applications" ${apps[@]} # Install apps to /Applications

echo "Install mackup using pip..."
pip install mackup

# Copy application preferences & config files with Mackup
# echo "Mackup: restoring application preferences..."
# mackup restore

# Create Sites directory for local sites
echo "Creating Sites directory..."
mkdir ~/Sites

echo "Homebrew: cleaning up..."
brew linkapps
brew cleanup
brew prune
brew cask cleanup

echo "Done! Yay, automation!"