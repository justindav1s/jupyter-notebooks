#!/usr/bin/env bash



dev_project=jupyterhub-gpu
app_name=minimal-notebook
git_url=https://github.com/justindav1s/jupyter-notebooks.git

oc project ${dev_project}

oc delete bc ${app_name}-docker-build

oc process -f docker-build-template.yml \
    -p APPLICATION_NAME=${app_name} \
    -p SOURCE_REPOSITORY_URL=${git_url} \
    -p SOURCE_REPOSITORY_REF=master \
    -p DOCKERFILE_PATH=${app_name} \
    -p DOCKERFILE_NAME=Dockerfile-py36 \
    | oc apply -n ${dev_project} -f -


