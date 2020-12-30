# oh-my-zsh Customizations

This is a collection of customizations for `oh-my-zsh` which groups zsh configuration content by function. For example, the file development.zsh contains environment variables, aliases and functions that are specific to software-development tasks.

oh-my-zsh sources this custom content via the `ZSH_CUSTOM` environment variable exported in `.zshrc`. To start using these customizations simply customize and copy the various files to your ZSH_CUSTOM folder and edit your .zshrc to include any of the customizations found in the included `zshrc.example` file..

## Custom zsh Configuration Files

| Command              | Description                                                  |
| :------------------- | :----------------------------------------------------------- |
| `zshrc.example`      | example .zshrc file customized for loading the content described in this document |
| `apps.zsh`           | application specific settings                                |
| `development.zsh`    | software development specific settings                       |
| `documents.zsh`      | document management settings                                 |
| `git.zsh`            | git specific settings                                        |
| `history.zsh`        | zsh history control and management                           |
| `miscellaneous.zsh`  | zsh settings that don't fit in anywhere else                 |
| `options.zsh`        | oh-my-zsh options (moved from the default .zshrc that gets installed by oh-my-zsh) |
| `plugins.zsh`        | oh-my-zsh plugin configuration and management                |
| `system.zsh`         | system related settings such as shorthand aliases for builtin commands (ex. alias ll=ls -al) |
| `themes.zsh`         | oh-my-zsh theme related settings                             |
| `zsh_hacks.sh`       | used to temporarily fix things broken elsewhere. This is the last thing to get sourced in .zshrc |
| `zsh_post_custom.sh` | zsh customizations that need to happen before the oh-my-zsh environment is loaded (sourced in .zshrc) |
| `zsh_pre_custom.sh`  | zsh customizations that need to happen after the oh-my-zsh environment is loaded (sourced in .zshrc) |

## GitHub

This project can be found on GitHub at [oh-my-zsh Customizations](https://github.com/mark-ingenosity/oh-my-zsh-plugin-pathfinder.git)

