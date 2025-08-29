#!/bin/bash
# Fix Chart.yaml file and package the Helm chart

echo "Debugging Helm chart issues..."
echo "Current directory: $(pwd)"
echo "Listing files:"
ls -la

echo "Creating a fresh Chart.yaml file..."
# Remove any existing Chart.yaml
rm -f Chart.yaml

# Create a clean version of Chart.yaml with proper line endings
cat > Chart.yaml << 'EOF'
apiVersion: v2
name: universal-app-chart
description: A comprehensive Helm chart for deploying applications with all necessary Kubernetes resources
type: application
version: 0.1.0
appVersion: "1.0.0"
home: https://github.com/your-org/universal-app-chart
sources:
  - https://github.com/your-org/universal-app-chart
maintainers:
  - name: Your Name
    email: your.email@example.com
keywords:
  - kubernetes
  - deployment
  - configmap
  - persistentvolume
  - istio
  - microservices
annotations:
  category: Application
EOF

echo "Chart.yaml file created. Contents:"
cat Chart.yaml

echo "Checking file permissions:"
ls -la Chart.yaml

echo "Checking what Helm sees:"
find . -name "Chart.yaml" -type f

echo "Try running 'helm package .' now."