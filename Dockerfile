# Dockerfile
FROM ruby:3.2.4

# Dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  git \
  postgresql-client \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Crear y usar directorio de la app
WORKDIR /app

# Copiar Gemfile y Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar bundler y gems
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copiar el resto del proyecto
COPY . .

# Puerto expuesto por Rails
EXPOSE 3000

# Comando por defecto
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bin/rails server -b 0.0.0.0"]
