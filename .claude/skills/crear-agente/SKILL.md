---
name: crear-agente
description: Crea un nuevo agente (subagente de Claude Code) y lo guarda en el repositorio ClaudeAgents. Úsala cuando el usuario pida crear, definir o configurar un agente nuevo.
---

# Crear un agente

1. Pregunta (solo si no está claro) el **propósito** del agente, las **herramientas**
   que necesita y el **modelo** preferido (por defecto `inherit`).
2. Elige un nombre `kebab-case` y comprueba que no exista ya en `.claude/agents/`.
3. Copia `templates/agente.md` a `.claude/agents/<nombre>.md` y rellénalo:
   - `description`: cuándo debe usarse el agente (Claude la usa para decidir delegar).
   - `memory: user` para que el agente acumule lo que aprende entre sesiones
     (se guarda en `~/.claude/agent-memory/<nombre>/`, que el instalador enlaza a
     `.claude/agent-memory/` de este repo).
   - `skills:` con las skills del repo que el agente debe cargar siempre.
   - Cuerpo: rol, forma de trabajar, formato de respuesta y la sección
     "Aprendizaje continuo" de la plantilla (no la quites).
4. Si el agente necesita conocimiento propio desde el principio, crea su skill con
   `guardar-skill` y añádela a su campo `skills:`.
5. Añade el agente a la tabla *Agentes* de `README.md` y anótalo en la columna "Agentes que la usan" de cada skill de su campo `skills:`.
6. Ejecuta `scripts/sync.sh "Añade agente <nombre>"`.
