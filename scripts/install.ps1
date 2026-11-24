# Instala ClaudeAgents en Windows (PowerShell). Usa "junctions", que no requieren
# permisos de administrador.
$ErrorActionPreference = "Stop"
$Repo = (Resolve-Path "$PSScriptRoot\..").Path
$ClaudeHome = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { "$HOME\.claude" }
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
New-Item -ItemType Directory -Force -Path $ClaudeHome | Out-Null

foreach ($name in "agents", "skills", "agent-memory") {
  $src = Join-Path $Repo ".claude\$name"
  $dst = Join-Path $ClaudeHome $name
  New-Item -ItemType Directory -Force -Path $src | Out-Null
  if (Test-Path $dst) {
    $item = Get-Item $dst -Force
    if ($item.LinkType) { $item.Delete() }
    else {
      Copy-Item "$dst\*" $src -Recurse -ErrorAction SilentlyContinue
      Rename-Item $dst "$dst.backup-$Stamp"
      Write-Host "  · $dst existía: fusionado en el repo, copia en $dst.backup-$Stamp"
    }
  }
  New-Item -ItemType Junction -Path $dst -Target $src | Out-Null
  Write-Host "  ✓ $dst -> $src"
}

$GlobalMd = Join-Path $ClaudeHome "CLAUDE.md"
$Start = "<!-- claudeagents:start -->"; $End = "<!-- claudeagents:end -->"
$Block = @"
$Start
## ClaudeAgents
Mis agentes y skills viven en el repositorio ``$Repo``
(enlazado en ~/.claude/agents, ~/.claude/skills y ~/.claude/agent-memory).
- Al crear un agente, usa la skill ``crear-agente``.
- Cuando aprendas algo reutilizable, usa la skill ``guardar-skill``.
- Después de cambiar agentes, skills o memoria, haz commit y push en ``$Repo``
  (en Git Bash: ``scripts/sync.sh "mensaje"``).
$End
"@
$Text = if (Test-Path $GlobalMd) { Get-Content $GlobalMd -Raw } else { "" }
$Pattern = [regex]::Escape($Start) + "(?s).*?" + [regex]::Escape($End)
if ($Text -match $Pattern) { $Text = [regex]::Replace($Text, $Pattern, $Block) }
else { $Text = ($Text.TrimEnd() + "`n`n" + $Block + "`n").TrimStart() }
Set-Content -Path $GlobalMd -Value $Text -Encoding UTF8
Write-Host "  ✓ Instrucciones añadidas a $GlobalMd"
Write-Host "Listo. Reinicia Claude Code para que cargue los agentes y skills."
