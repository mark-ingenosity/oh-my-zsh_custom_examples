#############################################################################
# HACKS
#############################################################################
#
# Load any hacks that need to happen after loading .zshrc

# HACK (mav) enforcing use of latest node version. Shouldn't need to do this.
nvm use node >/dev/null 2>&1

# HACK (mav) change dir to current pathfinder window using pfinder plugin command cdp
# The Pathfinder cd function is broken in Big Sur
cdp
