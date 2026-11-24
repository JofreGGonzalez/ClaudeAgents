---
name: guardar-skill
description: Guarda en el repositorio ClaudeAgents algo aprendido (procedimiento, corrección, preferencia del usuario, truco) como skill nueva o ampliando una existente, y lo sube a GitHub. Úsala cuando se aprenda algo reutilizable o el usuario diga "aprende esto", "recuerda esto" o "guárdalo como skill".
---

# Guardar una skill

1. **Decide si merece una skill.** Sí: procedimientos repetibles, conocimiento de
   dominio, preferencias estables del usuario, errores a evitar. No: datos de una
   sola tarea, información temporal, secretos.
2. **Busca antes de crear.** Revisa `.claude/skills/*/SKILL.md`. Si ya hay una skill
   del mismo tema, amplíala en lugar de duplicar.
3. **Skill nueva:** copia `templates/skill/SKILL.md` a
   `.claude/skills/<nombre>/SKILL.md`. La `description` debe decir *qué hace* y
   *cuándo usarla* (es lo que Claude lee para activarla). Si necesitas material
   largo, ponlo en archivos aparte dentro de la carpeta (`referencia.md`,
   scripts…) y enlázalo desde `SKILL.md`.
4. **Escribe instrucciones accionables**: pasos concretos, ejemplos, y el porqué
   de cada regla. Sé breve; mejor 40 líneas útiles que 300 genéricas.
5. Añade una línea al `## Historial` de la skill: `- AAAA-MM-DD: qué se añadió`.
6. Si la skill es de un agente concreto, añádela a su campo `skills:`.
7. Actualiza la tabla *Skills* de `README.md`, incluida la columna "Agentes que la usan".
8. Ejecuta `scripts/sync.sh "Skill <nombre>: <resumen>"`.
