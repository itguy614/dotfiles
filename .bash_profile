export PATH="$HOME/bin:$PATH"

# Load other dotfiles
for file in ~/dotfiles/.{path,bash_prompt,exports,aliases,functions,extra}; do
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
eval `ssh-agent`
