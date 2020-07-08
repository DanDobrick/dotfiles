# Dotfiles
My dotfiles. Uses Thoughtbot's [rcm](https://github.com/thoughtbot/rcm) to symlink files in this repo to your home directory. See the [rcm documentation](https://thoughtbot.github.io/rcm/rcm.7.html) for more information.

## Install

### Clone this repo:
```bash
$ git clone --recursive https://github.com/DanDobrick/dotfiles.git ~/.dotfiles
```

### Run the install script

This will install all prerequisites + symlink dotfiles; the script will require your password at various times. Please check out [install.sh](https://github.com/DanDobrick/dotfiles/blob/master/install.sh) to see what it's doing before inputting any sensitive info while installing.
```bash
$ ~/.dotfiles/install.sh
```

For manual installation see [install.sh](https://github.com/DanDobrick/dotfiles/blob/master/install.sh) and tweak as you see fit.

## Githooks

A single githook (`post-merge`) is automatically symlinked for this repo; it re-establishes symlinks and runs `source ~/.zshrc` each time you merge a commit. It's intended to ensure that any changes/addtions to this repo are automatically picked up when pulling down master.

All other hooks will NOT be symlinked via the install script or `rcup` so they must be copied manually:

### Ruby
#### Available Hooks
- `commit-msg` adds ticket name/number to commit message if formatted like `words/[PROJ-123]/words`
- `pre-commit`* runs rubocop for any changed/renamed/added files
- `pre-push`* runs bundle-audit, preventing a push if the command fails.

>\* denotes commands that run using `bundle exec`

#### Installing
To link one or more hooks individually add them to the command as arguments:

```bash
$ link-ruby-hooks pre-commit commit-msg
```

To symlink all ruby hooks to your project in your repo's root folder execute the command without any arguments:
```bash
$ link-ruby-hooks
```

## Local Changes
To allow each machine to tweak its configuration, the install script creates files in the `/local` folder which will be symlinked to your home dir (`~`) and sourced/copied/etc appropriately depending on the config file. The folder has been `.gitignore`'d so any changes to the file will _not_ be commited to the repo; edit as you see fit.

List of local files supported:
- `local/gitconfig`
- `local/aliases`
- `local/functions`

## TODO
- Default files for ^^ so there is not an error as files are added to this list ^^ and install script is not run.
