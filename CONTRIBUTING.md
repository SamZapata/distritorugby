# Contribuir a Distrito Rugby

## Flujo

1. Abre un issue antes de cambios grandes.
2. Trabaja en ramas pequeñas y revisables, un lote a la vez.
3. Cada cambio incluye o actualiza pruebas (`bin/rails test` en verde).
4. No copies código del legacy sin clasificarlo (ver matriz de clasificación):
   `migrar`, `adaptar`, `reconstruir`, `documentar externamente`, `descartar`.

## Reglas

- Nunca subas secretos: `.env`, `master.key`, `credentials.yml.enc`, dumps,
  `storage/` ni datos reales (ver `SECURITY.md`).
- Sin datos personales en seeds, fixtures ni commits.
- Imágenes y PDFs solo con licencia confirmada.
- Mensajes de commit en español, imperativos y con alcance del lote.
