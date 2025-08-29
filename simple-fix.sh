#!/bin/bash
# Simple script to create a working Helm chart

# Create a new chart with helm create
echo "Creating a new chart with helm create..."
cd /tmp
rm -rf simple-chart
helm create simple-chart

# Copy our values.yaml and templates
echo "Copying our templates and values..."
rm -rf simple-chart/templates/*
cp -r /mnt/c/Users/karti/Documents/helm_package/templates/* simple-chart/templates/
cp /mnt/c/Users/karti/Documents/helm_package/values.yaml simple-chart/

# Package the chart
echo "Packaging the chart..."
cd simple-chart
helm package .

# Copy the packaged chart back
echo "Copying the packaged chart..."
cp simple-chart-0.1.0.tgz /mnt/c/Users/karti/Documents/

echo "Done! Your chart is packaged as /mnt/c/Users/karti/Documents/simple-chart-0.1.0.tgz"
echo "You can install it with: helm install my-app /mnt/c/Users/karti/Documents/simple-chart-0.1.0.tgz"