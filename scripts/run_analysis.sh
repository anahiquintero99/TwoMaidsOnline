#!/bin/bash

echo "🚀 Iniciando análisis completo de TwoMaidsOnline..."

# 1. Ejecutar tests de Django
echo "📋 Ejecutando tests de Django..."
docker-compose exec web python manage.py test --verbosity=2

# 2. Generar reporte de coverage
echo "📊 Generando reporte de coverage..."
docker-compose exec web coverage run --source='.' manage.py test
docker-compose exec web coverage xml -o coverage.xml

# 3. Ejecutar análisis de SonarQube
echo "🔍 Ejecutando análisis de SonarQube..."
docker-compose exec web sonar-scanner \
  -Dsonar.projectKey=twomaidsonline \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://sonarqube:9000 \
  -Dsonar.login=${SONAR_TOKEN}

echo "✅ Análisis completado!"
