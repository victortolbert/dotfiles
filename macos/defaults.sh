#!/usr/bin/env bash
# dotfiles/macos/defaults.sh — baseline macOS preferences
#
# Run once on a fresh mac, then log out/in (or reboot) for everything to apply.
# This is a starter template — tweak as you go, and use
# `macos/current-defaults-reference.txt` to cross-check against an existing
# setup.
#
# Usage:  ./macos/defaults.sh

set -euo pipefail

echo "Applying macOS defaults…"

# Close System Settings so changes aren't overwritten on quit
osascript -e 'tell application "System Settings" to quit' >/dev/null 2>&1 || true

# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------
defaults write com.apple.finder AppleShowAllFiles            -bool true    # show hidden files
defaults write com.apple.finder ShowPathbar                  -bool true
defaults write com.apple.finder ShowStatusBar                -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle      -bool true    # full path in window title
defaults write com.apple.finder FXDefaultSearchScope         -string "SCcf" # search current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false  # no warning on extension change
defaults write com.apple.finder FXPreferredViewStyle         -string "Nlsv" # list view by default
defaults write NSGlobalDomain AppleShowAllExtensions         -bool true    # show all file extensions
defaults write com.apple.finder _FXSortFoldersFirst          -bool true

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores     -bool true

# -----------------------------------------------------------------------------
# Dock
# -----------------------------------------------------------------------------
defaults write com.apple.dock tilesize                 -int 40
defaults write com.apple.dock autohide                 -bool true
defaults write com.apple.dock autohide-delay           -float 0
defaults write com.apple.dock autohide-time-modifier   -float 0.15
defaults write com.apple.dock show-recents             -bool false
defaults write com.apple.dock mru-spaces               -bool false      # don't rearrange spaces by most-recent
defaults write com.apple.dock minimize-to-application  -bool true       # minimize windows into the app icon
defaults write com.apple.dock expose-group-apps        -bool true       # group windows by app in Mission Control

# -----------------------------------------------------------------------------
# Keyboard & text input
# -----------------------------------------------------------------------------
defaults write NSGlobalDomain KeyRepeat                            -int 2   # fast repeat
defaults write NSGlobalDomain InitialKeyRepeat                     -int 15  # short delay
defaults write NSGlobalDomain ApplePressAndHoldEnabled             -bool false  # disable accent popup, enable key repeat
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled     -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled   -bool false

# Enable full keyboard access for all controls (tab through everything)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# -----------------------------------------------------------------------------
# Trackpad & mouse
# -----------------------------------------------------------------------------
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad                  Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior      -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior                   -int 1

# Natural scrolling (true = macOS default; set to false for "normal")
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# -----------------------------------------------------------------------------
# Screenshots
# -----------------------------------------------------------------------------
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location        -string "$HOME/Screenshots"
defaults write com.apple.screencapture type            -string "png"
defaults write com.apple.screencapture disable-shadow  -bool true
defaults write com.apple.screencapture show-thumbnail  -bool true

# -----------------------------------------------------------------------------
# Save / print panels
# -----------------------------------------------------------------------------
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode   -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2  -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint      -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2     -bool true

# -----------------------------------------------------------------------------
# Menu bar clock — show date + time with seconds
# -----------------------------------------------------------------------------
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm:ss a"

# -----------------------------------------------------------------------------
# Safari developer tools (harmless if Safari is unused)
# -----------------------------------------------------------------------------
defaults write com.apple.Safari IncludeDevelopMenu                                  -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey           -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# -----------------------------------------------------------------------------
# Xcode-style key bindings in macOS text fields (optional)
# -----------------------------------------------------------------------------
# defaults write -g NSTextShowsControlCharacters -bool true

# -----------------------------------------------------------------------------
# Restart affected apps
# -----------------------------------------------------------------------------
for app in "Finder" "Dock" "SystemUIServer" "cfprefsd"; do
  killall "$app" >/dev/null 2>&1 || true
done

echo "Done. A few settings (keyboard repeat, menu bar clock) require log out / log in."
