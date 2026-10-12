# Shell-agnostic functions. Sourced by zsh/zshrc and bash/bashrc.
# Completion wiring for these lives in the per-shell rc files.

# MySQL database helpers.
#   db create <name>
#   db drop <name>
#   db refresh <name> <dump.sql>
db() {
	if [ "$1" = "refresh" ]; then
		mysql -uroot -p -e "drop database $2; create database $2; use $2; source $3"
	elif [ "$1" = "create" ]; then
		mysql -uroot -p -e "create database $2"
	elif [ "$1" = "drop" ]; then
		mysql -uroot -p -e "drop database $2"
	fi
}

# Fetch a .gitignore from gitignore.io, e.g. `gi laravel,node > .gitignore`
gi() {
	curl -sL "https://www.toptal.com/developers/gitignore/api/$*"
}

_gitignoreio_get_command_list() {
	curl -sL https://www.toptal.com/developers/gitignore/api/list | tr "," "\n"
}
