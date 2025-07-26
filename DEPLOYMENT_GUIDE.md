# Amrutam Deployment Guide

## Repository Setup

You have two repositories:
1. **Main Code Repository**: `https://github.com/anupsharma329/amrutam.git`
2. **Image Repository**: `https://github.com/anupsharma329/amrutam-img.git` (for storing Docker images)

## Important Note: Docker Images vs Git Repositories

⚠️ **GitHub repositories are NOT Docker registries!** You cannot push Docker images directly to a Git repository.

## Recommended Approach: Use Docker Hub

### Step 1: Create Docker Hub Account
1. Go to [Docker Hub](https://hub.docker.com)
2. Create an account with username: `anupsharma329`
3. Create repositories:
   - `anupsharma329/amrutam-img-backend`
   - `anupsharma329/amrutam-img-frontend`

### Step 2: Login to Docker Hub
```bash
docker login
# Enter your Docker Hub username and password
```

### Step 3: Fix Git Issues
First, let's resolve the Git conflict:

```bash
# Option 1: Pull and rebase (recommended)
git pull origin main --rebase

# Option 2: Force push (use with caution)
git push origin main --force
```

### Step 4: Run the Deployment
```bash
./scripts/deploy.sh
```

## Alternative Approach: Use GitHub Container Registry (GHCR)

If you prefer to use GitHub's container registry:

### Step 1: Update Configuration
Update `scripts/build-and-push.sh`:
```bash
NEW_REPO="ghcr.io/anupsharma329/amrutam"
```

### Step 2: Login to GHCR
```bash
echo $GITHUB_TOKEN | docker login ghcr.io -u anupsharma329 --password-stdin
```

### Step 3: Create GitHub Token
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Create a token with `write:packages` permission
3. Set as environment variable: `export GITHUB_TOKEN=your_token`

## Current Configuration

Your current setup uses:
- **Docker Hub repositories**: `anupsharma329/amrutam-img-backend` and `anupsharma329/amrutam-img-frontend`
- **GitHub repository**: `https://github.com/anupsharma329/amrutam.git`
- **ArgoCD applications**: Point to your main GitHub repository

## Step-by-Step Deployment Process

### 1. Fix Git Issues
```bash
# Check current status
git status

# Pull latest changes
git pull origin main --rebase

# If there are conflicts, resolve them and continue
git rebase --continue
```

### 2. Create Docker Hub Repositories
1. Go to [Docker Hub](https://hub.docker.com)
2. Create repositories:
   - `anupsharma329/amrutam-img-backend`
   - `anupsharma329/amrutam-img-frontend`

### 3. Login to Docker Hub
```bash
docker login
```

### 4. Run Deployment
```bash
./scripts/deploy.sh
```

## What the Deployment Script Does

1. **Builds Docker Images**:
   - `anupsharma329/amrutam-img-backend:latest`
   - `anupsharma329/amrutam-img-frontend:latest`

2. **Pushes to Docker Hub**:
   - Both images are pushed to your Docker Hub repositories

3. **Updates Helm Values**:
   - Updates image references in Helm charts

4. **Commits to Git**:
   - Pushes changes to `https://github.com/anupsharma329/amrutam.git`

5. **Applies ArgoCD Applications**:
   - Deploys to Kubernetes via ArgoCD

## Troubleshooting

### Docker Push Errors
If you get "push access denied":
1. Make sure you're logged in: `docker login`
2. Verify repositories exist on Docker Hub
3. Check repository names match exactly

### Git Push Errors
If you get "non-fast-forward":
```bash
# Option 1: Pull and rebase
git pull origin main --rebase

# Option 2: Force push (use carefully)
git push origin main --force
```

### ArgoCD Issues
1. Check if ArgoCD is installed:
   ```bash
   kubectl get namespace argocd
   ```

2. Apply applications manually:
   ```bash
   kubectl apply -f argocd/applications/backend-app.yaml
   kubectl apply -f argocd/applications/frontend-app.yaml
   ```

## Monitoring Deployment

1. **Check ArgoCD UI**:
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   # Visit: https://localhost:8080
   ```

2. **Check Application Status**:
   ```bash
   kubectl get applications -n argocd
   kubectl get pods -n production
   ```

3. **View Logs**:
   ```bash
   kubectl logs -n production -l app=backend
   kubectl logs -n production -l app=frontend
   ```

## Next Steps

1. **Set up CI/CD Pipeline**: Configure GitHub Actions to automate builds
2. **Add Monitoring**: Set up Prometheus and Grafana
3. **Configure Ingress**: Set up proper domain and SSL certificates
4. **Add Secrets Management**: Use Kubernetes secrets for sensitive data

## Important Files

- `scripts/build-and-push.sh`: Builds and pushes Docker images
- `scripts/deploy.sh`: Complete deployment pipeline
- `helm-charts/`: Helm charts for Kubernetes deployment
- `argocd/applications/`: ArgoCD application configurations 