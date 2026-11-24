#!/usr/bin/env bash
# Instala ClaudeAgents en este ordenador (Linux/macOS).
# Enlaza agentes, skills y memoria de ~/.claude a este repositorio, para que
# estén disponibles en cualquier proyecto y todo lo aprendido quede en el repo.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
STAMP="$(date +%Y%m%d-%H%M%S)"
mkdir -p "$CLAUDE_HOME"

link_dir() {  # $1 = nombre de carpeta (agents | skills | agent-memory)
  local src="$REPO/.claude/$1" dst="$CLAUDE_HOME/$1"
  mkdir -p "$src"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -d "$dst" ]; then
    # Conserva lo que ya hubiera: lo copia al repo (sin sobrescribir) y hace copia de seguridad.
    cp -Rn "$dst"/. "$src"/ 2>/dev/null || true
    mv "$dst" "$dst.backup-$STAMP"
    echo "  · $dst existía: contenido fusionado en el repo, copia en $dst.backup-$STAMP"
  fi
  ln -s "$src" "$dst"
  echo "  ✓ $dst -> $src"
}

echo "Instalando ClaudeAgents desde $REPO"
link_dir agents
link_dir skills
link_dir agent-memory

# Instrucciones globales para que Claude guarde aquí lo que aprenda, trabaje donde trabaje.
GLOBAL_MD="$CLAUDE_HOME/CLAUDE.md"
START="<!-- claudeagents:start -->"; END="<!-- claudeagents:end -->"
touch "$GLOBAL_MD"
python3 - "$GLOBAL_MD" "$START" "$END" "$REPO" <<'PY'
import re, sys
path, start, end, repo = sys.argv[1:]
block = f"""{start}
## ClaudeAgents
Mis agentes y skills viven en el repositorio `{repo}`
(enlazado en ~/.claude/agents, ~/.claude/skills y ~/.claude/agent-memory).
- Al crear un agente, usa la skill `crear-agente`.
- Cuando aprendas algo reutilizable, usa la skill `guardar-skill`.
- Después de cambiar agentes, skills o memoria, ejecuta
  `{repo}/scripts/sync.sh "mensaje"` para subirlo a GitHub.
{end}"""
text = open(path, encoding="utf-8").read()
pattern = re.compile(re.escape(start) + ".*?" + re.escape(end), re.S)
text = pattern.sub(block, text) if pattern.search(text) else (text.rstrip() + "\n\n" + block + "\n").lstrip()
open(path, "w", encoding="utf-8").write(text)
PY
echo "  ✓ Instrucciones añadidas a $GLOBAL_MD"

# Hook opcional: al empezar cada sesión de Claude Code, trae los últimos cambios del repo.
if [ "${1:-}" != "--sin-hook" ]; then
  python3 - "$CLAUDE_HOME/settings.json" "$REPO" <<'PY'
import json, os, sys
path, repo = sys.argv[1:]
cfg = json.load(open(path)) if os.path.exists(path) and os.path.getsize(path) else {}
cmd = f'git -C "{repo}" pull --quiet --rebase --autostash >/dev/null 2>&1 || true'
hooks = cfg.setdefault("hooks", {}).setdefault("SessionStart", [])
if not any(h.get("command") == cmd for e in hooks for h in e.get("hooks", [])):
    hooks.append({"hooks": [{"type": "command", "command": cmd}]})
json.dump(cfg, open(path, "w"), indent=2)
PY
  echo "  ✓ Hook SessionStart (git pull automático) en $CLAUDE_HOME/settings.json"
fi

echo "Listo. Reinicia Claude Code para que cargue los agentes y skills."
