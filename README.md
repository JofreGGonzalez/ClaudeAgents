# ClaudeAgents

Repositorio central de mis **agentes** y **skills** de Claude Code. Todo lo que
los agentes aprenden se guarda aquí, así que basta con clonarlo para tener los
agentes entrenados en cualquier ordenador.

## Estructura

```
.claude/
  agents/          # Un archivo .md por agente (subagentes de Claude Code)
  skills/          # Una carpeta por skill, con su SKILL.md
  agent-memory/    # Memoria persistente que acumula cada agente
templates/         # Plantillas de agente y de skill
scripts/
  install.sh       # Instalación en Linux/macOS
  install.ps1      # Instalación en Windows
  sync.sh          # Pull + commit + push
CLAUDE.md          # Reglas para que Claude guarde aquí lo que crea y aprende
```

## Instalar en un ordenador nuevo

Linux / macOS:

```bash
git clone https://github.com/JofreGGonzalez/ClaudeAgents.git ~/ClaudeAgents
```

```bash
~/ClaudeAgents/scripts/install.sh
```

Windows (PowerShell):

```powershell
git clone https://github.com/JofreGGonzalez/ClaudeAgents.git $HOME\ClaudeAgents
& $HOME\ClaudeAgents\scripts\install.ps1
```

El instalador:
1. Enlaza `~/.claude/agents`, `~/.claude/skills` y `~/.claude/agent-memory` a este
   repo, así los agentes y skills están disponibles en **cualquier proyecto** y lo
   que aprendan se escribe directamente aquí. Si ya tenías algo en esas carpetas,
   lo fusiona en el repo y deja una copia de seguridad.
2. Añade a `~/.claude/CLAUDE.md` unas instrucciones para que Claude use
   `crear-agente` / `guardar-skill` y suba los cambios.
3. (Solo Linux/macOS) Añade un hook que hace `git pull` al empezar cada sesión,
   para tener siempre lo último. Desactívalo con `install.sh --sin-hook`.

## Uso diario

- *"Crea un agente que …"* → Claude usa la skill `crear-agente`.
- *"Aprende esto / guárdalo como skill"* → Claude usa la skill `guardar-skill`.
- Los agentes con `memory: user` anotan solos sus lecciones en `.claude/agent-memory/`.
- Para subir cambios a mano: `scripts/sync.sh "mensaje"`.

## Agentes

| Agente | Descripción |
|---|---|
| `QlikSenseAgent` | Diseña dashboards de Qlik Sense: mockups/prototipos, sistema de diseño con la paleta corporativa del cliente y especificación para Qlik Sense |

## Skills

| Skill | Descripción | Agentes que la usan |
|---|---|---|
| `crear-agente` | Crea un agente nuevo con la plantilla y lo sube al repo | _(ninguno; la usa Claude directamente)_ |
| `guardar-skill` | Guarda lo aprendido como skill (nueva o ampliada) y lo sube al repo | `QlikSenseAgent` |
| `qlik-dashboards-preferencias` | Preferencias del usuario en dashboards Qlik Sense (KPIs arriba, filtros en panel lateral, paleta corporativa, idioma) | `QlikSenseAgent` |
