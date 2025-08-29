#!/bin/bash
# Create a fresh Helm chart in a new directory

echo "Creating a fresh Helm chart..."

# Create a new directory for the chart
mkdir -p /tmp/universal-app-chart

# Copy all files from current directory to the new directory
cp -r templates /tmp/universal-app-chart/
cp values.yaml /tmp/universal-app-chart/
cp requirements.yaml /tmp/universal-app-chart/
cp README.md /tmp/universal-app-chart/
cp .helmignore /tmp/universal-app-chart/

# Create a fresh Chart.yaml in the new directory
cat > /tmp/universal-app-chart/Chart.yaml << 'EOF'
apiVersion: v2
name: universal-app-chart
description: A comprehensive Helm chart for deploying applications with all necessary Kubernetes resources
type: application
version: 0.1.0
appVersion: "1.0.0"
EOF

echo "Fresh chart created in /tmp/universal-app-chart"
echo "Try running: cd /tmp/universal-app-chart && helm package ."
echo "After packaging, you can copy the .tgz file back to your original directory"