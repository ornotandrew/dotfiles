# Loosely based on lukerandall

local return_code="%(?..%F{red}%? ↵%f)"

function git_info() {
    ref=$(git symbolic-ref --quiet HEAD 2> /dev/null) || return
    GIT_STATUS="$(git_prompt_status)"
    # add a space
    [ "$GIT_STATUS" != "" ] && GIT_STATUS=" $GIT_STATUS"
    echo "%F{yellow}(${ref#refs/heads/}$GIT_STATUS)%f "
}

local user="%F{green}%n%f"
local hostname="%F{green}%m%f"
local working_dir="%F{blue}%2~%f"
local jobs="%1(j.%F{cyan}%j%f .)"
local arrow="$white❱%f"

PROMPT='$working_dir $(git_info)$jobs$arrow '
# RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
