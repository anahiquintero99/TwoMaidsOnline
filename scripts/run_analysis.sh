#!/bin/bash

set -e
set -o pipefail

echo "🚀 Iniciando análisis completo de TwoMaidsOnline..."

# Cargar variables desde .env de forma segura
if [ -z "$SONAR_TOKEN" ]; then
  if [ -f .env ]; then
    echo "📦 Cargando variables de entorno desde .env"
    set -a
    # Solo exporta líneas con formato correcto clave=valor
    grep -E '^[A-Za-z_][A-Za-z0-9_]*=.*' .env > .env.cleaned
    source .env.cleaned
    rm .env.cleaned
    set +a
  fi
fi

# Verificación final del token
if [ -z "$SONAR_TOKEN" ]; then
  echo "❌ La variable de entorno SONAR_TOKEN no está definida."
  echo "🔐 Por favor, define SONAR_TOKEN antes de continuar."
  exit 1
fi

# Esperar a que SonarQube esté listo
echo "⏳ Esperando a que SonarQube esté listo..."
docker-compose exec web bash -c "
  until curl -s http://sonarqube:9000/api/system/health | grep -q '\"status\":\"UP\"'; do
    echo '⌛ Esperando que SonarQube se inicie...'
    sleep 5
  done
  echo '✅ SonarQube está listo.'
"

# Ejecutar pruebas de Django
echo "📋 Ejecutando tests de Django..."
docker-compose exec web python manage.py test --verbosity=2

# Generar coverage.xml
echo "📊 Generando reporte de coverage..."
docker-compose exec web coverage run --source='.' manage.py test
docker-compose exec web coverage xml -o coverage.xml

# Ejecutar análisis con SonarQube
echo "🔍 Ejecutando análisis de SonarQube..."
docker-compose exec -e SONAR_TOKEN=$SONAR_TOKEN web sonar-scanner \
  -Dsonar.projectKey=twomaidsonline \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://sonarqube:9000 \
  -Dsonar.login=$SONAR_TOKEN

echo "✅ Análisis completado con éxito!"
