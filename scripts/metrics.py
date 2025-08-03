#!/usr/bin/env python3
import subprocess
import os

def run_sonar_analysis():
    """Ejecuta análisis de SonarQube y muestra el resultado."""
    print("🔍 Ejecutando análisis de SonarQube...")

    try:
        result = subprocess.run(['docker-compose', 'exec', 'web', 'sonar-scanner'], capture_output=True, text=True)
        print(result.stdout)

        if result.returncode == 0:
            print("✅ Análisis de SonarQube completado correctamente.")
            return True
        else:
            print("❌ Error en análisis de SonarQube:")
            print(result.stderr)
            return False

    except FileNotFoundError:
        print("❌ No se encontró sonar-scanner. Verifica que esté instalado dentro del contenedor.")
        return False


def check_required_files():
    """Verifica que existan los archivos clave de integración."""
    required_files = ['skaffold.yaml', 'k8s-deployment.yaml']
    all_exist = True

    print("📁 Verificando archivos necesarios para Cloud Code...")

    for file in required_files:
        if os.path.isfile(file):
            print(f"✅ {file} encontrado.")
        else:
            print(f"❌ {file} NO encontrado.")
            all_exist = False

    return all_exist


if __name__ == "__main__":
    print("🔄 Iniciando verificación de sincronización...\n")

    sonar_status = run_sonar_analysis()
    files_status = check_required_files()

    print("\n🧩 Resultado final:")
    if sonar_status and files_status:
        print("🎉 Todo está sincronizado correctamente entre Cloud Code y SonarQube.")
    else:
        print("⚠️ Se encontraron problemas. Revisa los mensajes anteriores.")
