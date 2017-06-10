# installs Chocolatey and some of the common dependencies needed/desired for software development
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# make sure we’re using the latest Chocolatey
choco upgrade chocolatey

# upgrade any already-installed packages
choco upgrade all

# install packages
apps=(
)

choco install "${apps[@]}"
