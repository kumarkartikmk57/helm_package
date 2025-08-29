#!/bin/bash
# Create a new Helm chart from scratch and copy our templates

echo "Creating a fresh Helm chart..."

# Create a new chart in a temporary location
TEMP_DIR="/tmp/fresh-chart"
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR
cd $TEMP_DIR

# Use helm create to generate a valid chart structure
helm create universal-app

# Remove default templates
rm -rf universal-app/templates/*
rm -f universal-app/values.yaml

# Copy our templates and values
cp -r /mnt/c/Users/karti/Documents/helm_package/templates/* universal-app/templates/
cp /mnt/c/Users/karti/Documents/helm_package/values.yaml universal-app/

# Update Chart.yaml with our values
cat > universal-app/Chart.yaml << 'EOF'
apiVersion: v2
name: universal-app-chart
description: A comprehensive Helm chart for deploying applications with all necessary Kubernetes resources
type: application
version: 0.1.0
appVersion: "1.0.0"
EOF

# Package the chart
cd universal-app
helm package .

# Copy the packaged chart back to the original directory
cp *.tgz /mnt/c/Users/karti/Documents/

echo "Chart created and packaged successfully!"
echo "The .tgz file has been copied to your Documents directory."
echo ""
echo "To install this chart in your Kubernetes cluster, run:"
echo "helm install my-app /mnt/c/Users/karti/Documents/universal-app-chart-0.1.0.tgz"
echo ""
echo "To upload to GitHub, you can create a release and attach this .tgz file."