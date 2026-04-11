CURRENT_CONTEXT=$(kubectl config current-context)
case $CURRENT_CONTEXT in
    "rancher-desktop"|"docker-desktop")
        ENV="local"
        PERMISSIONS="rw"
        ;;
    "staging-read")
        ENV="staging"
        PERMISSIONS="r"
        ;;
    "staging-write")
        ENV="staging"
        PERMISSIONS="rw"
        ;;
    "prod-read")
        ENV="prod"
        PERMISSIONS="r"
        ;;
    "prod-write")
        ENV="prod"
        PERMISSIONS="rw"
        ;;
    *)
        ENV="unknown"
        ;;
esac

case $PERMISSIONS in
    "r")  EMOJI="🟢" ;;
    "rw") EMOJI="🟡" ;;
    *)    EMOJI="❓" ;;
esac

case $ENV in
    "local")
      DESCRIPTION="LOCAL"
      COLOR="dim,fg=color10"
      # Special case for local dev - we don't want a scary emoji there
      EMOJI="🌱"
      ;;
    "staging")
      DESCRIPTION="STGNG"
      COLOR="dim,fg=color226"
      ;;
    "prod")
      DESCRIPTION="PROD"
      COLOR="fg=color0,bg=color160"
      ;;
    *)
      DESCRIPTION="??"
      COLOR="color160"
      ;;
esac

echo "#[${COLOR}] ${DESCRIPTION} ${EMOJI} "
