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

sba() {
    source env/bin/activate
    [ -f env/vars.sh ] && source env/vars.sh
}

ecr-login() {
    aws ecr get-login-password | docker login --username AWS --password-stdin 209241478618.dkr.ecr.us-east-1.amazonaws.com
}
