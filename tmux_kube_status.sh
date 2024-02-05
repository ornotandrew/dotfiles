CURRENT_CONTEXT=$(kubectl config current-context)
case $CURRENT_CONTEXT in
    "docker-desktop")
        ENV="local"
        ;;
    "main-cluster-stag-aks")
        ENV="staging"
        ;;
    "main-cluster-prod-aks")
        ENV="prod"
        ;;
    "main-cluster-prep-aks")
        ENV="preprod"
        ;;
    *)
        ENV="unknown"
        ;;
esac

case $ENV in 
    "local")
        echo "#[fg=colour10] LOCAL 🌱 "
        ;;
    "staging")
        echo "#[fg=color226] STGNG 🚜 "
        ;;
    "preprod")
        echo "#[fg=color160] PREP 🚦 "
        ;;
    "prod")
        echo "#[fg=color0,bg=colour160] PROD ⚠️  "
        ;;
    "unknown")
        echo " ?? "
        ;;
esac
