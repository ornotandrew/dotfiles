# Loosely based on lukerandall

# git clone https://github.com/romkatv/gitstatus.git ~/.gitstatus
source ~/.gitstatus/gitstatus.prompt.zsh

function git_info() {
    [[ "$VCS_STATUS_RESULT" == ok-sync ]] || return
    local branch_or_commit=${VCS_STATUS_LOCAL_BRANCH:-"@${VCS_STATUS_COMMIT:0:12}"}
    local file_status=""
    [[ "$VCS_STATUS_HAS_STAGED"    == 1 ]] && file_status="${file_status}+"
    [[ "$VCS_STATUS_HAS_UNSTAGED"  == 1 ]] && file_status="${file_status}*"
    [[ "$VCS_STATUS_HAS_UNTRACKED" == 1 ]] && file_status="${file_status}%%"
    [[ -n "$file_status" ]] && file_status=" ${file_status}"
    echo "%F{yellow}(${branch_or_commit}${file_status})%f "
}

local user="%F{green}%n%f"
local hostname="%F{green}%m%f"
local working_dir="%F{blue}%2~%f"
local jobs="%1(j.%F{cyan}%j%f .)"
local arrow="%F{white}❱%f"

PROMPT='$working_dir $(git_info)$jobs$arrow '
