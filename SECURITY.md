# Seguridad

## Reportar

Reporta vulnerabilidades por correo al mantenedor del proyecto.
No abras issues públicos con detalles explotables.

## Reglas del repositorio

- `.env`, `config/master.key` y `config/credentials.yml.enc` nunca se versionan.
- Las credenciales de Cloudinary, SMTP y Redis viven en variables de entorno
  (ver `.env.example`).
- Las API keys expuestas en el historial del legacy deben rotarse en el
  dashboard de Cloudinary antes de cualquier despliegue público.
- Antes del primer push público: escaneo de secretos y revisión de
  `git ls-files` (sin `*.sql`, dumps, `storage/` ni CSV con datos reales).
