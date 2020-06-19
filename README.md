# Dotfiles
My dotfiles.
## Install

This will install all prerequisites + symlink dotfiles; the script will require your password at various points.

Clone this repo:
```bash
git clone --recursive https://github.com/DanDobrick/dotfiles.git ~/.dotfiles
```
Run Install script
```bash
~/.dotfiles/install.sh
```

For manual installation see install.sh

## Githooks
### Ruby
- `pre-commit` runs rubocop for any changed/renamed/added files
- `commit-msg` adds ticket name/number to commit message if formatted like `words/[PROJ-123]/words`
- `pre-commit`* runs rubocop for any changed/renamed/added files
- `pre-push`* runs bundle-audit, preventing a push if the command fails.

>\* denotes commands that run using `bundle exec`

These will NOT be symlinked via the install script or `rcup` so they must be copied manually.

To symlink both ruby hooks to your project in your repo's root folder execute:
```bash
link-ruby-hooks
```

### These hooks below are installed for this repo automatically
- `post-merge` re-establishes symlinks and runs `source ~/.zshrc

## Local Changes
To allow each machine to tweak the individual configuration, the install script creates files in the `/local` folder which will be symlinked to `~` and sourced/copied/etc appropriately depending on the config file. The folder has been `.gitignored` so any changes to the file will _not_ be commited to the repo; edit as you see fit.

Current list of local files:
- `local/gitconfig`
- `local/aliases`

## TODO
- color prompt
- Fix update function for ubuntu, possibly offload to script.
 
