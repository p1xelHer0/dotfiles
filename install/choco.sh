# Installs Chocolatey and some of the common dependencies needed/desired for software development
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Make sure we’re using the latest Chocolatey
choco upgrade chocolatey

# Upgrade any already-installed packages
choco upgrade all

# Install packages
apps=(
  neovim
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup