FLAGS=$1
# Replace tmux window flag for a unicode character:
# *: current window flag removed
FLAGS=${FLAGS//\*/}
# -: last window flag removed
FLAGS=${FLAGS//-/}
# #: window activity flag replaced by 
FLAGS=${FLAGS//\##/}
# ~: window silence flag removed
FLAGS=${FLAGS//\~/}
# !: window bell flag removed
FLAGS=${FLAGS//\!/}
# Z: window zoomed flag removed
FLAGS=${FLAGS//Z/}

echo ${FLAGS}
