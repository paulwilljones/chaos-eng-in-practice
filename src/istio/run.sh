#!/usr/bin/env bash

kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &

kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml

kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml

kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml

kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml
