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

```bash
python -m venv env
source env/bin/activate # En Windows: env\Scripts\activate
```

### 3. Instalar dependencias

```bash
pip install -r requirements.txt
Si aún no existe un requirements.txt, puedes generarlo con:
```

```bash
pip freeze > requirements.txt 4. Migrar la base de datos
```

```bash
python manage.py migrate 5. Levantar el servidor
```

```bash
python manage.py runserver
Luego abre tu navegador y visita:


👉 http://127.0.0.1:8000
```

### 🧪 Comandos útiles

Crear superusuario

```bash
python manage.py createsuperuser
Aplicar migraciones
```

```bash
python manage.py makemigrations
python manage.py migrate
```

### 📁 Estructura general del proyecto

```bash

TwoMaidsOnline/
├── config/ # Configuración principal de Django
├── app/ # Aquí van tus aplicaciones
├── env/ # Entorno virtual (no se sube a Git)
├── manage.py # Script principal de Django
└── requirements.txt # Dependencias del proyecto

```

### ✅ Git Ignore

Asegúrate de tener un archivo .gitignore con lo siguiente:

```bash
env/
**pycache**/
\*.pyc
db.sqlite3
.env
```

# Guía de Docker para Django

## Pasos para configurar el entorno

### 1. Crear los archivos necesarios

Crea los siguientes archivos en la raíz de tu proyecto:

- `Dockerfile`
- `docker-compose.yml`
- `requirements.txt`
- `.dockerignore`
- `.env`

### 2. Comandos básicos

#### Construir y levantar los contenedores

```bash
# Construir los servicios
docker-compose build

# Levantar los servicios
docker-compose up -d

# Ver logs
docker-compose logs -f web
```

#### Comandos de Django dentro del contenedor

```bash
# Ejecutar migraciones
docker-compose exec web python manage.py migrate

# Crear superusuario
docker-compose exec web python manage.py createsuperuser

# Collect static files
docker-compose exec web python manage.py collectstatic --noinput

# Ejecutar shell de Django
docker-compose exec web python manage.py shell

# Ejecutar comandos personalizados
docker-compose exec web python manage.py <tu_comando>
```

#### Gestión de contenedores

```bash
# Parar todos los servicios
docker-compose down

# Parar y eliminar volúmenes
docker-compose down -v

# Reiniciar un servicio específico
docker-compose restart web

# Ver estado de los contenedores
docker-compose ps
```

#### Base de datos

```bash
# Conectar a PostgreSQL
docker-compose exec db psql -U postgres -d twomaidsonline

# Backup de la base de datos
docker-compose exec db pg_dump -U postgres twomaidsonline > backup.sql

# Restaurar backup
docker-compose exec -T db psql -U postgres -d twomaidsonline < backup.sql
```

### 3. Desarrollo

#### Para desarrollo local

```bash
# Levantar con reload automático
docker-compose up

# Instalar nuevas dependencias
docker-compose exec web pip install <package>
docker-compose exec web pip freeze > requirements.txt
docker-compose build web  # Reconstruir después de cambios en requirements
```

#### Variables de entorno

Asegúrate de configurar correctamente el archivo `.env` con tus valores específicos:

- `SECRET_KEY`: Genera una clave secreta para Django
- `DEBUG`: Establece en `0` para producción
- `ALLOWED_HOSTS`: Agrega tus dominios de producción

### 4. Acceder a la aplicación

- Django: http://localhost:8000
- PostgreSQL: localhost:5432
- Redis: localhost:6379

### 5. Solución de problemas comunes

#### Si tienes problemas con permisos

```bash
# Cambiar propietario de archivos
sudo chown -R $USER:$USER .
```

#### Si necesitas reconstruir completamente

```bash
# Eliminar todo y empezar de nuevo
docker-compose down -v --rmi all
docker-compose build --no-cache
docker-compose up -d
```

#### Ver logs de errores

```bash
# Logs de un servicio específico
docker-compose logs web
docker-compose logs db
```
