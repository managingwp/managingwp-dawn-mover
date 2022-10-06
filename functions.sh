# shellcheck disable=SC3033,SC3010
# Functions
# ----------------------------------------------------
# github.com/managingwp/prime-mover-reborn.sh - v0.0.1
#
# Original created by Patrick Gallagher (PrimeMover.io)
# -----------------------------------------------------

# -- Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
BLUEBG="\033[0;44m"
YELLOWBG="\033[0;43m"
GREENBG="\033[0;42m"
DARKGREYBG="\033[0;100m"
ECOL="\033[0;0m"

# -- Error and other handling functions
_error () { echo -e "${RED}** ERROR ** - $* ${ECOL}"; }
_success () { echo -e "${GREEN}** SUCCESS ** - $* ${ECOL}"; }
_running () { echo -e "${BLUEBG}${*}${ECOL}"; }
_creating () { echo -e "${DARKGREYBG}${*}${ECOL}"; }
_separator () { echo -e "${YELLOWBG}****************${ECOL}"; }
_debug () { if [[ $DEBUG == "1" ]]; then echo -e "${CYAN}** DEBUG: ${*}${ECOL}"; fi }
usage () { echo "$USAGE"; }

# --------------------
# -- General Functions
# --------------------

# -- pre-flight-check - nil - run require checks
pre-flight-check () {
  # - Checks
  if [[ $NO_ROOT == 1 ]]; then
    _debug "Bypassing root check"
  else
    if [[ $EUID -ne 0 ]]; then
      _error "This script must be run as root, exiting!!!"
      exit 1
    fi
  fi

  # Check is PV is installed, and install if needed...
  if ! command "pv" &> /dev/null; then
	  _error "pv not installed, please install using 'apt -y install pv'"
	  exit 1
  fi
}

if [ -a ]

# -- make-temp-dir - nil - create temp directpry
make-temp-dir () {
  _debug "Checking for temp directory at $TMP_DIR"
  if [[ -d $TMP_DIR ]]; then
    _error "Found existing temp directory at $TMP_DIR, remove before continuing"
  else
    _debug "Making temp directory at $TMP_DIR"
    mkdir -p $TMP_DIR
  fi
}

# -- _logfile - nil - log to file.
_logfile () {
  echo "$@" >> $LOG_FILE
}

# -- generate random character
generate-random-char () {
  cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-8} | head -n 1
}

