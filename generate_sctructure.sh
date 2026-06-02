#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting repository structure generation for M.Sc. Thesis..."

# 1. Create main directories and subdirectories
echo "📂 Creating directory tree..."
mkdir -p coursework
mkdir -p research/datasets
mkdir -p research/models
mkdir -p research/simulations
mkdir -p research/analysis_scripts
mkdir -p writing/templates
mkdir -p writing/proposals
mkdir -p writing/papers
mkdir -p presentations

# 2. Create placeholder files to ensure Git tracks empty directories
echo "📝 Creating placeholder files (.gitkeep)..."
touch coursework/.gitkeep
touch research/datasets/.gitkeep
touch research/models/.gitkeep
touch research/simulations/.gitkeep
touch research/analysis_scripts/.gitkeep
touch writing/templates/.gitkeep
touch writing/proposals/.gitkeep
touch writing/papers/.gitkeep
touch presentations/.gitkeep

# 3. Create a robust .gitignore file
echo "⚙️ Generating .gitignore..."
cat << 'EOF' > .gitignore
# === Python & Machine Learning ===
__pycache__/
*.pyc
*.pt
*.h5
.ipynb_checkpoints/
research/requirements.txt

# === MATLAB ===
*.asv
*.slxc
*.mex*
*.mat

# === LaTeX ===
*.aux
*.log
*.toc
*.bbl
*.blg
*.out
*.synctex.gz
*.pdf

# === OS & IDEs ===
.DS_Store
.vscode/
.idea/
EOF

