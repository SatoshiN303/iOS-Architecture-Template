#!/bin/sh

if which bundle >/dev/null; then
  echo "Install Gems"
  bundle install
else
  echo "brew command not found. Please install Homebrew"
fi

if which brew >/dev/null; then
  echo "Install Brews"
  brew bundle
else
  echo "brew command not found. Please install Homebrew"
fi


# install dependencies via CocoaPods
echo "Install dependencies via CocoaPods"
pod install

# install dependencies via Carthage
echo "Install dependencies via Carthage"
carthage update --platform ios --no-use-binaries --cache-builds

echo "Enjoy🥂"

open ProjectName.xcworkspace
