#!/bin/bash

# Configuration
NEW_REPO="anupsharma329/amrutum-frontend"  # Change this to your Docker Hub username/repository name
VERSION=$(date +%Y%m%d-%H%M%S)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Docker build and push process...${NC}"

# Build and push Backend
echo -e "${YELLOW}📦 Building Backend image...${NC}"
cd backend
docker build -t ${NEW_REPO}/backend:${VERSION} .
docker tag ${NEW_REPO}/backend:${VERSION} ${NEW_REPO}/backend:latest

echo -e "${YELLOW}📤 Pushing Backend image...${NC}"
docker push ${NEW_REPO}/backend:${VERSION}
docker push ${NEW_REPO}/backend:latest

# Build and push Frontend
echo -e "${YELLOW}📦 Building Frontend image...${NC}"
cd ../frontend
docker build -t ${NEW_REPO}/frontend:${VERSION} .
docker tag ${NEW_REPO}/frontend:${VERSION} ${NEW_REPO}/frontend:latest

echo -e "${YELLOW}📤 Pushing Frontend image...${NC}"
docker push ${NEW_REPO}/frontend:${VERSION}
docker push ${NEW_REPO}/frontend:latest

cd ..

echo -e "${GREEN}✅ All images built and pushed successfully!${NC}"
echo -e "${GREEN}📋 Image versions:${NC}"
echo -e "  Backend: ${NEW_REPO}/backend:${VERSION}"
echo -e "  Frontend: ${NEW_REPO}/frontend:${VERSION}"

# Save version for Helm values
echo "VERSION=${VERSION}" > .env
echo "NEW_REPO=${NEW_REPO}" >> .env 