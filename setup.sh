#!/bin/bash

# --------------------------------------------------------------------------
#  System Initialization & Dotfiles Setup
#  Maintained by: Zea (via Gemini CLI)
# --------------------------------------------------------------------------

set -e

DOTFILES="$HOME/.dots"
LOG_FILE="$DOTFILES/install.log"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# --------------------------------------------------------------------------
#  Helpers
# --------------------------------------------------------------------------

log() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

if [ "$EUID" -eq 0 ]; then
  error "Do not run this script as root. I will ask for sudo permissions when necessary."
  exit 1
fi

log "${RED}THIS SCRIPT IS NOT TESTED, USE AT YOUR OWN RISK.${NC}"
log "feel free to test and fix it and open PRs :3"

while true; do
  read -rp "Do you want to proceed? (y/N): " yn
  case $yn in
  [Yy])
    echo "Proceeding..."
    break
    ;;
  [Nn] | *)
    echo "Exiting..."
    exit
    ;;
  esac
done

# --------------------------------------------------------------------------
#  1. AUR Helper (Yay)
# --------------------------------------------------------------------------

if ! command -v yay &>/dev/null; then
  log "AUR helper not found. Initializing 'yay' installation sequence..."
  sudo pacman -S --needed --noconfirm base-devel git
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd - >/dev/null
  rm -rf /tmp/yay
  success "Yay installed."
else
  log "Yay detected."
fi

# --------------------------------------------------------------------------
#  2. Package Installation
# --------------------------------------------------------------------------

# Core System & Hyprland Essentials
PKGS_CORE=(
  "git"
  "hyprland"
  "hyprpolkitagent"
  "qt5-wayland"
  "qt6-wayland"
  "stow"
  "xdg-desktop-portal-hyprland"
)

# CLI Tools & Shell
PKGS_CLI=(
  "bat"
  "btop"
  "chafa"
  "eza"
  "fastfetch"
  "fd"
  "fish"
  "fzf"
  "hyfetch"
  "imagemagick"
  "jq"
  "lazygit"
  "neovim"
  "reflector"
  "ripgrep"
  "starship"
  "unzip"
  "zip"
  "zoxide"
)

# GUI / Hyprland Addons
PKGS_GUI=(
  "brightnessctl"
  "cliphist"
  "gpu-screen-recorder"
  "grim"
  "hypridle"
  "hyprlock"
  "hyprpicker"
  "hyprshot"
  "kitty"
  "mako"
  "nwg-displays"
  "nwg-look"
  "playerctl"
  "rofi"
  "slurp"
  "swww"
  "waybar"
  "wl-clipboard"
)

# Audio / Connectivity
PKGS_SYS=(
  "bluetui"
  "bluez"
  "bluez-utils"
  "networkmanager"
  "pulsemixer"
  "pipewire"
  "wireplumber"
)

# Fonts
PKGS_FONTS=(
  "ttf-jetbrains-mono-nerd"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "noto-fonts-emoji"
)

ALL_PKGS=("${PKGS_CORE[@]}" "${PKGS_CLI[@]}" "${PKGS_GUI[@]}" "${PKGS_SYS[@]}" "${PKGS_FONTS[@]}")

log "Synchronizing database and installing $(echo "${#ALL_PKGS[@]}") packages..."
yay -S --needed --noconfirm "${ALL_PKGS[@]}" 2>&1 | tee -a "$LOG_FILE"

# --------------------------------------------------------------------------
#  3. System Services
# --------------------------------------------------------------------------

log "Enabling system services..."
# Bluetooth
sudo systemctl enable --now bluetooth.service
# NetworkManager (ensure it's running, usually is)
sudo systemctl enable --now NetworkManager.service

# --------------------------------------------------------------------------
#  4. Directory Structure (Anti-Folding)
# --------------------------------------------------------------------------

log "Configuring directory structure..."
if [ -d "$DOTFILES/.config" ]; then
  find "$DOTFILES/.config" -maxdepth 1 -mindepth 1 -type d | while read -r dir; do
    dirname=$(basename "$dir")
    target="$HOME/.config/$dirname"

    if [ ! -d "$target" ]; then
      if [ -L "$target" ]; then
        log "Unlinking symlinked directory: $target"
        rm "$target"
      fi
      mkdir -p "$target"
    fi
  done
fi

# --------------------------------------------------------------------------
#  5. Stow & Shell
# --------------------------------------------------------------------------

log "Linking dotfiles..."
cd "$DOTFILES"
stow .

if command -v fish &>/dev/null; then
  if [[ "$SHELL" != *"/fish"* ]]; then
    log "Updating default shell to fish..."
    chsh -s "$(which fish)"
  fi
fi

success "Installation complete. Please reboot."

