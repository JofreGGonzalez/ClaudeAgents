---
name: publicar-prototipos-html
description: Convenciones para entregar prototipos HTML de dashboards que se publican como artefacto
type: reference
---
- Lienzo de diseño 1920×1080 con escalado proporcional al contenedor.
- Datos de muestra rotulados claramente como ficticios.
- Si se publica como artefacto, entregar un fragmento (estilos + marcado + script)
  sin `<html>`, `<head>` ni `<body>`.
- Todo el CSS acotado a un contenedor raíz para no chocar con la página anfitriona.
- Una sola fuente de verdad para los colores (variables CSS) para cambiar de
  paleta sin tocar el resto.
