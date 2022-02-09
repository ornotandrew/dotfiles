kpatch() {
    kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
}

pjq() {
    sed 's/'\''/"/g' | sed 's/None/null/g' | sed 's/True/true/g' | sed 's/False/false/g' | jq
}

urldecode() {
  echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

gch() {
  git checkout "$(git branch --all | sed 's/remotes\/origin\///' | sort -u | fzf | tr -d '[:space:]')"
}

source-env () {
    set -o allexport
    source $1
    set +o allexport
}

sba() {
    [ -d env/ ] && source env/bin/activate
    [ -d .venv/ ] && source .venv/bin/activate

    [ -f env/vars.sh ] && source env/vars.sh
    [ -f .venv/vars.sh ] && source .venv/vars.sh
    [ -f .env ] && source-env .env
}

ecr-login() {
    aws ecr get-login-password | docker login --username AWS --password-stdin 209241478618.dkr.ecr.us-east-1.amazonaws.com
}

# for advent-of-code 2021
aoc () {
    OUT=$(cat input.txt | cargo run -q --bin part_${1})
    echo $OUT | clip
    echo $OUT
}
