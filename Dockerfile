# Imagen base liviana con Python 3.11
FROM python:3.11-slim

# Configura entorno para mejor rendimiento y logs claros
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Establece directorio de trabajo
WORKDIR /app

# Instala dependencias del sistema necesarias y sonar-scanner
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libpq-dev \
        openjdk-17-jre \
        postgresql-client \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copia requirements primero (para aprovechar el cache si no cambian)
COPY requirements.txt .

# Instala dependencias de Python y sonar-scanner
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install coverage && \
    curl -sSLo sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip sonar-scanner.zip -d /opt && \
    mv /opt/sonar-scanner-* /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm sonar-scanner.zip

# Copia el resto del proyecto
COPY . .

# Crea carpeta para archivos estáticos
RUN mkdir -p /app/staticfiles
