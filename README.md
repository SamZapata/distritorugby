# Distrito Rugby

Plataforma abierta para compartir información, contenidos y herramientas relacionadas con el rugby y sus comunidades.

## Estado del proyecto

Repositorio en migración limpia desde `distritorugby-legacy`. **Lote 1 completado:** base reproducible (Ruby/Rails/Docker) instalable y verificable. La aplicación funcional se migrará por lotes (persistencia, autenticación, flujos y dominio deportivo).

## Requisitos

- Ruby 3.2.4 (ver `.ruby-version`)
- Bundler
- PostgreSQL 15+
- (opcional) Docker + Docker Compose

## Instalación

```bash
git clone git@github.com:SamZapata/distritorugby.git
cd distritorugby
bundle install
cp .env.example .env   # y rellena los valores reales
bin/rails db:create db:migrate
bin/rails server
```

Health check: `http://localhost:3000/up`

### Con Docker

```bash
cp .env.example .env   # POSTGRES_* requeridos por docker-compose
docker compose up --build
```

## Pruebas

```bash
bin/rails test
```

## Variables de entorno

Todas las credenciales viven en `.env` (nunca se versiona). Ver `.env.example` con la descripción de cada variable: base de datos, Cloudinary, SMTP y Redis.

## Licencia

Este proyecto se distribuye bajo la licencia [GNU General Public License v3.0](LICENSE).

## Comunidad

- [Instagram: @distritorugby](https://www.instagram.com/distritorugby)
- [Facebook: Distrito Rugby Cali](https://www.facebook.com/distritorugbycali/)
