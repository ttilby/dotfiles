#!/bin/bash

DEPLOYMENT="ncm-core-rome-jobs-release"
context=$(kubectl config current-context)
IFS="-"
read -a parts <<< "${context}"
NAMESPACE="${parts[0]}-ncm"

get_available_replicas() {
  echo $(kubectl --namespace="${NAMESPACE}" get deployment/"${DEPLOYMENT}" -o json | jq -r '.status.availableReplicas')
}

SCALED=0
RESULT=$(get_available_replicas)
if [[ ${RESULT} -eq "null" || ${RESULT} -eq "0" ]]; then
  SCALED=1
  echo "Scaling up ${DEPLOYMENT}"
  kubectl --namespace "${NAMESPACE}" scale --replicas=1 deployment/"${DEPLOYMENT}"
fi

while [[ ${RESULT} -eq "null" || ${RESULT} -eq "0" ]]; do
  echo "Searching for pod..."
  sleep 2
  RESULT=$(get_available_replicas)
done

PODNAME=$(kubectl --namespace="${NAMESPACE}" get pods --selector "deploymentName=${DEPLOYMENT}" -o json | jq -r '.items[0].metadata.name')
echo "Found pod ${PODNAME}"
sleep 2
kubectl --namespace "${NAMESPACE}" exec -it "${PODNAME}" /bin/bash

if [[ ${SCALED} -eq 1 ]]; then
  echo "Scaling down ${DEPLOYMENT}"
  kubectl --namespace="${NAMESPACE}" scale --replicas=0 deployment/"${DEPLOYMENT}"
fi
