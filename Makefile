#Helm arguments and values
INSTALLATION_NAME ?= jenkins
UPSTREAM_CHART ?= stable/jenkins
CLUSTER_NAMESPACE ?= jenkins-project
TILLERNS ?= jenkins-project
VALUES_FILE ?= helm/jenkins-values.yaml
HELMTIMEOUT ?= 600

install_jenkins:
	helm upgrade --wait --timeout ${HELMTIMEOUT} --namespace ${CLUSTER_NAMESPACE} \
		-i -f ${VALUES_FILE} \
		${INSTALLATION_NAME} ${UPSTREAM_CHART}

delete_jenkins:
	helm delete --purge ${INSTALLATION_NAME}

status:
	helm status ${INSTALLATION_NAME}

history:
	helm history ${INSTALLATION_NAME}

admin_password:
	kubectl get secret --namespace ${CLUSTER_NAMESPACE} \
		${INSTALLATION_NAME} -o jsonpath="{.data.jenkins-admin-password}" \
		| base64 --decode;echo

launch:
	minikube service -n ${CLUSTER_NAMESPACE} ${INSTALLATION_NAME}
