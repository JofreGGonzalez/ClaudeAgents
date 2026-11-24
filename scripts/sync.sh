#!/usr/bin/env bash
# Sincroniza el repositorio con GitHub: trae cambios, guarda los locales y los sube.
# Uso: scripts/sync.sh "mensaje del commit"
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
MSG="${1:-Actualiza agentes y skills}"

git pull --rebase --autostash --quiet || echo "Aviso: no se pudo hacer pull (¿sin red?)"
git add -A
if git diff --cached --quiet; then
  echo "Nada que guardar."
else
  git commit -m "$MSG" --quiet
  echo "✓ Commit: $MSG"
fi
for i in 1 2 3 4; do
  git push --quiet -u origin HEAD && { echo "✓ Subido a GitHub"; exit 0; }
  sleep $((2 ** i))
done
echo "✗ No se pudo hacer push; se reintentará en la próxima sincronización." >&2
exit 1
