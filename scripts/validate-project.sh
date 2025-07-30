#!/bin/bash

# Project Validation Script for Helm + Argo CD Setup
echo "🔍 Validating project structure for Helm + Argo CD deployment..."

# Check if required directories exist
echo "📁 Checking directory structure..."
required_dirs=("frontend" "backend" "frontend-chart" "backend-chart" "argocd" ".github/workflows")
for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir exists"
    else
        echo "❌ $dir is missing"
        exit 1
    fi
done

# Check if required files exist
echo "📄 Checking required files..."
required_files=(
    "frontend-chart/Chart.yaml"
    "frontend-chart/values.yaml"
    "backend-chart/Chart.yaml"
    "backend-chart/values.yaml"
    "argocd/frontend-helm-app.yaml"
    "argocd/backend-helm-app.yaml"
    ".github/workflows/deploy.yml"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
        exit 1
    fi
done

# Check if Dockerfiles exist
echo "🐳 Checking Dockerfiles..."
if [ -f "frontend/Dockerfile" ]; then
    echo "✅ frontend/Dockerfile exists"
else
    echo "❌ frontend/Dockerfile is missing"
    exit 1
fi

if [ -f "backend/Dockerfile" ]; then
    echo "✅ backend/Dockerfile exists"
else
    echo "❌ backend/Dockerfile is missing"
    exit 1
fi

# Check if package.json files exist
echo "📦 Checking package.json files..."
if [ -f "frontend/package.json" ]; then
    echo "✅ frontend/package.json exists"
else
    echo "❌ frontend/package.json is missing"
    exit 1
fi

if [ -f "backend/package.json" ]; then
    echo "✅ backend/package.json exists"
else
    echo "❌ backend/package.json is missing"
    exit 1
fi

# Validate Helm charts
echo "🔧 Validating Helm charts..."
if command -v helm &> /dev/null; then
    echo "✅ Helm is installed"
    
    # Test frontend chart
    if helm template frontend-chart --values frontend-chart/values.yaml > /dev/null 2>&1; then
        echo "✅ frontend-chart is valid"
    else
        echo "❌ frontend-chart has issues"
        exit 1
    fi
    
    # Test backend chart
    if helm template backend-chart --values backend-chart/values.yaml > /dev/null 2>&1; then
        echo "✅ backend-chart is valid"
    else
        echo "❌ backend-chart has issues"
        exit 1
    fi
else
    echo "⚠️  Helm is not installed, skipping chart validation"
fi

# Check GitHub secrets (informational)
echo "🔐 Checking GitHub secrets requirements..."
echo "ℹ️  Make sure these secrets are configured in your GitHub repository:"
echo "   - DOCKER_USERNAME"
echo "   - DOCKER_PASSWORD"
echo "   - SLACK_WEBHOOK_URL (optional)"

echo ""
echo "🎉 Project validation completed successfully!"
echo "✅ Your project is ready for Helm + Argo CD deployment"
echo ""
echo "📋 Next steps:"
echo "   1. Push this code to your GitHub repository"
echo "   2. Configure the required secrets in GitHub"
echo "   3. Make changes to trigger the workflow"
echo "   4. Monitor deployment in Argo CD UI" 