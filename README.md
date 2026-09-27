# Distrito Rugby

Plataforma abierta para compartir información, contenidos y herramientas relacionadas con el rugby y sus comunidades.

## Estado del proyecto

Repositorio en migración limpia desde `distritorugby-legacy`. **Lotes 1 y 2 completados:** base reproducible (Ruby/Rails/Docker), persistencia (44 migraciones, modelos base) y autenticación con Devise + autorización mínima con CanCanCan. La aplicación funcional se migrará por lotes (flujos y dominio deportivo).

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
bin/rails db:prepare   # crea y migra la base la primera vez
bin/rails server
```

Health check: `http://localhost:3000/up`

En development las imágenes se guardan en `storage/` (local); Cloudinary queda
configurado solo para producción.

### Con Docker

```bash
cp .env.example .env   # POSTGRES_* requeridos por docker-compose
docker compose up --build
```

- La base se crea y migra automáticamente al arrancar (`db:prepare` en el
  comando del contenedor `web`).
- Los datos viven en el volumen `distritorugby_pgdata`; `docker compose down`
  los conserva, `docker compose down -v` los borra (reset completo).
- No levantes Docker y `bin/rails server` al mismo tiempo: compiten por el
  puerto 3000.

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
