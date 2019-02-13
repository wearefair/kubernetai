# Fair Specific Fork Notes
## Why?
Kubernetai is a plugin that allows CoreDNS to talk to multiple Kubernetes servers.

Right now, [Istio multicluster with the single control plane topology](https://preliminary.istio.io/docs/concepts/multicluster-deployments/#single-control-plane-topology) requires Kubernetes services to be replicated in all clusters in order for DNS resolution to work correctly. This is currently addressed with Fair's [K8 Cross Cluster Controller]*(https://github.com/wearefair/k8-cross-cluster-controller).

This is a POC to see if it's possible to have multicluster work without cross-cluster service replication.

## Building
```bash
make # Will run make build and call the ./build-all.sh, which puts binaries into the release/ folder`
```

## Docker
The Fair Kubernetai fork image lives in Fair's private ops ECR.

```bash
make docker-build # Builds the binary, puts it into a scratch container
make docker-push # Pushes everything to Fair ECR
```

## Deploying
More formalized deployment instructions of this flavor of Kubernetai to follow. For now, it's likely going to be variant of CoreDNS's [K8 deployment scripts](https://github.com/coredns/deployment/tree/28cca6fe1b87a7c6dc4c4ce9ddba03176fe86967/kubernetes).
