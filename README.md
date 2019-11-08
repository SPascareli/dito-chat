# Dito Chat App

Just a simple chat app built with React, Go, Websockets and Redis.

Nginx is used in production to serve our frontend code.

# Deployment

Deployment is using Docker and Terraform deployed on the Google Cloud Platform Kubernetes cluster (GKE). Following is an explanation of the deployment flow and where every tools is used:

## Docker

Docker is used to package and run the applications (backend and frontend), on development the *docker-compose.yml* file can be used to spin up a simple version of the application for development.

In production the docker images are pushed to GCP repository and the containers are run in a kubernetes cluster.

## Terraform

Terraform is used to instantiate our infrastructure dinamically, this is called Infra as Code and it means that we can re-deploy our entire cluster with the same configuration again if needed.

Terraform also interfaces with our Kubernetes cluster and sets our desired configurations (pods).

## Kubernetes

Kubernetes is the de facto tool for container orchestration right now, and it is used here because it provides us the the capabilities we need to define our infrastructure in a **declarative** way. It also ease many issues around managing and scaling our services.

With kubernetes we can scale our backend services if they become a bottleneck, or our frontend services as well for  high availability.

In this particular implementation we put the redis and the backend go server in the same kubernetes pod for simplicity, but in a prodution situation that would be unwise, since redis is used here as a means of persistence and messaging between our backend servers it would need to be scaled separetely.

Also, we are not using kubernetes *deployment* sets, which in production would be better than creating pods directly like we do now.

## GCP (GKE)

Google Cloud Platform was choosen here as our cloud provider for it's ease of integration with kubernetes from their managed kubenetes offer (Google Kubernetes Engine), but also because of cost (*I have a free trial going right now hehe*).

GKE integration with Terraform is also quite simple, although I had to make several steps manually to be able to use it (create a new project, set permissions and such).

## How it all comes together

1. Terraform with instantiate our kuberntes cluster, currently with 3 instances of a standard-sized VM;
2. The developer can change the code, build and push the new images using the *push_images.sh* script (more on this later);
3. Terraform then pushes our desired kubernetes cluster state to kubernetes, which will create (or update) our pods to match our desired configuration;

> Why use the *push_images* script instead of doing a CI/CD pipeline the pushes the images automatically to the cluster?

Just for simplicity, the entire deployment has to be triggered by the developer, but in a production environment that could lead to many problems, so a CI/CD pipeline would be best.

There are many options in this regard, there is Google Code Build with is integrated in GCP, there is also Jenkins and Jenkins X, Gitlab could also be used both as a git repo and as a continuous integration pipeline.

# What could be better (or, future improvements)

* Have a CI/CD pipeline.
* No hard coded configurations, define all in the environment variables of the CD environment.
* Use kubernetes deployments and replica sets.
* Use Prometheus + Grafana for monitoring the API calls, cluster health, connected clients etc.
* GCP requires some configurations to be done before we can use it, so it can be hard to just clone this code and get it running the first time (although after this, it is pretty smooth)
* Separate our redis and backend server instances into different pods, probably using a persistent set on redis.
* Probably you noticed quite a few other things, but this is just the tip of the iceberg when it comes to devops hehe.