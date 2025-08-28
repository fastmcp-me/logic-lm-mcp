# Logic-LM MCP Server Installation Guide

This guide provides multiple ways to install and set up the Logic-LM MCP Server.

## Prerequisites

- **Python 3.8+** (Python 3.10+ recommended)
- **pip** (Python package manager)

## Installation Options

### Option 1: Automated Setup (Recommended)

The easiest way to get started:

```bash
# Clone or download the project
git clone <repository-url>
cd logic-lm-mcp-server

# Run the automated setup script
./setup_venv.sh
```

This script will:
- Check Python version compatibility  
- Create a virtual environment
- Install all required dependencies
- Test the basic functionality
- Provide usage instructions

### Option 2: Manual Virtual Environment Setup

If you prefer manual control:

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment (Linux/macOS)
source venv/bin/activate

# Activate virtual environment (Windows)
# venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Test the setup
python test_basic.py
```

### Option 3: System-Wide Installation

⚠️ **Not recommended** - can cause dependency conflicts:

```bash
pip install -r requirements.txt
python test_basic.py
```

### Option 4: Using pipx (Application Installation)

For installing as a standalone application:

```bash
# Install pipx if not available
pip install pipx

# Install the Logic-LM MCP Server
pipx install .

# Or install directly from requirements
pipx install fastmcp pydantic clingo
```

## Verification

After installation, verify everything works:

### Basic Test
```bash
# Using virtual environment
venv/bin/python test_basic.py

# Or if virtual environment is activated
python test_basic.py
```

### Full Test (if all dependencies available)
```bash
venv/bin/python test_setup.py
```

### Expected Output
```
Logic-LM Basic Functionality Test
========================================
Testing Logic-LM Framework...
✓ Framework initialized
✓ Health check: healthy
  Clingo available: True

Testing problem: All cats are mammals. Fluffy is a cat. Is Fluffy a mammal?
✓ Result: True
  Solution: The following are mammals: cat, fluffy
  Confidence: 0.95
  Iterations: 1

Testing ASP Templates...
✓ Loaded 7 templates
✓ Template instantiation works

========================================
Tests: 2/2 passed
🎉 Core Logic-LM functionality works!
```

## Starting the Server

### Using Virtual Environment
```bash
# Activate environment first
source venv/bin/activate
python start_server.py

# Or use direct path
venv/bin/python start_server.py
```

### Expected Startup
```
🧠 Logic-LM MCP Server
========================================
✅ All dependencies satisfied
🚀 Starting Logic-LM MCP Server...

[FastMCP Banner]
Server Status: healthy
Clingo Available: True
Available Templates: 7

Tools available:
- solve_logical_problem: Natural language logical reasoning
- verify_asp_program: Direct ASP program verification
- check_solver_health: System health and diagnostics

Resources available:
- asp-templates://: ASP template library access

Starting MCP server on stdio...
```

## Dependency Details

### Required Dependencies
- **fastmcp>=2.0.0**: FastMCP server framework
- **pydantic>=2.0.0**: Input validation and type safety
- **clingo>=5.8.0**: ASP solver (optional but recommended)
- **typing-extensions>=4.0.0**: Type system extensions

### Optional Dependencies
- **clingo**: If missing, server runs with informative error messages
- Core reasoning functionality works without Clingo

## Troubleshooting

### Common Issues

#### 1. "No module named 'pydantic'"
```bash
# Solution: Install in virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

#### 2. "Clingo not available"
```bash
# Solution: Install Clingo
pip install clingo

# Or if using system packages (Linux)
sudo apt-get install gringo  # Ubuntu/Debian
brew install clingo          # macOS
```

#### 3. "Permission denied" on setup script
```bash
chmod +x setup_venv.sh
./setup_venv.sh
```

#### 4. Python version too old
```bash
# Check version
python3 --version

# Install newer Python if needed
# Ubuntu/Debian: sudo apt-get install python3.10
# macOS: brew install python@3.10
# Windows: Download from python.org
```

#### 5. Virtual environment not activating
```bash
# Linux/macOS
source venv/bin/activate

# Windows Command Prompt
venv\Scripts\activate.bat

# Windows PowerShell
venv\Scripts\Activate.ps1

# Or use direct path
venv/bin/python start_server.py
```

## Environment-Specific Notes

### Linux/Ubuntu
```bash
# Install Python development headers if needed
sudo apt-get install python3-dev python3-venv

# Install build tools for some dependencies
sudo apt-get install build-essential
```

### macOS
```bash
# Install Python via Homebrew (recommended)
brew install python@3.10

# Or use the system Python with additional tools
xcode-select --install
```

### Windows
```powershell
# Use Command Prompt or PowerShell
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

## Packaging for Distribution

### Creating a Distributable Package

1. **Prepare the environment:**
```bash
pip install build twine
```

2. **Build the package:**
```bash
python -m build
```

3. **Test the built package:**
```bash
pip install dist/logic_lm_mcp_server-*.whl
```

### Docker Packaging

Create a `Dockerfile`:
```dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY src/ ./src/
COPY *.py ./

EXPOSE 8080
CMD ["python", "start_server.py"]
```

Build and run:
```bash
docker build -t logic-lm-mcp-server .
docker run -p 8080:8080 logic-lm-mcp-server
```

## Development Setup

For developers who want to modify the server:

```bash
# Clone repository
git clone <repository-url>
cd logic-lm-mcp-server

# Create development environment
python3 -m venv dev-env
source dev-env/bin/activate

# Install in development mode
pip install -e .

# Install development dependencies
pip install pytest black flake8 mypy

# Run tests
python test_basic.py
python test_setup.py
```

## Next Steps

After installation:
1. **Test the server**: Run `python test_basic.py`
2. **Start the server**: Run `python start_server.py`
3. **Connect from Claude**: Configure Claude Code to use the MCP server
4. **Try logical reasoning**: Test with natural language problems

## Support

If you encounter issues:
1. Run `python test_basic.py` to isolate problems
2. Check the [README.md](README.md) for usage examples
3. Review error messages for specific guidance
4. Open an issue with your environment details