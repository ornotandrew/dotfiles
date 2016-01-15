# Loosely based on lukerandall

local red="%{$fg_bold[red]%}"
local blue="%{$fg_bold[blue]%}"
local green="%{$fg_bold[green]%}"
local yellow="%{$fg[yellow]%}"
local cyan="%{$fg_bold[cyan]%}"
local reset="%{$reset_color%}"

local return_code="%(?..${red}%? ↵$reset)"

function git_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "${yellow}(${ref#refs/heads/}$GIT_STATUS)$reset "
}

local user="$green%n$reset"
local hostname="$green%m$reset"
local working_dir="$blue%2~$reset"
local jobs="%1(j.${cyan}%j$reset .)"
local arrow="%B»%b"

PROMPT='$user@$hostname $working_dir $(git_info)$jobs$arrow '
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

