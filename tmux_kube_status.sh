CURRENT_CONTEXT=$(kubectl config current-context)
case $CURRENT_CONTEXT in
    "rancher-desktop")
        ENV="local"
        ;;
    "main-staging-aks-new")
        ENV="staging"
        ;;
    "pci-stag-aks")
        ENV="pci-staging"
        ;;
    "main-cluster-prod-aks")
        ENV="prod"
        ;;
    "pci-prod-aks")
        ENV="pci-prod"
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
        echo "#[dim,fg=colour10] LOCAL 🌱 "
        ;;
    "staging")
        echo "#[dim,fg=color226] STGNG 🚜 "
        ;;
    "pci-staging")
        echo "#[dim,fg=color226] STGNG 🔒 "
        ;;
    "preprod")
        echo "#[dim,fg=color160] PREP 🚦 "
        ;;
    "prod")
        echo "#[fg=color0,bg=colour160] PROD 🟡#[none,fg=color160,bg=color234]"
        ;;
    "pci-prod")
        echo "#[fg=color0,bg=colour160] PROD 🔒#[none,fg=color160,bg=color234]"
        ;;
    "unknown")
        echo " ?? "
        ;;
esac
