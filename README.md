# Universal App Helm Chart

A comprehensive Helm chart for deploying applications with all necessary Kubernetes resources including deployment, configmap, persistent volumes, and Istio service mesh components.

## Features

This Helm chart provides templates for:

- **Deployment**: Configurable application deployment with health checks, resource limits, and environment variables
- **Service**: ClusterIP, NodePort, or LoadBalancer service types
- **ConfigMap**: Application configuration management
- **Persistent Volume & PVC**: Storage management for stateful applications
- **Istio Integration**: Virtual Service and Destination Rule for service mesh
- **Ingress**: HTTP/HTTPS traffic routing
- **Horizontal Pod Autoscaler**: Automatic scaling based on CPU/Memory usage
- **Security**: Pod security contexts and RBAC support

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Istio 1.15+ (if using Istio features)

## Installation

### 1. Package the Chart

```bash
helm package .
```

### 2. Upload to GCP Artifact Registry

```bash
# Configure Docker to use gcloud as a credential helper
gcloud auth configure-docker

# Push the chart to Artifact Registry
helm push universal-app-chart-0.1.0.tgz oci://LOCATION-docker.pkg.dev/PROJECT-ID/REPOSITORY
```

### 3. Install from Artifact Registry

```bash
helm install my-app oci://LOCATION-docker.pkg.dev/PROJECT-ID/REPOSITORY/universal-app-chart --version 0.1.0
```

## Configuration

### Basic Usage

Create a `values.yaml` file with your specific configuration:

```yaml
app:
  name: my-application
  version: "1.0.0"

image:
  repository: gcr.io/my-project/my-app
  tag: "v1.0.0"
  pullPolicy: IfNotPresent

deployment:
  enabled: true
  replicaCount: 3
  
service:
  enabled: true
  type: LoadBalancer
  port: 80

configMap:
  enabled: true
  data:
    app.properties: |
      server.port=8080
      database.url=jdbc:postgresql://db:5432/myapp
```

### Storage Configuration

```yaml
persistentVolume:
  enabled: true
  capacity: 20Gi
  storageClass: ssd
  
persistentVolumeClaim:
  enabled: true
  size: 20Gi
  storageClass: ssd
```

### Istio Configuration

```yaml
istio:
  enabled: true
  
  virtualService:
    enabled: true
    hosts:
      - my-app.example.com
    gateways:
      - my-gateway
      
  destinationRule:
    enabled: true
    trafficPolicy:
      tls:
        mode: ISTIO_MUTUAL
```

### Autoscaling Configuration

```yaml
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 80
```

## Usage Examples

### Example 1: Simple Web Application

```yaml
# values.yaml
app:
  name: web-app
  
image:
  repository: nginx
  tag: "1.21"
  
deployment:
  enabled: true
  replicaCount: 2
  ports:
    - name: http
      containerPort: 80
      protocol: TCP
      
service:
  enabled: true
  type: ClusterIP
  port: 80
  
ingress:
  enabled: true
  hosts:
    - host: web-app.local
      paths:
        - path: /
          pathType: Prefix
```

### Example 2: Microservice with Istio

```yaml
# values.yaml
app:
  name: user-service
  labels:
    app: user-service
    version: v1
    
image:
  repository: gcr.io/my-project/user-service
  tag: "v1.2.0"
  
deployment:
  enabled: true
  replicaCount: 3
  
service:
  enabled: true
  
istio:
  enabled: true
  virtualService:
    enabled: true
    hosts:
      - user-service
    http:
      - match:
          - uri:
              prefix: "/api/users"
        route:
          - destination:
              host: user-service
              port:
                number: 80
              subset: v1
            weight: 90
          - destination:
              host: user-service
              port:
                number: 80
              subset: v2
            weight: 10
            
  destinationRule:
    enabled: true
    subsets:
      - name: v1
        labels:
          version: v1
      - name: v2
        labels:
          version: v2
```

### Example 3: Stateful Application

```yaml
# values.yaml
app:
  name: database-app
  
image:
  repository: postgres
  tag: "13"
  
deployment:
  enabled: true
  replicaCount: 1
  env:
    - name: POSTGRES_DB
      value: "myapp"
    - name: POSTGRES_USER
      value: "admin"
    - name: POSTGRES_PASSWORD
      value: "secretpassword"
      
persistentVolume:
  enabled: true
  capacity: 50Gi
  storageClass: ssd
  
persistentVolumeClaim:
  enabled: true
  size: 50Gi
  storageClass: ssd
  
service:
  enabled: true
  type: ClusterIP
  port: 5432
```

## Chart Structure

```
universal-app-chart/
├── Chart.yaml                 # Chart metadata
├── values.yaml               # Default configuration values
├── requirements.yaml         # Chart dependencies
├── templates/
│   ├── deployment.yaml       # Kubernetes Deployment
│   ├── service.yaml          # Kubernetes Service
│   ├── configmap.yaml        # ConfigMap for application config
│   ├── persistentvolume.yaml # Persistent Volume
│   ├── persistentvolumeclaim.yaml # PVC
│   ├── destinationrule.yaml  # Istio Destination Rule
│   ├── virtualservice.yaml   # Istio Virtual Service
│   ├── ingress.yaml          # Kubernetes Ingress
│   └── hpa.yaml             # Horizontal Pod Autoscaler
└── README.md                 # This file
```

## Configuration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `app.name` | Application name | `my-app` |
| `app.version` | Application version | `1.0.0` |
| `image.repository` | Container image repository | `gcr.io/my-project/my-app` |
| `image.tag` | Container image tag | `latest` |
| `deployment.enabled` | Enable deployment | `true` |
| `deployment.replicaCount` | Number of replicas | `1` |
| `service.enabled` | Enable service | `true` |
| `service.type` | Service type | `ClusterIP` |
| `configMap.enabled` | Enable ConfigMap | `true` |
| `persistentVolume.enabled` | Enable PV | `false` |
| `persistentVolumeClaim.enabled` | Enable PVC | `false` |
| `istio.enabled` | Enable Istio resources | `false` |
| `ingress.enabled` | Enable Ingress | `false` |
| `autoscaling.enabled` | Enable HPA | `false` |

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the chart
5. Submit a pull request

## License

This chart is licensed under the MIT License.