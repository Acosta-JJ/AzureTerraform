
## Deployment instructions:
1. Go to the repository https://github.com/Acosta-JJ/AzureTerraform/actions, then go to actions and run the action Deploy AKS, this will deploy the cluster and the helm chart needed for ingress
 2. Clone the repository:
      git clone https://github.com/Acosta-JJ/AzureTerraform.git
  3. Install Terraform CLI:
Follow the [LINK](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli) to check the guide, choose according to your S.O
4. Once the action of step 1 is completed run the following commands `cd Terraform` and `terraform init`
5. Install kubectl 
6. Now let's configure the kubeconfig so you can use it, while you are in Terraform directory use this command `terraform output -raw kube_config > $HOME/.kube/config` this will edit your current kubectl file to the newer one allowing you to access the cluster.
7. Let's deploy the Kubernetes manifest. While you are in Terraform directory use this command `kubectl apply -f .. --recursive` You will have to wait a little bit until all the applications are ready
8. Now let's check the application, for that we will run `kubectl get svc` and grab the external_ip value from nginx-ingress-nginx-controller
9. Go to your browser and paste the ip in the search bar.
 10. When you are done go to actions and run the action named AKS Delete Cluster! **DO NOT FORGET**

## What is implemented right now
This is a diagram explaining what I have at the moment. I decided to split the Docker compose into microservices one for mongoDB other for BackEnd and another one for FrontEnd.
![image](https://github.com/user-attachments/assets/0ca154d2-b9af-474a-abca-5dfa38b28dac)
The current features/resources:
- Pod Level Security
- Both BackEnd and FrontEnd use a Deployment to have multiple replicas
- Both BackEnd and FrontEnd have an internal load balancer service to spread the load between pods
- Ingress resource that proxys the request to BackEnd or FrontEnd
- Mongo is deployed as StatefulSet
- The cluster is provisioned by Terraform using a github Action
- The cluster is deleted by Terraform using a github Action
- Store Terraform State in Azure so it is accesible by reviewers and they are able to get kubeconfig

## How was my workflow?
- I tried to first deploy the infrastructure using Terraform
- Then I created a MVP(Minimum Viable Project)
- I started to iterate over the MVP using different branches with Pull Request.
  
## Annotations and improvements
I had a lot of ideas to actually improve this repository, however I didn't implement them due to the time constraint set to the test or because of the app limitations.
- Enable private cluster in AKS -> I didn't implemented this because I needed to whitelist the IPs and I don't have the reviewers IPs.
- Use a DNS service so the FrontEnd is not access using the IP of the Ingress Service
- Enable tls in ingress so it doesn't have http enabled
- Install a cert manager within the cluster
- Divide the resources in different namespaces and use network policies to limit the traffic between the microservices. I didn't implement this because this BackEnd line `mongoose.connect("mongodb://mongo:27017/todos"` only allows to connect to mongo service and it will be not reachable if I divide the application into multiple namespaces.
- Change the deployment method to use argoCD and deploy all the manifest using argo pointing to the same repository. Once you change the github action to deploy the AKS cluter adding argoCD you can deploy all the infraestructure just running the action.
- Make MongoDB a high availability microservice using the cluster configuration https://kubernetes.io/blog/2017/01/running-mongodb-on-kubernetes-with-statefulsets/
- Create StorageClass for MongoDB PV and PVC
- Also from infra side horizontal pod autoscaler or Karpenter will be nice options.





