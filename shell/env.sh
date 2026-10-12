# Environment shared by every shell. Sourced by zsh/zshrc and bash/bashrc.

# Drop every occurrence of $1 from PATH.
path_remove() {
	_pr_out=''
	_pr_rest="$PATH:"
	while [ -n "$_pr_rest" ]; do
		_pr_item="${_pr_rest%%:*}"
		_pr_rest="${_pr_rest#*:}"
		[ -z "$_pr_item" ] && continue
		[ "$_pr_item" = "$1" ] && continue
		_pr_out="${_pr_out:+$_pr_out:}$_pr_item"
	done
	PATH="$_pr_out"
	unset _pr_out _pr_rest _pr_item
}

# Move $1 to the front of PATH. This removes first rather than skipping when
# the entry already exists: Omarchy's env-bootstrap *appends* ~/.local/bin, and
# a plain dedupe would leave it stranded at the tail behind ./bin.
path_prepend() {
	path_remove "$1"
	PATH="$1${PATH:+:$PATH}"
}

path_append() {
	path_remove "$1"
	PATH="${PATH:+$PATH:}$1"
}

# Lowest priority first — each prepend pushes the previous entry down.
path_prepend "$HOME/bin"
path_prepend "$HOME/.composer/vendor/bin"
path_prepend "/usr/local/sbin"
path_prepend "/usr/local/bin"
path_prepend "./vendor/bin"
path_prepend "./bin"
path_prepend "$HOME/.local/bin"
export PATH

export EDITOR=nvim
export VISUAL=nvim

# GnuPG
export GPG_TTY=$(tty)
export GPGKEY=8060A02E
