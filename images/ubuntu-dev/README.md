# Ubuntu Development Container

This container image provides a basic development Ubuntu image to do some quick prototyping or testing with Ubuntu.

This image is available both for x64 (amd64) and ARM (arm64).

## Docker

To use this image in Docker:

```sh
docker run -it --rm --name ubuntu-dev skrysm/ubuntu-dev
```

## Kubernetes

To use this image in Kubernetes, use:

```sh
kubectl run ubuntu-dev-pod -it --rm --image=skrysm/ubuntu-dev
```

If you need to run this image on a specific node, use:

```sh
kubectl run ubuntu-dev-pod -it --rm --image=skrysm/ubuntu-dev --overrides='{ "apiVersion": "v1", "spec": { "nodeName": "<your-node-name>" } }'
```
