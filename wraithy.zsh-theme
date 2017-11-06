# Loosely based on lukerandall

local return_code="%(?..%F{red}%? ↵%f)"

function git_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "%F{yellow}(${ref#refs/heads/}$GIT_STATUS)%f "
}

function hg_info() {
    ref=$(hg branch 2> /dev/null) || return
    HG_STATUS=$(hg_prompt_info)
    [[ -n $HG_STATUS ]] && HG_STATUS="$HG_STATUS"
    echo "%F{yellow}($HG_STATUS)%f "
}

function cloud_project() {
    
    kube_cluster_dev=$(kubectl config current-context | grep '.*dev' 2>&1)
    [ -z "$kube_cluster_dev" ] && echo -n "%F{yellow}危%f"
}

local user="%F{green}%n%f"
local hostname="%F{green}%m%f"
local working_dir="%F{blue}%2~%f"
local jobs="%1(j.%F{cyan}%j%f .)"
local arrow="$white❱%f"

PROMPT='$working_dir $(git_info)$(hg_info)$(cloud_project)$jobs$arrow '
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

ZSH_THEME_HG_PROMPT_DIRTY=" *"

