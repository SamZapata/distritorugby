# Bosquejo de política de licencia, marca y servicios

> **Estado:** borrador de trabajo.  
> Este documento no constituye asesoría legal. Debe ser revisado y adaptado por un abogado especializado en software, propiedad intelectual, contratos y protección de datos en las jurisdicciones donde opere Distrito Rugby.

## 1. Separación de conceptos

Distrito Rugby debe comunicar por separado:

1. **El código del core:** software distribuido bajo GNU GPL v3.0.
2. **Los servicios comerciales:** hosting, soporte, implementación, capacitación, consultoría, personalizaciones e integraciones.
3. **La marca:** nombre, logotipo, dominios y elementos de identidad visual.
4. **Los datos:** información de clubes, jugadores, usuarios y clientes, sujeta a contratos y reglas de privacidad independientes.

La GPL regula el código que se distribuye; no concede automáticamente derechos sobre la marca, los dominios, los datos ni los servicios.

## 2. Política del core bajo GPL-3.0

### 2.1 Concesión

El core de Distrito Rugby se ofrece bajo los términos de la GNU General Public License, versión 3.0 (`GPL-3.0-or-later` solo si esa opción se adopta expresamente; de lo contrario, `GPL-3.0-only`).

La licencia permite usar, estudiar, modificar y redistribuir el software conforme a sus condiciones. Quien redistribuya el programa o una obra derivada debe cumplir las obligaciones de la GPL, incluyendo proporcionar los avisos correspondientes, conservar la licencia y ofrecer el código fuente requerido.

### 2.2 Sin garantía

El core se proporciona en los términos permitidos por la GPL y sin garantía, salvo que un contrato separado establezca expresamente otra cosa.

### 2.3 Marcas no incluidas

La licencia del código no concede permiso para usar:

- El nombre `Distrito Rugby`.
- El logotipo o sus variaciones.
- Dominios, perfiles oficiales o identificadores de redes sociales.
- Elementos que puedan hacer parecer oficial una copia modificada.

El uso de la marca se regula mediante una política separada.

### 2.4 Componentes de terceros

El repositorio debe identificar las licencias de gemas, paquetes, fuentes, iconos, imágenes, documentación y otros componentes de terceros. La GPL del core no sustituye ni modifica esas licencias.

## 3. Servicios pagos

Distrito Rugby puede ofrecer servicios comerciales alrededor del core, por ejemplo:

- Hosting administrado.
- Configuración y despliegue.
- Soporte y mantenimiento.
- Migración, limpieza y carga de datos.
- Capacitación y acompañamiento.
- Consultoría.
- Integraciones con proveedores externos.
- Desarrollo de funcionalidades a medida.
- Analítica, reportes o infraestructura operada como servicio.

Cobrar por esos servicios no contradice la GPL. El precio remunera el servicio, la infraestructura, el trabajo profesional o las obligaciones contractuales; no elimina las libertades que la GPL concede sobre el código que se distribuya.

### 3.1 Qué debe aclararse en cada contrato

Cada oferta o contrato debería indicar:

- Qué software GPL se utiliza.
- Qué se entrega al cliente y qué permanece operado como servicio.
- Qué código, si alguno, se distribuye al cliente.
- Cómo puede obtener el código fuente correspondiente cuando la GPL lo exija.
- Quién conserva la titularidad de las personalizaciones.
- Qué servicios son independientes del core.
- Niveles de soporte, disponibilidad y tiempos de respuesta.
- Copias de seguridad, exportación y devolución de datos.
- Medidas de seguridad y proveedores involucrados.
- Tratamiento de datos personales.
- Condiciones de terminación y migración de salida.

### 3.2 Personalizaciones

Antes de aceptar un desarrollo a medida se debe clasificarlo:

- **Modificación del core:** normalmente permanece sujeta a GPL cuando se redistribuye.
- **Componente independiente:** puede tener otra licencia si está realmente separado y la integración no lo convierte en una obra derivada.
- **Servicio no distribuido:** puede operar en infraestructura de Distrito Rugby, sujeto al contrato y a la ley aplicable.

Una carpeta `premium/`, un nombre comercial o un contrato no determinan por sí solos la licencia. La arquitectura, el acoplamiento técnico y la forma de distribución son determinantes. Esta clasificación debe revisarse legalmente.

## 4. Reserva y protección de la marca

### 4.1 Qué significa “reservar la marca”

