# TwoMaidsOnline 🧹 - Proyecto Base en Django

Este repositorio contiene el proyecto base del sistema **TwoMaidsOnline**, desarrollado con Django.

## 🚀 Requisitos

- Python 3.13.1
- Git
- (Opcional) Virtualenv o entorno virtual

## 🛠️ Instrucciones para correr el proyecto localmente

### 1. Clonar el repositorio

```bash
git clone https://github.com/anahiquintero99/TwoMaidsOnline.git
cd TwoMaidsOnline
```

### 2. Crear y activar un entorno virtual

bash
Copiar
Editar
python -m venv env
source env/bin/activate # En Windows: env\Scripts\activate

### 3. Instalar dependencias

bash
Copiar
Editar
pip install -r requirements.txt
Si aún no existe un requirements.txt, puedes generarlo con:

bash
Copiar
Editar
pip freeze > requirements.txt 4. Migrar la base de datos
bash
Copiar
Editar
python manage.py migrate 5. Levantar el servidor
bash
Copiar
Editar
python manage.py runserver
Luego abre tu navegador y visita:

👉 http://127.0.0.1:8000

### 🧪 Comandos útiles

Crear superusuario
bash
Copiar
Editar
python manage.py createsuperuser
Aplicar migraciones
bash
Copiar
Editar
python manage.py makemigrations
python manage.py migrate
📁 Estructura general del proyecto
bash
Copiar
Editar

TwoMaidsOnline/
├── config/ # Configuración principal de Django
├── app/ # Aquí van tus aplicaciones
├── env/ # Entorno virtual (no se sube a Git)
├── manage.py # Script principal de Django
└── requirements.txt # Dependencias del proyecto

### ✅ Git Ignore

Asegúrate de tener un archivo .gitignore con lo siguiente:

bash
Copiar
Editar
env/
**pycache**/
\*.pyc
db.sqlite3
.env
