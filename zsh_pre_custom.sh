#############################################################
# zsh_pre_custom
# Load any customizations that need to happen before loading
# the default oh-my-zsh environment
#############################################################
#

# Set location of zcompdump to ZSH_CUSTOM/logs
# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${ZSH_CUSTOM}}/logs/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# source custom plugins before running oh-my-zsh.sh
# this needs to happen beforehand or $plugins will not be defined
source $ZSH_CUSTOM/plugins.zsh
