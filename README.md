# README

# How to use chezmoi with devpods

```
devpod up . --recreate --dotfiles https://github.com/Max-LAB/dotfiles.git
```

```
devpod ssh .
```

# How to install chezmoi

```
sudo apt install chezmoi
snap install chezmoi --classic
```

## How to delete chezmoi state

```
chezmoi state reset
```

```sh
chezmoi status 
# Gives a quick summary of what files would change if you ran chezmoi apply.
```

```sh
hezmoi init --apply Max-LAB
```