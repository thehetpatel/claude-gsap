#!/bin/bash

# Claude GSAP Animation Skill Installer
# Unix/macOS installation script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Plugin info
PLUGIN_NAME="claude-gsap"
PLUGIN_DIR="${HOME}/.claude/plugins/${PLUGIN_NAME}"
REPO_URL="https://github.com/thehetpatel/claude-gsap"

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║           Claude GSAP Animation Skill Installer            ║"
echo "║      Natural Language → Production-Ready GSAP Code         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running from cloned repo or remote install
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IS_LOCAL_INSTALL=false

if [ -f "${SCRIPT_DIR}/CLAUDE.md" ] && [ -d "${SCRIPT_DIR}/skills" ]; then
    IS_LOCAL_INSTALL=true
    SOURCE_DIR="${SCRIPT_DIR}"
    echo -e "${GREEN}✓${NC} Installing from local directory: ${SOURCE_DIR}"
else
    echo -e "${YELLOW}→${NC} Installing from remote repository..."

    # Create temp directory
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf ${TEMP_DIR}" EXIT

    # Clone repository
    if command -v git &> /dev/null; then
        echo -e "${YELLOW}→${NC} Cloning repository..."
        git clone --depth 1 "${REPO_URL}.git" "${TEMP_DIR}/${PLUGIN_NAME}" 2>/dev/null || {
            echo -e "${RED}✗${NC} Failed to clone repository. Please check your internet connection."
            exit 1
        }
        SOURCE_DIR="${TEMP_DIR}/${PLUGIN_NAME}"
    else
        echo -e "${RED}✗${NC} Git is required for installation. Please install git first."
        exit 1
    fi
fi

# Create Claude plugins directory if it doesn't exist
echo -e "${YELLOW}→${NC} Creating plugin directory..."
mkdir -p "${HOME}/.claude/plugins"

# Remove existing installation if present
if [ -d "${PLUGIN_DIR}" ]; then
    echo -e "${YELLOW}→${NC} Removing existing installation..."
    rm -rf "${PLUGIN_DIR}"
fi

# Copy plugin files
echo -e "${YELLOW}→${NC} Installing plugin files..."
cp -r "${SOURCE_DIR}" "${PLUGIN_DIR}"

# Remove git directory if present
rm -rf "${PLUGIN_DIR}/.git"

# Verify installation
echo -e "${YELLOW}→${NC} Verifying installation..."

REQUIRED_FILES=(
    ".claude-plugin/plugin.json"
    "CLAUDE.md"
    "skills/gsap/SKILL.md"
    "skills/gsap-scroll/SKILL.md"
    "skills/gsap-timeline/SKILL.md"
)

MISSING_FILES=0
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "${PLUGIN_DIR}/${file}" ]; then
        echo -e "${RED}✗${NC} Missing: ${file}"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ ${MISSING_FILES} -gt 0 ]; then
    echo -e "${RED}✗${NC} Installation incomplete. ${MISSING_FILES} files missing."
    exit 1
fi

# Success message
echo -e ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              Installation Complete! ✓                      ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo -e ""
echo -e "Plugin installed to: ${BLUE}${PLUGIN_DIR}${NC}"
echo -e ""
echo -e "${YELLOW}Available Commands:${NC}"
echo -e "  /gsap [description]      Generate animation from description"
echo -e "  /gsap-scroll [effect]    Create ScrollTrigger animation"
echo -e "  /gsap-timeline [desc]    Build animation sequence"
echo -e "  /gsap-text [effect]      Create text animation"
echo -e "  /gsap-svg [effect]       Generate SVG animation"
echo -e "  /gsap-3d [effect]        Create 3D animation"
echo -e "  /gsap-effects [list]     Browse effect presets"
echo -e "  /gsap-optimize           Analyze and optimize code"
echo -e "  /gsap-convert [fw]       Convert to React/Vue/Next.js"
echo -e ""
echo -e "${YELLOW}Quick Start:${NC}"
echo -e "  Try: ${BLUE}/gsap fade in hero section from below${NC}"
echo -e ""
echo -e "${GREEN}Happy animating! 🎬${NC}"
