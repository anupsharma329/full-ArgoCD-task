#!/bin/bash

# Simple Deployment Script for Organized Kubernetes Manifests
# This script deploys backend, frontend, and ingress separately

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Organized Kubernetes Deployment...${NC}"

# Step 1: Create namespace if it doesn't exist
echo -e "${YELLOW}📝 Step 1: Creating namespace...${NC}"
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -

# Step 2: Deploy Backend
echo -e "${YELLOW}🔧 Step 2: Deploying Backend...${NC}"
kubectl apply -f k8s/backend/

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to deploy backend${NC}"
    exit 1
fi

# Step 3: Deploy Frontend
echo -e "${YELLOW}🔧 Step 3: Deploying Frontend...${NC}"
kubectl apply -f k8s/frontend/

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to deploy frontend${NC}"
    exit 1
fi

# Step 4: Deploy Ingress
echo -e "${YELLOW}🔧 Step 4: Deploying Ingress...${NC}"
kubectl apply -f k8s/ingress.yaml

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to deploy ingress${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Deployment completed successfully!${NC}"

# Step 5: Check deployment status
echo -e "${YELLOW}📊 Step 5: Checking deployment status...${NC}"
echo -e "${BLUE}📋 Backend Pods:${NC}"
kubectl get pods -n production -l app=backend

echo -e "${BLUE}📋 Frontend Pods:${NC}"
kubectl get pods -n production -l app=frontend

echo -e "${BLUE}📋 Services:${NC}"
kubectl get svc -n production

echo -e "${BLUE}📋 Ingress:${NC}"
kubectl get ingress -n production

# Step 6: Summary
echo -e "${GREEN}🎉 Organized deployment completed!${NC}"
echo -e "${BLUE}📋 Summary:${NC}"
echo -e "   Backend: k8s/backend/"
echo -e "   Frontend: k8s/frontend/"
echo -e "   Ingress: k8s/ingress.yaml"
echo -e "   Namespace: production"
echo -e ""
echo -e "${BLUE}🔍 Useful commands:${NC}"
echo -e "   kubectl get pods -n production"
echo -e "   kubectl logs -n production -l app=backend"
echo -e "   kubectl logs -n production -l app=frontend"
echo -e "   kubectl port-forward svc/frontend-service -n production 8080:80" 