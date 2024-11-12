#!/usr/bin/env bash

# shellcheck disable=SC2016

# shellcheck disable=SC2034
demo_helper_type_speed=5000

# shellcheck source=./demo-helper.sh
. "$(dirname "$0")/demo-helper.sh"

comment "1. Get Argo CD spec"
execute 'curl -sSL -o argocd-install.yaml \
    https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml'

comment "2. Check content using yq"
execute 'yq argocd-install.yaml'

comment "2.1. Check content simply with cat"
execute 'cat argocd-install.yaml | head -n 20'

clear_terminal

comment "NOTE: The rest of the steps assume you have a running cluster."

comment "3. Check the installed manifests"
execute 'kubectl get deployments -n argocd'

comment "3.1. Find the installed versions"
execute 'kubectl get deployments -n argocd -o jsonpath={.items[*].spec.template.spec.containers[0].image}'
