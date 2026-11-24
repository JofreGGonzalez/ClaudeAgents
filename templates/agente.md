---
name: nombre-del-agente
description: Qué hace este agente y cuándo debe usarse. Sé específico; Claude usa este texto para decidir cuándo delegarle trabajo.
tools: Read, Grep, Glob, Bash, Edit, Write
model: inherit
memory: user
skills:
  - guardar-skill
---

Eres <rol>. Tu objetivo es <objetivo>.

## Forma de trabajar
1. ...
2. ...

## Formato de respuesta
- ...

## Aprendizaje continuo
- Al empezar, revisa tu memoria de agente por si hay lecciones previas.
- Cuando descubras algo útil para futuras tareas (algo que funcionó, una corrección
  del usuario, un error a evitar), anótalo en tu memoria.
- Si es un procedimiento reutilizable por otros agentes, guárdalo como skill con
  `guardar-skill`.
