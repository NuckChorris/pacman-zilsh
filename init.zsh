CACHETIME=h-6

_pacfiles () {
	_zilsh_debug "  Reading pacfiles cache..."
	PACFILES=$(cat /var/tmp/pacfiles(.m${CACHETIME}) 2>/dev/null)
	if [[ -z ${PACFILES} ]]; then
		_zilsh_debug "  Pacfiles cache missed, refreshing in background..."
		(
			find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" > /var/tmp/pacfiles &
			wait
			_zilsh_debug "  Pacfiles cache reloaded!"
		)
	fi
	_zilsh_debug "  Got pacfiles."
	echo $PACFILES
}
_pacupdates () {
	_zilsh_debug "  Reading updates list..."
	PACUPDATES=$(pacman -Qu)
	_zilsh_debug "  Read updates list."
	echo $PACUPDATES
}
