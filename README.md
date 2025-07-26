# Amrutam Application

A full-stack application with Node.js backend and Next.js frontend, deployed to Kubernetes using ArgoCD.

## 🏗️ Project Structure

```
amrutam/
├── backend/                 # Node.js API server
├── frontend/               # Next.js frontend application
├── k8s/                    # Kubernetes manifests
│   ├── backend/           # Backend deployment & service
│   ├── frontend/          # Frontend deployment & service
│   └── ingress.yaml       # Ingress configuration
├── argocd/                # ArgoCD application manifests
├── helm-charts/           # Helm charts (for advanced usage)
├── scripts/               # Deployment scripts
└── README.md              # This file
```

## 🚀 Quick Start

### Prerequisites
- Docker Hub account
- Kubernetes cluster
- ArgoCD installed (optional, for GitOps)
- kubectl configured

### 1. Build and Push Docker Images
```bash
# Build and push backend
cd backend
docker build -t anupsharma329/backend:v1.1 .
docker push anupsharma329/backend:v1.1

# Build and push frontend
cd ../frontend
docker build -t anupsharma329/frontend:v1.1 .
docker push anupsharma329/frontend:v1.1
```

### 2. Deploy to Kubernetes

#### Option A: Direct Deployment (kubectl)
```bash
./scripts/deploy-k8s.sh
```

#### Option B: GitOps with ArgoCD
```bash
# Apply ArgoCD applications
kubectl apply -f argocd/backend-app.yaml
kubectl apply -f argocd/frontend-app.yaml
```

## 📋 Deployment Options

### Direct Kubernetes Deployment
- Uses organized manifests in `k8s/` folder
- Simple and straightforward
- Good for development and testing

### ArgoCD GitOps Deployment
- Automated deployment from Git
- Separate applications for backend and frontend
- Self-healing and automated sync

## 🔍 Monitoring & Troubleshooting

### Check Application Status
```bash
# Check pods
kubectl get pods -n production

# Check services
kubectl get svc -n production

# Check ingress
kubectl get ingress -n production
```

### View Logs
```bash
# Backend logs
kubectl logs -n production -l app=backend

# Frontend logs
kubectl logs -n production -l app=frontend
```

### Port Forward for Local Testing
```bash
# Frontend
kubectl port-forward svc/frontend-service -n production 8080:80

# Backend
kubectl port-forward svc/backend-service -n production 4000:4000
```

## 🐳 Docker Images

- **Backend**: `anupsharma329/backend:v1.1`
- **Frontend**: `anupsharma329/frontend:v1.1`

## 🌐 Access Points

- **Frontend**: Available via ingress at your domain
- **Backend API**: Available at `/api` path via ingress
- **Health Check**: Backend health endpoint at `/health`

## 📚 Documentation

For detailed deployment instructions, see [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

## 🔧 Configuration

### Environment Variables
- `NODE_ENV`: Set to "production" in Kubernetes
- `PORT`: Backend runs on port 4000

### Resources
- **Backend**: 256Mi-1Gi memory, 200m-1000m CPU
- **Frontend**: 128Mi-512Mi memory, 100m-500m CPU

## 🚀 Next Steps

1. Configure your domain in `k8s/ingress.yaml`
2. Set up SSL certificates
3. Configure monitoring and logging
4. Set up CI/CD pipeline





