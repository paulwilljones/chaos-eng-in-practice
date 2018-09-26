#!/usr/bin/env bash

gcloud container clusters create istio-tutorial \
    --machine-type=n1-standard-2 \
    --num-nodes=4 \
    --no-enable-legacy-authorization

gcloud container clusters get-credentials istio-tutorial

kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user="$(gcloud config get-value core/account)"

kubectl apply -f install/kubernetes/istio-demo-auth.yaml

kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)

kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

curl -I http://${GATEWAY_URL}/productpage

#kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
kubectl apply -f samples/bookinfo/networking/destination-rule-all-mtls.yaml

#samples/bookinfo/platform/kube/cleanup.sh
#kubectl -n istio-system delete service istio-ingressgateway
#gcloud container clusters delete istio-tutorial
