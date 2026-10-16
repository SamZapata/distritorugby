# Distrito Rugby

Plataforma abierta para compartir información, contenidos y herramientas relacionadas con el rugby y sus comunidades.

## Estado del proyecto

Repositorio en migración limpia desde `distritorugby-legacy` (congelado, solo lectura).
**Lotes 0-6 completados:** base reproducible, persistencia y auth (Devise + CanCanCan),
flujo vertical de clubes con roles (`user`/`club_admin`/`league_admin`/`super_admin`),
dominio deportivo (clubes, categorías, equipos, jugadores, torneos, grupos, partidos,
stats, entrenadores, árbitros), contenido (noticias, historias, tags, servicios),
home dinámico y semillas sintéticas. Ver `../assistant/from_migration/migracion-limpia.md`
(histórico) y `../assistant/current-status.md` (estado actual).

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

Suite actual (verificada 2026-10-15): 129 runs / 368 assertions, 0 fallas,
0 errores, 0 skips. Ver `../assistant/current-status.md`.

## Datos de desarrollo

```bash
bin/rails db:seed   # crea registros demo ficticios (idempotente)
```

Los CSV con datos reales del legacy nunca se migran (contienen PII).

## Variables de entorno

Todas las credenciales viven en `.env` (nunca se versiona). Ver `.env.example` con la descripción de cada variable: base de datos, Cloudinary, SMTP y Redis.

## Licencia

Este proyecto se distribuye bajo la licencia [GNU General Public License v3.0](LICENSE).

## Comunidad

- [Instagram: @distritorugby](https://www.instagram.com/distritorugby)
- [Facebook: Distrito Rugby Cali](https://www.facebook.com/distritorugbycali/)
