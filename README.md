# Devsu Techincal Test

Repository used for the DevOps Engineer job position technical test

## Architecture

![alt text](https://github.com/mherrera230498/Prueba-Test/blob/main/diagram.jpg?raw=true)

## Deploying to Local Environment with NodeJS

### Prerequisites

- Node.js 18.15.0

### Usage

Install dependencies.

```bash
npm i
```

To run tests you can use this command.

```bash
npm run test
```

To run locally the project you can use this command.

```bash
npm run start
```

Open http://localhost:8000/api/users with your browser to see the result.

## Deploying to Local Environment with Docker

### Prerequisites

- Docker

### Usage

```bash
docker build -t my-app .
```

```bash
docker run --rm --name my-container -dp 30000:8000 -e DATABASE_NAME="./devDocker.sqlite" -e DATABASE_USER="dbUser" -e DATABASE_PASSWORD="dbPass" -e WORK_ENVIRONMENT="dev" my-app
```

Open http://localhost:30000/api/users with your browser to see the result.

## Deploying to Local Environment with Helm

### Prerequisites

- Minikube
- Helm v3

### Usage

Modify helm_chart/values.yaml to customize deployment.

To deploy resources to default namespace run:

```bash
helm -n default upgrade --install --create-namespace my-app helm_chart/
```

Open http://{minikubeip}:30000/api/users with your browser to see the result.

Also you can perfom a test with helm

```bash
helm -n default test my-app
```

To remove the kubernetes resources run:

```bash
helm uninstall my-app
```

### Generate Kubernetes Manifests

You can generate static kubernetes manifests using Helm

```bash
helm template helm_chart/ 
```

## Database

The database is generated as a file in the main path when the project is first run, and its default name is `dev.sqlite`.

Consider giving access permissions to the file for proper functioning.

## Features

These services can perform,

### Create User

To create a user, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "error": "error"
}
```

### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "error": "User not found: <id>"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

## Using GitHub Actions

### Final Workflow

![alt text](https://github.com/mherrera230498/Prueba-Test/blob/main/github-action-workflow.jpg?raw=true)

### Prerequisites

- EKS cluster (Terraform files provided in zip)
- GitHub Secrets: SNYK_TOKEN, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
- GitHub Environments: dev, prod
- Environment variables: HELM_NAMESPACE, EXECUTE_HELM_TEST
- Helm v3

### Usage

Connect to the EKS

```bash
aws eks update-kubeconfig --region us-west-2 --name my-eks-cluster
```

If using the EKS cluster from the terraform provided, run the next command to deploy CoreDNS pods in Fargate
```bash
kubectl patch deployment coredns \
    -n kube-system \
    --type json \
    -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
```

Modify helm_chart/values.yaml to customize deployment.

To deploy resources to default namespace run:

```bash
helm -n default upgrade --install --create-namespace my-app helm_chart/
```

To verify the deployment execute:

```bash
helm -n default test my-app
```

To remove the kubernetes resources run:

```bash
helm uninstall my-app
```