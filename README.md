# `~/dotfiles`

⚡️ I mostly use the [`alacritty`](https://github.com/jwilm/alacritty/) terminal cause it's fast, together with [`zsh`](http://zsh.sourceforge.net/), [`tmux`](https://github.com/tmux/tmux/), [`neovim`](https://neovim.io/) and [`fzf`](https://github.com/junegunn/fzf/) as my glued together wannabe IDE.

## Under construction

> I am currentyl migrating from `brew` and symlinks to using [`nix`](https://nixos.org/nix/manual) together with [`home-manager`](https://github.com/rycee/home-manager)

## Old news below

🍺 I use [`brew`](https://brew.sh/) together with [`brew cask`](https://github.com/Homebrew/homebrew-cask/) to install packages and applications when I can. I try to keep as many tools as possible UNIX-compatible because you never know when I move to `GNU/Linux`.

👨‍💻 My day job consists of frontend work in JavaScript/TypeScript and React. I use [`coc-nvim`](https://github.com/neoclide/coc.nvim/) which works as a intellisense engine, [`LSP`](https://langserver.org/) host and [`supports VSCode extensions`](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions/).

🚴‍♂️ When I'm not working I'm busy bikeshedding these `~/dotfiles`, and stumbling around doing functional programming in OCaml, Haskell and more.

🐫 For OCaml I use [`bucklescript`](https://bucklescript.github.io/) and [`esy`](https://esy.sh/).

🌯 For Haskell I use [`stack`](https://docs.haskellstack.org/).

More should be written here, okay? thx!

# `installation`

Install with determine systems

Build flake
```
cd ~/dotfiles
nix build .#darwinConfigurations.p1xelBook.system
./result/sw/bin/darwin-rebuild switch --flake .  
```

results in ERROR:

```
error: Directory /run does not exist, aborting activation
Create a symlink to /var/run with:

$ printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
$ /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -B # For Catalina
$ /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t # For Big Sur and later
```

run provided commands:

```
p1xelher0@p1xelBook dotfiles % printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
run	private/var/run
p1xelher0@p1xelBook dotfiles % /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t 
failed to stitch firmlinks and/or create synthetics for root volume (c00d) ...
p1xelher0@p1xelBook dotfiles % sudo /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

build again:

```
p1xelher0@p1xelBook dotfiles % ./result/sw/bin/darwin-rebuild switch --flake .                    
warning: Git tree '/Users/p1xelher0/dotfiles' is dirty
building the system configuration...
warning: Git tree '/Users/p1xelher0/dotfiles' is dirty
user defaults...
setting up user launchd services...
setting up /Applications/Nix Apps...
setting up pam...
applying patches...
setting up /etc...
error: not linking environment.etc."bashrc" because /etc/bashrc already exists, skipping...
existing file has unknown content 08ffbf991a9e25839d38b80a0d3bce3b5a6c84b9be53a4b68949df4e7e487bb7, move and activate again to apply
error: not linking environment.etc."nix/nix.conf" because /etc/nix/nix.conf already exists, skipping...
existing file has unknown content 4e8e3aa53fd9189aba36c407ae4e5ac554b1c7a376953f4c6896d42a4a6382a9, move and activate again to apply
system defaults...
setting up launchd services...
reloading service org.nixos.activate-system
reloading service org.nixos.nix-daemon
reloading nix-daemon...
waiting for nix-daemon
waiting for nix-daemon
configuring networking...
```

At this point I ran the official uninstaller just to make sure everything was gone

```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A uninstaller
./result/bin/darwin-uninstaller
```

rebooting ...

build flake again just to be sure

```
p1xelher0@p1xelBook dotfiles % nix build .#darwinConfigurations.p1xelBook.system
```

install it

```
p1xelher0@p1xelBook dotfiles % ./result/sw/bin/darwin-rebuild switch --flake .
warning: Git tree '/Users/p1xelher0/dotfiles' is dirty
building the system configuration...
warning: Git tree '/Users/p1xelher0/dotfiles' is dirty
Password:
user defaults...
setting up user launchd services...
setting up /Applications/Nix Apps...
setting up pam...
applying patches...
setting up /etc...
error: not linking environment.etc."bashrc" because /etc/bashrc already exists, skipping...
existing file has unknown content 08ffbf991a9e25839d38b80a0d3bce3b5a6c84b9be53a4b68949df4e7e487bb7, move and activate again to apply
error: not linking environment.etc."nix/nix.conf" because /etc/nix/nix.conf already exists, skipping...
existing file has unknown content 4e8e3aa53fd9189aba36c407ae4e5ac554b1c7a376953f4c6896d42a4a6382a9, move and activate again to apply
system defaults...
setting up launchd services...
creating service org.nixos.activate-system
reloading service org.nixos.nix-daemon
reloading nix-daemon...
waiting for nix-daemon
waiting for nix-daemon
configuring networking...
```

nix-darwin needs /etc/nix/nix.conf

This is an open issue: https://github.com/LnL7/nix-darwin/issues/149

lets move the nix.conf, zsh, bash and shells files

```
sudo mv /etc/bashrc /etc/bashrc.orig
sudo mv /etc/zshrc /etc/zshrc.orig
sudo mv /etc/shells /etc/shells.orig
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.orig
```

run the installer again:

```
nix build .#darwinConfigurations.p1xelBook.system
darwin-rebuild switch --flake .

The previous generation number and path are in conflict! These
must be either both empty or both set but are now set to

    '252' and ''

If you don't mind losing previous profile generations then
the easiest solution is probably to run

   rm /Users/p1xelher0/.local/state/nix/profiles/home-manager*
   rm /Users/p1xelher0/.local/state/home-manager/gcroots/current-home
```

run those and try again, I don't care about my old generations

```
Error: HOME is set to "/Users/p1xelher0" but we expect "/var/empty"
```

set the home in nix-darwin

`users.users.p1xelher0.home = "/Users/p1xelher0";`


rebuild

```
Error: HOME is set to "/Users/p1xelher0" but we expect "/var/empty"
```

SUCCESS, reboot

The only thing I dont understand right now is that when I enable the home-manager zsh the darwin-* programs are removed from the path ie I cant use darwin-rebuild and have to use the ./result - need to fix this

Wait this actually works after a reboot resource of shell or whatever. It IS CORRECT.

