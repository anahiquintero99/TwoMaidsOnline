Write-Host "🚀 Iniciando entorno de desarrollo TwoMaidsOnline con Skaffold y Minikube..."

# 1. Iniciar Minikube (si no está corriendo)
$minikubeStatus = & minikube status | Out-String
if ($minikubeStatus -notlike "*Running*") {
    Write-Host "⚙️  Minikube no está corriendo. Iniciando..."
    minikube start --driver=docker
} else {
    Write-Host "✅ Minikube ya está corriendo."
}

# 2. Cargar entorno de Docker dentro de Minikube
Write-Host "🔄 Configurando entorno Docker para usar Minikube..."
& minikube -p minikube docker-env | Invoke-Expression

# 3. Iniciar Skaffold
Write-Host "🔥 Ejecutando skaffold dev..."
skaffold dev
