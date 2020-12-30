#############################################################
# Aliases
#############################################################
#
# Warning: removes all traces of deleted files from repo
alias gitrmdel="git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin"

#############################################################
# Functions
#############################################################
#
gitcfglist() {
	sudo git -c core.editor=ls\ -al config --system --edit
	sudo git -c core.editor=ls\ -al config --global --edit
	sudo git -c core.editor=ls\ -al config --local --edit
	sudo git -c core.editor=ls\ -al config --worktree --edit
}

gitdt() {
	# delete local tag
	git tag -d $1
	# delete remote tag '12345' (eg, GitHub version too)
	git push origin :refs/tags/$1
}
