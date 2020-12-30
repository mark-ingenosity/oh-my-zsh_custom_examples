#############################################################################
# Development
#############################################################################
#
#############################################################################
#	Development Environment
#############################################################################
#
export DEVENV_CONF="$HOME/.config/devenv"

#############################################################################
#	direnv
#############################################################################
#
# HACK: source a zsh modified direnv "stdlib.sh" so it can be used in the
# context of the current zsh
if [[ -f $DEVENV_CONF/direnv.stdlib.zsh ]]; then
	source "$DEVENV_CONF/direnv.stdlib.zsh"
fi

#############################################################################
#	direnv
#############################################################################
#
alias cleandirenv="rm ~/.local/share/direnv/allow/*"
alias updirenv="rm -rf ./.direnv && direnv && direnv allow"

#############################################################################
#	Aliases
#############################################################################
#
alias lstart='lighttpd -D -f /Users/<username>/Sites/conf/mac/lighttpd.conf'
alias apstart='sudo apachectl start'
alias apstop='sudo apachectl stop'
alias aprestart='sudo apachectl restart'
alias uninstall_node='cd ~;for package in `ls node_modules`; do npm uninstall $package; done;'
alias npmlist='npm list -depth=1'
alias uppip='python3 -m pip install --upgrade pip' # upgrade pip

############################################################################
# Python
#############################################################################
#
# Python environment
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
# Python virtual environment
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

#############################################################################
# nvm/npm/node
#
# - This must come after initializing PATH as nvm will automatically
#   update PATH to the latest node version.
# - Also see $SZSH_CUSTOM/zsh_hacks.sh for hacks necessary to the nvm/node
#   environment
#############################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export NODE_PATH="~/.node_modules"

# Deprecated: from using python -m venv to direnv local_python3 to create/config
# Python virtualenv
#alias pyvinit='python -m venv .; source ./bin/activate'
#alias pyvact='source ./bin/activate'

#############################################################################
# Functions
#############################################################################
#

# uppippkg(): upgrade all python packages installed by pip
function uppippkg() {
	for i in $(pip list | awk 'NR > 2 {print $1}'); do
		echo Updating ${i}
		pip install --upgrade $i
	done
}

# initdevenv(): Initialize dev environment for specified language using direnv
# This function needs quite a bit of expansion to check for the existence of an existing
# project and then either punt or fill in the gaps without overwriting an existing
# configuration.
#
function initdevenv() {

	######################################
	# Project directories to be created
	######################################
	projdirs=(config scripts assets doc build data test bak)

	# Punt if there are no arguments
	if [ -z "$1" ]; then
		echo "Usage: initdevenv <target_lang>"
		return 0
	fi

	# Quick and dirty test to check if a project already exists.
	# This is a sloppy check and needs to be expanded to check for full project config
	# file/folder existence. Also, need a couple of command line switches to 1) create
	# project config files/folders that don't exist and 2) overwrite existing project
	# config files/folders if they do exist.
	#
	if [[ -d ".direnv" ]]; then
		echo "Warning: It looks like a direnv managed project may already exist here. Examine .direnv folder."
		return 0
	fi

	# Create .conf and envrc if they don't exist, else warn the user
	if [[ ! -d ".conf" ]] && [[ ! -f ".envrc" || ! -h ".envrc" ]]; then
		mkdir .conf
		if [ $1 = "python3" ]; then
			echo "layout_python3" >./.conf/envrc

		elif [ $1 = "python2" ]; then
			echo "layout_python2" >./.conf/envrc

		elif [ $1 = "ruby" ]; then
			echo "layout_ruby" >./.conf/envrc

		else
			echo "Language not supported:" $1
			rm -rf .conf
			return
		fi

		# prepend the assets folder to the PATH
		echo "PATH_add assets" >>./.conf/envrc

	else
		echo "Warning: It looks like a configuration folder .conf or .envrc file already exists."
	fi

	# Create the baseline project structure
	mkdir ${projdirs} >/dev/null 2>&1
	touch assets/notes.txt
	touch README.md
	if [[ ! -d ".vscode" ]]; then cp -r "$DEVENV_CONF/vscode" ./.conf/vscode && ln -s ./.conf/vscode ./.vscode; fi
	if [[ ! -f ".gitignore" ]]; then cp "$DEVENV_CONF/gitignore" ./.conf/gitignore && ln -s ./.conf/gitignore ./.gitignore; fi
	if [[ ! -f ".editorconfig" ]]; then cp "$DEVENV_CONF/editorconfig" ./.conf/editorconfig && ln -s ./.conf/editorconfig ./.editorconfig; fi
	if [[ ! -f ".envrc" ]]; then ln -s ./.conf/envrc ./.envrc; fi
	if [[ ! -f "assets/notes.txt" ]]; then ln -s ./assets/notes.txt ./notes.txt; fi

	# Initialize direnv virtualenv
	sleep 2
	direnv allow

	# Initialize git environment
	git init
}

# initdevenv(): Initialize dev environment for specified language using direnv
# This function needs quite a bit of expansion to check for the existence of an existing
# project and then either punt or fill in the gaps without overwriting an existing
# configuration.
#
function initbuildenv() {

}
