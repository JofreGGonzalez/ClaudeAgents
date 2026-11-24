# ClaudeAgents — instrucciones para Claude

Este repositorio es el **almacén central** de los agentes y skills del usuario.
Todo lo que se cree o aprenda debe quedar guardado aquí y subido a GitHub para
poder usarlo desde cualquier ordenador.

## Dónde va cada cosa

| Qué | Dónde | Formato |
|---|---|---|
| Agentes (subagentes) | `.claude/agents/<nombre>.md` | Frontmatter YAML + prompt de sistema |
| Skills (conocimiento reutilizable) | `.claude/skills/<nombre>/SKILL.md` | Frontmatter YAML + instrucciones |
| Memoria que acumula cada agente | `.claude/agent-memory/<nombre>/` | Lo gestiona Claude Code (campo `memory:`) |
| Plantillas | `templates/` | No se cargan; solo sirven de base |

Nombres siempre en `kebab-case`, sin acentos ni espacios.

## Reglas

1. **Al crear un agente** usa la skill `crear-agente`.
2. **Cuando un agente (o tú) aprenda algo reutilizable** — un procedimiento que
   funcionó, una corrección del usuario, una preferencia, un truco — usa la skill
   `guardar-skill` para guardarlo como skill nueva o ampliar una existente.
3. Tras cualquier cambio en agentes, skills o memoria: **commit y push**
   (`scripts/sync.sh "mensaje"`), para que esté disponible en los demás ordenadores.
4. Actualiza el índice de `README.md` (sección *Agentes* / *Skills*) al añadir o
   eliminar algo.
5. Nunca guardes secretos (API keys, contraseñas, tokens) en agentes, skills o memoria.
