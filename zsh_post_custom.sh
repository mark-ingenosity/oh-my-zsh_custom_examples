#############################################################
# zsh_post_custom
# Load any customizations that need to happen before loading
# the default oh-my-zsh environment
#############################################################
#

# --------------- direnv ---------------
# load direnv environment
eval "$(direnv hook zsh)"

# fix the python virtualenv prompt
setopt PROMPT_SUBST
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env) '$PS1
# ------------- end direnv -------------
