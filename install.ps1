# Claude GSAP Animation Skill Installer
# Windows PowerShell installation script

$ErrorActionPreference = "Stop"

# Plugin info
$PLUGIN_NAME = "claude-gsap"
$PLUGIN_DIR = "$env:USERPROFILE\.claude\plugins\$PLUGIN_NAME"
$REPO_URL = "https://github.com/thehetpatel/claude-gsap"

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Header
Write-Host ""
Write-ColorOutput "================================================================" "Cyan"
Write-ColorOutput "         Claude GSAP Animation Skill Installer                 " "Cyan"
Write-ColorOutput "    Natural Language -> Production-Ready GSAP Code             " "Cyan"
Write-ColorOutput "================================================================" "Cyan"
Write-Host ""

# Check if running from cloned repo or remote install
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$IsLocalInstall = $false

if ((Test-Path "$ScriptDir\CLAUDE.md") -and (Test-Path "$ScriptDir\skills")) {
    $IsLocalInstall = $true
    $SourceDir = $ScriptDir
    Write-ColorOutput "[OK] Installing from local directory: $SourceDir" "Green"
} else {
    Write-ColorOutput "[->] Installing from remote repository..." "Yellow"

    # Create temp directory
    $TempDir = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

    try {
        # Check for git
        if (Get-Command git -ErrorAction SilentlyContinue) {
            Write-ColorOutput "[->] Cloning repository..." "Yellow"
            git clone --depth 1 "$REPO_URL.git" "$TempDir\$PLUGIN_NAME" 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) {
                throw "Failed to clone repository"
            }
            $SourceDir = "$TempDir\$PLUGIN_NAME"
        } else {
            Write-ColorOutput "[X] Git is required for installation. Please install git first." "Red"
            exit 1
        }
    } catch {
        Write-ColorOutput "[X] Failed to clone repository. Please check your internet connection." "Red"
        if (Test-Path $TempDir) { Remove-Item -Recurse -Force $TempDir }
        exit 1
    }
}

# Create Claude plugins directory if it doesn't exist
Write-ColorOutput "[->] Creating plugin directory..." "Yellow"
$PluginsDir = "$env:USERPROFILE\.claude\plugins"
if (-not (Test-Path $PluginsDir)) {
    New-Item -ItemType Directory -Path $PluginsDir -Force | Out-Null
}

# Remove existing installation if present
if (Test-Path $PLUGIN_DIR) {
    Write-ColorOutput "[->] Removing existing installation..." "Yellow"
    Remove-Item -Recurse -Force $PLUGIN_DIR
}

# Copy plugin files
Write-ColorOutput "[->] Installing plugin files..." "Yellow"
Copy-Item -Recurse -Force $SourceDir $PLUGIN_DIR

# Remove git directory if present
$GitDir = "$PLUGIN_DIR\.git"
if (Test-Path $GitDir) {
    Remove-Item -Recurse -Force $GitDir
}

# Cleanup temp directory
if (-not $IsLocalInstall -and (Test-Path $TempDir)) {
    Remove-Item -Recurse -Force $TempDir
}

# Verify installation
Write-ColorOutput "[->] Verifying installation..." "Yellow"

$RequiredFiles = @(
    ".claude-plugin\plugin.json",
    "CLAUDE.md",
    "skills\gsap\SKILL.md",
    "skills\gsap-scroll\SKILL.md",
    "skills\gsap-timeline\SKILL.md"
)

$MissingFiles = 0
foreach ($file in $RequiredFiles) {
    if (-not (Test-Path "$PLUGIN_DIR\$file")) {
        Write-ColorOutput "[X] Missing: $file" "Red"
        $MissingFiles++
    }
}

if ($MissingFiles -gt 0) {
    Write-ColorOutput "[X] Installation incomplete. $MissingFiles files missing." "Red"
    exit 1
}

# Success message
Write-Host ""
Write-ColorOutput "================================================================" "Green"
Write-ColorOutput "                Installation Complete!                          " "Green"
Write-ColorOutput "================================================================" "Green"
Write-Host ""
Write-Host "Plugin installed to: " -NoNewline
Write-ColorOutput $PLUGIN_DIR "Cyan"
Write-Host ""
Write-ColorOutput "Available Commands:" "Yellow"
Write-Host "  /gsap [description]      Generate animation from description"
Write-Host "  /gsap-scroll [effect]    Create ScrollTrigger animation"
Write-Host "  /gsap-timeline [desc]    Build animation sequence"
Write-Host "  /gsap-text [effect]      Create text animation"
Write-Host "  /gsap-svg [effect]       Generate SVG animation"
Write-Host "  /gsap-3d [effect]        Create 3D animation"
Write-Host "  /gsap-effects [list]     Browse effect presets"
Write-Host "  /gsap-optimize           Analyze and optimize code"
Write-Host "  /gsap-convert [fw]       Convert to React/Vue/Next.js"
Write-Host ""
Write-ColorOutput "Quick Start:" "Yellow"
Write-Host "  Try: " -NoNewline
Write-ColorOutput "/gsap fade in hero section from below" "Cyan"
Write-Host ""
Write-ColorOutput "Happy animating!" "Green"
