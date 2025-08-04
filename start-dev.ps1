Write-Host "🚀 Iniciando entorno de desarrollo TwoMaidsOnline con Skaffold y Minikube..."

# 1. Verificar estado de Minikube
Write-Host "🔍 Verificando estado de Minikube..."
$minikubeStatus = & minikube status | Out-String

if ($minikubeStatus -notlike "*Running*") {
    Write-Host "⚙️  Minikube no está corriendo. Iniciando Minikube con driver Docker..."
    minikube start --driver=docker
} else {
    Write-Host "✅ Minikube ya está corriendo."
}

# 2. Configurar entorno Docker para apuntar a Minikube
Write-Host "🔄 Configurando entorno Docker para usar Minikube..."
& minikube -p minikube docker-env | Invoke-Expression

# 3. Ejecutar Skaffold
Write-Host "🔥 Ejecutando 'skaffold dev' para despliegue y monitoreo en caliente..."
skaffold dev