No significa que el nombre quede protegido por mencionarlo en el README. Significa tomar medidas para demostrar y consolidar el control sobre los signos que identifican el proyecto:

- Investigar si `Distrito Rugby`, variantes y logotipo están disponibles.
- Registrar, si resulta viable, la marca ante la autoridad competente del país correspondiente.
- Asegurar la titularidad de dominios y cuentas oficiales.
- Documentar quién es el titular: persona natural, empresa, fundación o entidad futura.
- Conservar archivos originales, fechas y autores del logotipo.
- Definir una política de uso para forks, integraciones, proveedores y clientes.

Si el proyecto opera desde Colombia, la solicitud de registro debe evaluarse ante la autoridad colombiana competente en propiedad industrial, normalmente la Superintendencia de Industria y Comercio (SIC). El alcance, las clases, la titularidad y los países deben decidirse con asesoría local.

### 4.2 Por qué separar marca y código

La GPL permite que terceros hagan forks y redistribuyan el código. La marca puede reservarse para evitar que una versión modificada:

- Se presente como la versión oficial.
- Use el nombre en un dominio o producto no autorizado.
- Genere confusión sobre soporte, seguridad o afiliación.
- Perjudique la reputación del proyecto.

La política debe permitir describir compatibilidad de forma veraz, pero limitar la apariencia de respaldo oficial.

### 4.3 Política de uso de marca — bosquejo

**Uso permitido sin autorización adicional:**

- Referirse a Distrito Rugby como el proyecto original.
- Indicar que un producto es compatible con el core, si la afirmación es verificable.
- Enlazar al repositorio oficial.
- Redistribuir el código con los avisos de licencia exigidos.

**Uso que requiere autorización:**

- Incluir `Distrito Rugby` en el nombre principal de un producto o servicio derivado.
- Usar el logotipo oficial.
- Operar un servicio que se presente como hosting oficial.
- Usar dominios, perfiles o cuentas que sugieran afiliación.
- Publicar certificaciones, avales o asociaciones no concedidas.

**Uso no permitido:**

- Presentar un fork modificado como el producto oficial.
- Alterar el logotipo para aparentar una cuenta oficial.
- Usar la marca para ocultar cambios, vulnerabilidades o prácticas no aprobadas.
- Registrar dominios o marcas confundibles con la identidad oficial.

La versión definitiva debe incluir un canal de contacto, ejemplos gráficos y un procedimiento para solicitar permiso.

## 5. Titularidad y contribuciones

Antes de aceptar contribuciones externas, Distrito Rugby debe decidir si usará:

- Contribuciones de cada autor bajo GPL, conservando cada autor su copyright.
- Un Contributor License Agreement (CLA).
- Una cesión de derechos a una entidad titular.

Debe evitarse prometer una futura relicencia comercial si no existe autorización suficiente de todos los titulares. También se debe registrar la procedencia de código, imágenes, textos y diseños aportados por terceros.

## 6. Avisos recomendados para el repositorio

El repositorio debería incluir posteriormente:

- `LICENSE` con GPL-3.0.
- Aviso de copyright con titulares reales.
- `NOTICE` o inventario de licencias de terceros, cuando corresponda.
- `TRADEMARKS.md` o una sección equivalente sobre la marca.
- `CONTRIBUTING.md` con reglas para contribuciones.
- `SECURITY.md` con el canal de reporte responsable.
- Política de privacidad y términos del servicio cuando exista una plataforma operativa.

## 7. Lista de decisiones pendientes

- ¿GPL-3.0-only o GPL-3.0-or-later?
- ¿Quién será el titular legal de la marca y del copyright?
- ¿Se solicitará registro de marca en Colombia y en qué otras jurisdicciones?
- ¿Se aceptarán contribuciones sin CLA?
- ¿Qué módulos pertenecen al core?
- ¿Qué servicios se operarán sin distribuir código adicional?
- ¿Qué personalizaciones se ofrecerán y quién conservará sus derechos?
- ¿Qué datos tratará Distrito Rugby y bajo qué contratos?

## 8. Regla de publicación

No debe anunciarse una oferta comercial ni aceptar código de terceros como parte del core hasta que:

1. Se haya definido el titular legal.
2. Se hayan revisado las licencias y la procedencia de los componentes.
3. Se haya aprobado la separación entre core, servicios, marca y datos.
4. Se hayan preparado contratos y políticas de privacidad aplicables.
5. Un profesional haya revisado las cláusulas que impliquen propiedad intelectual o datos personales.
