# resource-labeler-operator
kubernetes operator to auto label/taint/annotate a kubernetes resource (node, pod) based on a CRD.

NOTE: This is an alpha-status project based on the node-labeler-operator

## Requirements

_resource-labeler-operator_ is meant to be run on Kubernetes 1.8+. All dependecies have been vendored, so there's no need to any additional download.

## Usage

### Installation

In order to create _resource-labeler-operator_ inside a Kubernetes cluster, the operator has to be deployed. It can be done with a deployment.
```
kubectl run resource-labeler-operator --image=boilerupnc/resource-labeler-operator --namespace=kube-system
```

### Configuration

_resource-labeler-operator_ is using a [CRD](https://kubernetes.io/docs/concepts/api-extension/custom-resources/) for its configuration.
Here is a description of an object:
```yaml
apiVersion: labeler.cfmr.site/v1alpha1
kind: Labeler
metadata:
  name: example
  labels:
    operator: resource-labeler-operator
spec:
  nodeSelectorTerms:
  - matchExpressions:
    - key: kubernetes.io/hostname
      operator: In
      values:
      - minikube
    - key: beta.kubernetes.io/os
      operator: In
      values:
      - linux
  - matchExpressions:
    - key: another-node-label-key
      operator: Exists
  merge:
    labels:
      minikube: "true"
    annotations:
      node-labeler-operator: works
    taints:
    - key: dedicated
      value: foo
      effect: PreferNoSchedule
```
for more information about `nodeSelectorTerms` have a look at: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/

### Cases

- VM on private cloud provider.  
Nodes are removed on shutdown and so lose theirs attributes.
- License Management Tools.
License tools expect certain resources to contain a particular label
- Auto Labeling workloads to facilitate multicloud discovery 

## Features
- [x] Node selection
- [x] Adding attributes
  - [x] Labels
  - [x] Annotations
  - [x] Taints
- [ ] Removing attributes
- [ ] Overwrite attributes
