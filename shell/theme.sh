# Sourced after the platform layer: Omarchy's own envs set BAT_THEME=ansi, and
# this has to win. Not in env.sh, which loads before it.

# bat (and delta, which honours it) follow the theme manager's active theme, or
# on Omarchy the exported theme it applied (see `theme export-omarchy`).
for _bat_theme in \
	"${XDG_STATE_HOME:-$HOME/.local/state}/themes/current/bat.theme" \
	"${XDG_STATE_HOME:-$HOME/.local/state}/omarchy/current/theme/bat.theme"; do
	[ -r "$_bat_theme" ] && { export BAT_THEME="$(cat "$_bat_theme")"; break; }
done
unset _bat_theme
