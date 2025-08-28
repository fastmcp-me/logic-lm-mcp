#!/bin/bash
# Setup script for Logic-LM MCP Server
# This script creates a virtual environment and installs all dependencies

set -e

echo "🧠 Logic-LM MCP Server Setup"
echo "=" * 40

# Check if Python 3.8+ is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    echo "Please install Python 3.8 or later."
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
REQUIRED_VERSION="3.8"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "❌ Python $PYTHON_VERSION found, but Python $REQUIRED_VERSION or later is required."
    exit 1
fi

echo "✅ Python $PYTHON_VERSION found"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment already exists"
fi

# Activate virtual environment and install dependencies
echo "📥 Installing dependencies..."
source venv/bin/activate

# Upgrade pip first
pip install --upgrade pip > /dev/null 2>&1

# Install requirements
pip install -r requirements.txt

echo "✅ Dependencies installed successfully"

# Test the setup
echo "🧪 Testing setup..."
if venv/bin/python test_basic.py > /dev/null 2>&1; then
    echo "✅ Basic functionality test passed"
else
    echo "⚠️  Basic functionality test had issues, but installation completed"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "To use the Logic-LM MCP Server:"
echo "1. Activate the virtual environment:"
echo "   source venv/bin/activate"
echo ""
echo "2. Start the server:"
echo "   python start_server.py"
echo ""
echo "Or use the direct path:"
echo "   venv/bin/python start_server.py"
echo ""
echo "To test the setup:"
echo "   venv/bin/python test_basic.py"