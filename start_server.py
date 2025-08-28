#!/usr/bin/env python3
"""
Logic-LM MCP Server Startup Script

This script handles graceful startup with proper dependency checking
and informative error messages.
"""

import sys
import os
from pathlib import Path

def check_dependencies():
    """Check if required dependencies are available"""
    missing_deps = []
    
    try:
        import fastmcp
    except ImportError:
        missing_deps.append("fastmcp>=2.0.0")
    
    try:
        import pydantic
    except ImportError:
        missing_deps.append("pydantic>=2.0.0")
    
    try:
        import clingo
        clingo_available = True
    except ImportError:
        clingo_available = False
        # Clingo is optional but recommended
    
    return missing_deps, clingo_available

def main():
    """Main startup function"""
    print("🧠 Logic-LM MCP Server")
    print("=" * 40)
    
    # Check dependencies
    missing_deps, clingo_available = check_dependencies()
    
    if missing_deps:
        print("❌ Missing required dependencies:")
        for dep in missing_deps:
            print(f"  - {dep}")
        print("\nTo install dependencies:")
        print("pip install -r requirements.txt")
        print("\nAlternatively, install individually:")
        for dep in missing_deps:
            print(f"pip install {dep.split('>=')[0]}")
        sys.exit(1)
    
    if not clingo_available:
        print("⚠️  Warning: Clingo solver not available")
        print("   The server will run with limited functionality.")
        print("   Install with: pip install clingo")
        print()
    
    # Add src directory to path
    src_dir = Path(__file__).parent / "src"
    sys.path.insert(0, str(src_dir))
    
    try:
        # Import and run the server
        from main import main as run_server
        print("✅ All dependencies satisfied")
        print("🚀 Starting Logic-LM MCP Server...")
        print()
        
        run_server()
        
    except KeyboardInterrupt:
        print("\n👋 Server stopped by user")
        sys.exit(0)
    except Exception as e:
        print(f"\n❌ Server startup failed: {e}")
        print("\nFor troubleshooting:")
        print("1. Check that all dependencies are installed")
        print("2. Run: python test_basic.py")
        print("3. Check the error message above")
        sys.exit(1)

if __name__ == "__main__":
    main()