#!/bin/bash

FG_DEFAULT="#[fg=default]"
FG_PROD="#[fg=$1]"

if command -v kubectx >/dev/null 2>&1 && command -v kubens >/dev/null 2>&1; then
    KUBE_CONTEXT=$(kubectx -c)
    KUBE_NAMESPACE=$(kubens -c)
    if [[ $KUBE_CONTEXT == *"prod"* ]]; then
        FG=$FG_PROD
    else
        FG=$FG_DEFAULT
    fi
    echo -n "${FG}ﴱ  ${KUBE_CONTEXT}/${KUBE_NAMESPACE}${FG_DEFAULT} "
fi
