#############################################################################
#	Document Processing
#############################################################################
#

#############################################################################
#	Aliases
#############################################################################
#

#############################################################################
#	Functions
#############################################################################
#

function strreplace {
	echo $1 $2 $3
	perl -pi -e 's/${1}/${2}/g' $3
}

function doc2any() {
	pandoc -s $1 -o $2
}

function md2txt () {
	if [ -z "$1" ]; then
		echo	"Usage: md2txt <input_markdown_file> [output_text_file]"
		return 0
	fi
	if [ -z "$2" ]; then
		fbase=$(basename "$1")
		fname="${fbase%.*}"
		pandoc -f markdown -t plain "$1" -o "${fname}.txt"
	else
		pandoc -f markdown -t plain "$1" -o "$2"
	fi
}

function doc2md () {
	if [ -z "$1" ]; then
		echo	"Usage: anydoc2md <input_docfile> [output_markdown_file]"
		return 0
	fi
	if [ -z "$2" ]; then
		fbase=$(basename "$1")
		fname="${fbase%.*}"
		pandoc -s $1 -t markdown -o "${fname}.md"
	else
		pandoc -s $1 -t markdown -o $2
	fi
}

# tab/space processing
function spaces2tabs() {
	# Punt if there are no arguments
	if [ -z "$1" ] || [ -z "$2" ]; then
		echo "Usage: spaces2tabs <tab_size> <input_file> [output_file]"
		echo "       (if output_file is not specified, input_file will be overwritten.)"
		return 0
	fi

	# If no output file is specified, then overwrite the input file
	if [ -z "$3" ]; then
		unexpand -t $1 < $2 > "${2}.tmp"
		rm $2
		mv "${2}.tmp" $2
	else
		unexpand -t $1 < $2 > $3
	fi
}

function tabs2spaces() {
	# Punt if there are no arguments
	if [ -z "$1" ] || [ -z "$2" ]; then
		echo "Usage: tabs2spaces <tab_size> <input_file> [output_file]"
		echo "       (if output_file is not specified, input_file will be overwritten.)"
		return 0
	fi

	# If no output file is specified, then overwrite the input file
	if [ -z "$3" ]; then
		expand -t $1 < $2 > "${2}.tmp"
		rm $2
		mv "${2}.tmp" $2
	else
		expand -t $1 < $2 > $3
	fi
}

