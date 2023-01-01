# Use global profile when available
if [ -f /usr/share/defaults/etc/profile ]; then
	. /usr/share/defaults/etc/profile
fi
# allow admin overrides
if [ -f /etc/profile ]; then
	. /etc/profile
fi
# allow user overrides
if [ -f ~/.profile ]; then
	. ~/.profile
fi


source /Users/824363/.docker/init-bash.sh || true # Added by Docker Desktop
