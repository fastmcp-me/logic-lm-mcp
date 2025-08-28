# Publishing Guide for Logic-LM MCP Server

This guide covers how to publish the package to PyPI so users can install it with both pip and uv.

## 📋 Prerequisites

1. **PyPI Account**: Create accounts at:
   - [TestPyPI](https://test.pypi.org/account/register/) (for testing)
   - [PyPI](https://pypi.org/account/register/) (for production)

2. **API Tokens**: Generate API tokens for secure uploads:
   - TestPyPI: https://test.pypi.org/manage/account/token/
   - PyPI: https://pypi.org/manage/account/token/

## 🧪 Step 1: Test on TestPyPI

### Upload to TestPyPI
```bash
# Activate environment
source test_env/bin/activate

# Upload to TestPyPI
twine upload --repository testpypi dist/*
```

When prompted:
- Username: `__token__`
- Password: Your TestPyPI API token (starts with `pypi-`)

### Test Installation from TestPyPI
```bash
# Create fresh test environment
python -m venv test_install
source test_install/bin/activate

# Install from TestPyPI
pip install --index-url https://test.pypi.org/simple/ logic-lm-mcp-server

# Test the installation
logic-lm-mcp --help
```

### Test with uv
```bash
# Test uv installation
uv pip install --index-url https://test.pypi.org/simple/ logic-lm-mcp-server

# Verify functionality
python -c "from logic_lm_mcp import LogicFramework; print('✅ Package works!')"
```

## 🚀 Step 2: Production PyPI Publishing

Once TestPyPI testing is successful:

### Upload to Production PyPI
```bash
# Upload to production PyPI
twine upload dist/*
```

When prompted:
- Username: `__token__`
- Password: Your PyPI API token (starts with `pypi-`)

## ✅ Step 3: Verify Production Installation

Test both installation methods work:

### Test pip installation
```bash
pip install logic-lm-mcp-server
logic-lm-mcp --help
```

### Test uv installation (10-100x faster)
```bash
uv pip install logic-lm-mcp-server
logic-lm-mcp --help
```

### Test with solver dependencies
```bash
pip install logic-lm-mcp-server[solver]
# or
uv pip install logic-lm-mcp-server[solver]
```

## 🔄 Update Process

For future updates:

1. **Update version** in `src/__init__.py`
2. **Rebuild package**: `uv build`
3. **Check distribution**: `twine check dist/*`
4. **Test on TestPyPI** first
5. **Upload to production** after verification

## 📝 Post-Publishing

After successful publishing:

1. **Update README.md** with actual PyPI installation commands
2. **Test Claude Code integration** with the published package
3. **Create GitHub release** with changelog
4. **Update repository URLs** in pyproject.toml if needed

## 🛠️ Package Structure Summary

The package supports both pip and uv because:

- **Single pyproject.toml**: Works with both package managers
- **Standard Python packaging**: Compatible with pip, uv, and other tools
- **Console script entry point**: `logic-lm-mcp` command available after installation
- **Optional dependencies**: Users can install `[solver]` extra for Clingo support

Users can install with either:
```bash
pip install logic-lm-mcp-server        # Traditional method
uv pip install logic-lm-mcp-server     # Modern, faster method
```

Both methods install the same package from PyPI registry!