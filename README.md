#  App Installer Script
A simple and interactive Bash script for Ubuntu/Debian-based Linux distributions to install common apps and tools using a GUI-based checklist.
This script uses whiptail for a terminal-based selection menu and automates package installation with error handling and logging.
<br><br>
# Features<br>
✅ Interactive menu using whiptail<br>
✅ Install multiple apps in one run<br>
✅ Automatic download and installation of .deb packages<br>
✅ Error handling for failed commands<br>
✅ Prevents duplicate downloads<br>
✅ Logging support (optional)<br>
✅ Clear instructions for apps requiring manual setup (e.g., Dash-to-Dock, Grub themes)<br>
<br>
# Apps Supported<br>
Upgrade: Upgrade all system packages
<br><br>
GNOME Tweaks: Customize GNOME desktop
<br><br>
GNOME Shell Extension Manager
<br><br>
Google Chrome
<br><br>
Nekoray Proxy Client
<br><br>
Telegram Desktop
<br><br>
Grub2 Themes
<br><br>
Dash-to-Dock Extension
<br><br>
# Requirements<br>
Before running the script, make sure you have:
<br><br>
Ubuntu/Debian-based Linux
<br><br>
sudo privileges
<br><br>
Internet connection
<br><br>
# Installation<br>
Clone the repository:
<br><br>

git clone https://github.com/<your-username>/app-installer.git<br>
cd app-installer<br>
Make the script executable:<br>
<br><br>
chmod +x app-installer.sh<br>
Run the script:<br>
<br>
<br>
./app-installer.sh<br>
Follow the on-screen instructions<br>
A GUI checklist will appear; use Space to select apps and Enter to install.
<br><br>
Logging
By default, the script will show output in the terminal.<br>
If you want to log everything into a file:

<br><br>
./app-installer.sh | tee ~/installer.log<br>
Example Run<br>
<br>
(Optional: Add a screenshot of the whiptail menu here)
<br><br>
Post-Installation Notes<br>
Grub2 Themes:<br>
After running the script:<br>
<br><br>
cd ~/Downloads/grub2-themes<br>
./install.sh<br>
Follow the prompts to select your preferred boot theme.<br>
<br><br>
Dash-to-Dock:<br>
Visit: Dash-to-Dock Extension and install it via your browser.<br>
<br><br>
Contributing<br>
Pull requests are welcome!<br>
If you want to add more apps or improve the script, please submit a PR or open an issue.<br>
<br>
License<br>
This project is licensed under the MIT License.
