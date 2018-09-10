#!/usr/bin/env

gcloud container clusters create terraform-gke \
  --zone=europe-west2-a \
  --additional-zones=europe-west2-b,europe-west2-c \
  --num-nodes 3

gcloud container clusters get-credentials terraform-gke
