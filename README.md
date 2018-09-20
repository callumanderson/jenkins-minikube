# minikube-helm-jenkins

Verify minikube is running:
```
$ minikube status
minikube: Running
cluster: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.100
```


Create namespace:
```
$ kubectl create -f minikube/jenkins-namespace.yaml
```

Create persistent volume (folder /data is persistent on minikube)
```
$ kubectl create -f minikube/jenkins-volume.yaml
```


Execute helm:
```
$ make install_jenkins
```

To upgrade the deployment, simply modify the jenkins-values.yaml and execute:
```
$ make install_jenkins
```


Check admin password for jenkins:
```
$ printf $(kubectl get secret --namespace jenkins-project jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```

Launch Jenkins in a browser:
```
minikube service -n jenkins-project jenkins
```
