# Platform detection shared by `install`, the helper scripts, and the shell rc
# files. POSIX sh so it can be sourced from bash and zsh alike.

# Print the platform chain, most specific first.
#
#   Omarchy   -> "omarchy arch linux"
#   Ubuntu    -> "ubuntu debian linux"
#   Fedora    -> "fedora linux"
#   macOS     -> "macos"
#
# The chain drives two things: which `<name>.<platform>` variant wins, and
# which branch the dependency installer takes.
dotfiles_platform_chain() {
	case "$(uname -s)" in
		Darwin*) printf 'macos\n'; return 0 ;;
		CYGWIN*|MINGW*|MSYS_NT*) printf 'windows\n'; return 0 ;;
		Linux*) ;;
		*) printf 'default\n'; return 0 ;;
	esac

	id=''
	id_like=''
	if [ -r /etc/os-release ]; then
		# Subshell so the os-release vars never leak into the caller.
		id=$(. /etc/os-release >/dev/null 2>&1; printf '%s' "${ID:-}")
		id_like=$(. /etc/os-release >/dev/null 2>&1; printf '%s' "${ID_LIKE:-}")
	fi

	chain=''
	[ -n "$id" ] && chain="$id"

	# ID_LIKE is space separated and ordered general-to-specific already.
	for parent in $id_like; do
		case " $chain " in
			*" $parent "*) ;;
			*) chain="${chain:+$chain }$parent" ;;
		esac
	done

	case " $chain " in
		*" linux "*) ;;
		*) chain="${chain:+$chain }linux" ;;
	esac

	printf '%s\n' "$chain"
	unset id id_like chain parent
}

# True when $1 appears anywhere in the platform chain.
dotfiles_platform_is() {
	case " $(dotfiles_platform_chain) " in
		*" $1 "*) return 0 ;;
		*) return 1 ;;
	esac
}

# Echo the path of the most specific existing "<dir>/<base>.<platform>"
# variant, or return 1 when the chain matches nothing.
dotfiles_variant() {
	_dv_dir=$1
	_dv_base=$2
	for _dv_p in $(dotfiles_platform_chain); do
		if [ -e "$_dv_dir/$_dv_base.$_dv_p" ]; then
			printf '%s\n' "$_dv_dir/$_dv_base.$_dv_p"
			unset _dv_dir _dv_base _dv_p
			return 0
		fi
	done
	# Fall back to an explicit ".default" variant when the chain matches none.
	if [ -e "$_dv_dir/$_dv_base.default" ]; then
		printf '%s\n' "$_dv_dir/$_dv_base.default"
		unset _dv_dir _dv_base _dv_p
		return 0
	fi
	unset _dv_dir _dv_base _dv_p
	return 1
}
