#!/bin/bash
# setup-venv.sh

VENV_DIR="lsp-bridge-env"
REQUIREMENTS="requirements.txt"

if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment already exists: $VENV_DIR"
    read -p "Delete and recreate? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$VENV_DIR"
    else
        exit 0
    fi
fi

echo "Creating virtual environment: $VENV_DIR"
python3 -m venv "$VENV_DIR"

echo "Installing dependencies..."
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install -r "$REQUIREMENTS"

echo "Virtual environment created successfully!"
echo "Activate with: source $VENV_DIR/bin/activate"
