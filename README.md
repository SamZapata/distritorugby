# Distrito Rugby

Plataforma abierta para la comunidad del rugby: clubes, equipos, jugadores, torneos y contenido.

[![Ruby](https://img.shields.io/badge/Ruby-3.2.4-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1-D30001?logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15%2B-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-GPL--3.0-blue)](LICENSE)

## ¿Qué es Distrito Rugby?

Distrito Rugby es una plataforma web para centralizar y compartir la información del ecosistema del rugby. Reúne clubes, categorías, equipos, jugadores, torneos, partidos y estadísticas, junto con noticias e historias de la comunidad.

El proyecto nace con un enfoque local en Cali, Colombia, y una vocación abierta y colaborativa: facilitar que clubes, ligas y aficionados gestionen y difundan su actividad deportiva.

## Características

- **Dominio deportivo:** clubes, categorías, horarios, equipos y plantillas, jugadores, entrenadores y árbitros.
- **Competición:** torneos, grupos, partidos y estadísticas.
- **Contenido:** noticias, historias y etiquetas.
- **Experiencia:** home dinámico y perfiles de usuario.
- **Acceso:** autenticación con Devise y roles de alcance limitado (`user`, `club_admin`, `league_admin`, `super_admin`).

## Stack tecnológico

| Área            | Tecnología                                              |
| --------------- | ------------------------------------------------------- |
| Lenguaje        | Ruby 3.2.4                                              |
| Framework       | Ruby on Rails 7.1                                       |
| Base de datos   | PostgreSQL 15+                                          |
| Autenticación   | Devise                                                  |
| Autorización    | CanCanCan                                               |
| Vistas          | Haml, Bootstrap 5, jQuery y Turbo                       |
| Activos         | Sprockets                                               |
| Servidor        | Puma                                                    |
| Archivos        | Active Storage (local en desarrollo, Cloudinary en prod)|
| Tiempo real     | Action Cable (Redis en producción)                      |
| URLs amigables  | FriendlyId                                              |

## Estado del proyecto

Distrito Rugby se encuentra **en desarrollo activo**. El núcleo del dominio deportivo, la autenticación y la gestión de contenido están implementados y cubiertos por una suite de pruebas automatizadas con Minitest.

Las siguientes etapas incluyen la consolidación del flujo de competición, mejoras de experiencia de usuario, búsqueda, API pública y automatización del despliegue.

> El proyecto aún no está listo para producción.

## Requisitos

- Ruby 3.2.4 (ver `.ruby-version`)
- Bundler
- PostgreSQL 15+
- Docker y Docker Compose (opcional)

## Instalación y ejecución local

```bash
git clone https://github.com/SamZapata/distritorugby.git
cd distritorugby
bundle install
cp .env.example .env   # completa las variables requeridas
bin/rails db:prepare   # crea y migra la base de datos
bin/rails server
```

La aplicación queda disponible en [http://localhost:3000](http://localhost:3000). El health check está en [http://localhost:3000/up](http://localhost:3000/up).

Todas las credenciales se gestionan mediante variables de entorno. `.env` no se versiona; usa `.env.example` como plantilla para la base de datos, Cloudinary, SMTP y Redis.

## Docker

```bash
cp .env.example .env
docker compose up --build
```

- La base de datos se crea y migra automáticamente al arrancar.
- La aplicación se publica en `http://localhost:3000` y PostgreSQL en `localhost:5433`.
- Los datos persisten en el volumen `pgdata`; `docker compose down` los conserva y `docker compose down -v` los elimina.
- No ejecutes Docker y `bin/rails server` al mismo tiempo: ambos usan el puerto 3000.

## Datos de ejemplo

```bash
bin/rails db:seed
```

El comando carga registros ficticios e idempotentes para desarrollo y demostración. No uses datos personales reales en semillas, fixtures ni pruebas.

## Pruebas

```bash
bin/rails test
```

La suite utiliza Minitest, fixtures y pruebas de integración. Para ejecutar un archivo concreto:

```bash
bin/rails test test/models/user_test.rb
```

## Estructura del proyecto

```text
app/
  controllers/   Solicitudes HTTP y respuestas
  models/        Modelos, asociaciones y reglas de dominio
  services/      Objetos de servicio
  views/         Plantillas Haml
config/          Configuración, rutas y entornos
db/              Esquema, migraciones y semillas
test/            Pruebas automatizadas
```

## Contribuir

Las contribuciones son bienvenidas. Antes de abrir un issue o un pull request, revisa [CONTRIBUTING.md](CONTRIBUTING.md).

- No incluyas secretos, credenciales ni datos personales reales.
- Para reportar vulnerabilidades, sigue las indicaciones de [SECURITY.md](SECURITY.md).
- El uso de la marca está regulado por [TRADEMARKS.md](TRADEMARKS.md).

## Licencia

Este proyecto se distribuye bajo la [GNU General Public License v3.0](LICENSE).

## Comunidad

- [Instagram: @distritorugby](https://www.instagram.com/distritorugby)
- [Facebook: Distrito Rugby Cali](https://www.facebook.com/distritorugbycali/)
