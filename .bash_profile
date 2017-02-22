export PATH="$HOME/bin:$PATH"

# Load other dotfiles
for file in ~/dotfiles/.{path,bash_prompt,exports,aliases,functions,rbenv,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing
shopt -s nocaseglob

# Append to the bash history file
shopt -s histappend

# Autocorret typos in path names
shopt -s cdspell

# Make sure ssh-agent variable are set correctly
eval `ssh-agent` 2>&1 > /dev/null

# Set solorized dircolors
if [ "$(uname )" != "Darwin" ]; then
	eval `dircolors ~/dotfiles/dircolors/dircolors.ansi-dark`
fi

if [ -f ~/.iterm2_shell_integration.bash ]; then
    source ~/.iterm2_shell_integration.bash
fi

# Set to some value in order to disable tmux
tmux=''

case `uname` in
	Linux)
                ;;
        Darwin)
                if [ ! -f ~/notmux ]; then
			if [ -z "$TMUX" ]; then
    				base_session='kwolf'
    				# Create a new session if it doesn't exist
    				tmux has-session -t $base_session || tmux new-session -d -s $base_session
    				# Are there any clients connected already?
    				client_cnt=$(tmux list-clients | wc -l | tr -d ' ')
    				if [ $client_cnt -ge 1 ]; then
        				session_name=$base_session"-"$client_cnt
        				tmux new-session -d -t $base_session -s $session_name
        				tmux -2 attach-session -t $session_name \; set-option destroy-unattached
    				else
        				tmux -2 attach-session -t $base_session
    				fi
			fi
		fi
                ;;
esac

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
