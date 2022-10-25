# If not running interactively, don't do anything
[ -z "$PS1" ] && return

/etc/hello-msg.sh

force_color_prompt=yes

# Don't put duplicate lines in the history and do not add lines that start with a space
HISTCONTROL=erasedups:ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200
HISTFILESIZE=400

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Colorized ls.
LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS'

# Searches for text in all files in the current folder
ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" .
}

function returncode
{
  returncode=$?
  if [ $returncode != 0 ]; then
    echo "[$returncode] "
  else
    echo ""
  fi
}

_PS1 ()
{
    local PRE= NAME="$1" LENGTH="$2";
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}
PS1='$(returncode)\u@\h:$(_PS1 "$PWD" 20)\$ '
