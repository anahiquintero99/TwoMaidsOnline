FROM python:3.11-slim

# Evita archivos .pyc y hace flush automático del output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Instala herramientas necesarias y sonar-scanner
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libpq-dev \
    postgresql-client \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copia dependencias primero para aprovechar el cache
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

# Copia el resto del código
COPY . .

# Crea carpeta de estáticos
RUN mkdir -p /app/staticfiles
