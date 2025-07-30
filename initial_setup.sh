#!/bin/bash

# ===========================
# Settings
# ===========================
DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"

# ===========================
# Color Settings
# ===========================
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
RESET='\e[0m'

# ===========================
# Helper Functions
# ===========================
error_exit() {
    echo -e "${RED}Error: $1${RESET}"
    exit 1
}

safe_run() {
    "$@"
    if [ $? -ne 0 ]; then
        error_exit "Command failed: $*"
    fi
}

download_file() {
    local url="$1"
    local output="$2"

    if [ ! -f "$output" ]; then
        echo -e "${YELLOW}Downloading: $url${RESET}"
        wget -O "$output" "$url" || error_exit "Failed to download $url"
    else
        echo -e "${GREEN}Already downloaded:${RESET} $output"
    fi
}

# ===========================
# Update and Install Dependencies
# ===========================
clear
echo -e "${YELLOW}Updating package lists...${RESET}"
safe_run sudo apt update

echo -e "${YELLOW}Installing prerequisites...${RESET}"
safe_run sudo apt install -y whiptail curl wget git

# ===========================
# App Selection Menu
# ===========================
clear
OPTIONS=$(whiptail --title "App Installer" --checklist \
"Select the apps you want to install:" 20 78 10 \
"upgrade" "Upgrade packages" OFF \
"gnome-tweaks" "GNOME Tweak Tool" OFF \
"gnome-shell-extension-manager" "GNOME Shell Extensions" OFF \
"chrome" "Google Chrome web browser" OFF \
"nekoray" "Nekoray Proxy Client" OFF \
"telegram" "Telegram Desktop" OFF \
"grub2-theme" "Grub2 theme Boot selector" OFF \
"dash-to-dock" "Dash to Dock Extension" OFF \
3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
    echo -e "${RED}No selection. Exiting...${RESET}"
    exit 1
fi

OPTIONS=$(echo $OPTIONS | tr -d '"')

# ===========================
# Installation Loop
# ===========================
for choice in $OPTIONS; do
    case $choice in
        upgrade)
            echo -e "${YELLOW}Upgrading packages...${RESET}"
            safe_run sudo apt upgrade -y
            ;;

        gnome-tweaks)
            echo -e "${YELLOW}Installing GNOME Tweak Tool...${RESET}"
            safe_run sudo apt install -y gnome-tweaks
            ;;

        gnome-shell-extension-manager)
            echo -e "${YELLOW}Installing GNOME Shell Extensions...${RESET}"
            safe_run sudo apt install -y gnome-shell-extension-manager
            ;;

        chrome)
            echo -e "${YELLOW}Installing Google Chrome...${RESET}"
            FILE_NAME="$DOWNLOAD_DIR/google-chrome-stable_current_amd64.deb"
            URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
            download_file "$URL" "$FILE_NAME"
            safe_run sudo apt install -y "$FILE_NAME"
            ;;

        nekoray)
            echo -e "${YELLOW}Installing Nekoray...${RESET}"
            FILE_NAME="$DOWNLOAD_DIR/nekoray-4.3.7-2025-07-08-debian-x64.deb"
            URL="https://github.com/throneproj/Throne/releases/download/4.3.7/nekoray-4.3.7-2025-07-08-debian-x64.deb"
            download_file "$URL" "$FILE_NAME"
            safe_run sudo apt install -y "$FILE_NAME"
            ;;

        telegram)
            echo -e "${YELLOW}Installing Telegram Desktop...${RESET}"
            FILE_NAME="$DOWNLOAD_DIR/tsetup.tar.xz"
            URL="https://telegram.org/dl/desktop/linux"
            download_file "$URL" "$FILE_NAME"
            tar -xvf "$FILE_NAME" -C "$DOWNLOAD_DIR" || error_exit "Failed to extract Telegram"
            safe_run sudo mv "$DOWNLOAD_DIR/Telegram" /opt/
            safe_run sudo ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram
            ;;

        grub2-theme)
            echo -e "${YELLOW}Installing Grub2 Themes...${RESET}"
            cd "$DOWNLOAD_DIR"
            if [ ! -d "grub2-themes" ]; then
                safe_run git clone https://github.com/vinceliuice/grub2-themes.git
            fi
            echo -e "${YELLOW}To install a theme, run:${RESET} ${GREEN}$DOWNLOAD_DIR/grub2-themes/install.sh${RESET}"
            cd ~
            ;;

        dash-to-dock)
            echo -e "${YELLOW}For installing Dash to Dock, visit:${RESET} ${GREEN}https://extensions.gnome.org/extension/307/dash-to-dock/${RESET}"
            ;;
    esac
done

echo -e "${GREEN}✅ Installation complete!${RESET}"

