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

The only thing I dont understand right now is that when I enable the home-manager zsh the darwin-\* programs are removed from the path ie I cant use darwin-rebuild and have to use the ./result - need to fix this

Wait this actually works after a reboot resource of shell or whatever. It IS CORRECT.

---

λ ./nix-installer uninstall
`nix-installer` needs to run as `root`, attempting to escalate now via `sudo`...
Password:
Nix uninstall plan (v0.11.0)

Planner: macos (with default settings)

Planned actions:

- Unconfigure Nix daemon related settings with launchctl
- Unconfigure the shell profiles
- Remove the Nix configuration in `/etc/nix/nix.conf`
- Unset the default Nix profile
- Remove time machine exclusions
- Remove Nix users and group
- Remove the directory tree in `/nix`
- Remove the APFS volume `Nix Store` on `disk1`

Proceed? ([Y]es/[n]o/[e]xplain): y
INFO Revert: Remove directory `/nix/temp-install-dir`
INFO Revert: Configure Nix daemon related settings with launchctl
INFO Revert: Configure Nix
INFO Revert: Configure Time Machine exclusions
INFO Revert: Create build users (UID 300-332) and group (GID 30000)
INFO Revert: Provision Nix
INFO Revert: Create an encrypted APFS volume `Nix Store` for Nix on `disk1` and add it to `/etc/fstab` mounting on `/nix`
ERROR Uninstallation complete, some errors encountered
Error:
0: Error reverting
0: Action `configure_nix` errored
Multiple child errors

      Action `configure_shell_profile` errored
      Multiple child errors

      Action `create_or_insert_into_file` errored
      Open path `/etc/bashrc`

      Action `create_or_insert_into_file` errored
      Open path `/etc/zshrc`


      Action `create_or_merge_nix_config` errored
      Remove file `/etc/nix/nix.conf`


      Action `create_apfs_volume` errored
      Failed to execute command with status 1 `"/usr/sbin/diskutil" "apfs" "deleteVolume" "Nix Store"`, stdout: Started APFS operation
      Deleting APFS Volume from its APFS Container
      Unmounting disk1s7
      The volume "Nix Store" on disk1s7 couldn't be unmounted because it is in use by process 694 (com.apple.Virtualization.VirtualMachine)

      stderr: Error: -69888: Couldn't unmount disk

0:

Location:
src/cli/subcommand/uninstall.rs:192

Backtrace omitted. Run with RUST_BACKTRACE=1 environment variable to display it.
Run with RUST_BACKTRACE=full to include source snippets.

Consider reporting this error using this URL: https://github.com/DeterminateSystems/nix-installer/issues/new?title=%3Cautogenerated-issue%3E&body=%23%23+Error%0A%60%60%60%0AError%3A+%0A+++0%3A+Error+reverting%0A+++0%3A+Action+%60configure_nix%60+errored%0A++++++Multiple+child+errors%0A%0A++++++Action+%60configure_shell_profile%60+errored%0A++++++Multiple+child+errors%0A%0A++++++Action+%60create_or_insert_into_file%60+errored%0A++++++Open+path+%60%2Fetc%2Fbashrc%60%0A%0A++++++Action+%60create_or_insert_into_file%60+errored%0A++++++Open+path+%60%2Fetc%2Fzshrc%60%0A%0A%0A++++++Action+%60create_or_merge_nix_config%60+errored%0A++++++Remove+file+%60%2Fetc%2Fnix%2Fnix.conf%60%0A%0A%0A++++++Action+%60create_apfs_volume%60+errored%0A++++++Failed+to+execute+command+with+status+1+%60%22%2Fusr%2Fsbin%2Fdiskutil%22+%22apfs%22+%22deleteVolume%22+%22Nix+Store%22%60%2C+stdout%3A+Started+APFS+operation%0A++++++Deleting+APFS+Volume+from+its+APFS+Container%0A++++++Unmounting+disk1s7%0A++++++The+volume+%22Nix+Store%22+on+disk1s7+couldn%27t+be+unmounted+because+it+is+in+use+by+process+694+%28com.apple.Virtualization.VirtualMachine%29%0A%0A++++++stderr%3A+Error%3A+-69888%3A+Couldn%27t+unmount+disk%0A%0A%0A%0A%60%60%60%0A%0A%23%23+Metadata%0A%7Ckey%7Cvalue%7C%0A%7C--%7C--%7C%0A%7C**version**%7C0.11.0%7C%0A%7C**os**%7Cmacos%7C%0A%7C**arch**%7Cx86_64%7C%0A
/nixX 14s


# LATEST INSTALL


```
Install the Determinate thing too
Set nix.enable = false; because Determinate manages it
Remove crashing shit like eslint
p1xelher0@p1xelBook dotfiles % nix build .#darwinConfigurations.p1xelBook.system
Follow https://docs.determinate.systems/getting-started/individuals/
```
