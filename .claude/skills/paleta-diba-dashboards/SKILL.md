---
name: paleta-diba-dashboards
description: Paleta y patrones de diseño para dashboards Qlik Sense de la Diputació de Barcelona (Diba) en catalán, con el prototipo HTML de satisfacció d'esdeveniments como referencia. Úsala al diseñar cualquier dashboard para Diba.
---

# Paleta Diba para dashboards

## Valores usados (aproximados, NO verificados contra el manual oficial)
- Granate principal: Pantone 201 C ~ #9D2235 (en un document de la Diba: "pantone 201 C o C25 M96 Y73 K18").
- Groc accent: Pantone 106 C ~ #F9E547 (mismo documento, imagotip).
- Derivados: #7E1B2B, #C26A77, #E3B7BE, #FAF1F3; neutros #2B2B2E, #6B6B72, #A7A7AD, fondo #F4F2F0.
- Semàfor/NPS (no corporativos, solo estados, con icono además de color): #2E8B6A, #E3A21A, #D64545.

## Aviso
diba.cat, seuelectronica.diba.cat, brandfetch y wikipedia no resuelven en el sandbox (host no permitido): no se pudo leer el manual. Si el usuario habilita esos dominios o aporta el manual, verificar HEX y actualizar esta skill.

## Patrones
- Header granate con acento groc; serie "actual" en granate y "comparativa" en gris.
- KPIs ejecutivos arriba, justo bajo filtros; datos de muestra marcados con badge.
- Escalado 1920x1080 con transform: scale en JS; captura con Playwright (NODE_PATH=$(npm root -g)).

## Historial
- 2026-11-24: creada con el dashboard "Satisfacció amb l'esdeveniment".
