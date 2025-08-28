# Logic-LM MCP Setup Guide

This guide helps you set up the Logic-LM MCP server for optimal user experience, including automatic formatting of logical reasoning outputs.

## Quick Setup

### 1. Install and Start Server

```bash
# Install dependencies
pip install -r requirements.txt

# Start the MCP server
python start_server.py
```

### 2. Add to Claude Code MCP Configuration

Add this server to your Claude Code configuration:

```json
{
  "mcpServers": {
    "logic-lm": {
      "command": "python",
      "args": ["path/to/logic-lm-mcp-server/start_server.py"],
      "cwd": "path/to/logic-lm-mcp-server"
    }
  }
}
```

### 3. Test the Setup

```bash
# Test basic functionality
mcp__logic-lm__check_solver_health

# Test reasoning
mcp__logic-lm__translate_to_asp_instructions "All cats are mammals. Fluffy is a cat. Is Fluffy a mammal?"
```

## Enhanced User Experience (Recommended)

For the best experience with logical reasoning outputs, add these instructions to your global `~/.claude/CLAUDE.md` file:

### Option A: Automatic Logic-LM Formatting

Add this section to your `~/.claude/CLAUDE.md`:

```markdown
# Logic-LM Automatic Formatting

When using Logic-LM MCP tools, automatically format responses for readability:

## Logic Reasoning Response Format
When Logic-LM tools return symbolic reasoning results, format the response as:

**Problem**: [Restate the original logical problem clearly]

**Reasoning**: [Explain the logical steps in natural language]

**Conclusion**: [State the final answer clearly]

**ASP Code** (if generated):
```asp
[Show the Answer Set Programming code]
```

**Solver Results**: [Interpret the symbolic solver output]

This applies to:
- `translate_to_asp_instructions` responses
- `verify_asp_program` results  
- Any logical reasoning workflow

Example format:
> **Problem**: All cats are mammals. Fluffy is a cat. Is Fluffy a mammal?
> 
> **Reasoning**: This is a classic syllogistic reasoning pattern. We have a universal rule (all cats are mammals) and a specific instance (Fluffy is a cat). By applying the universal rule to the specific case, we can deduce the conclusion.
> 
> **Conclusion**: Yes, Fluffy is a mammal.
> 
> **ASP Code**:
> ```asp
> cat(fluffy).
> mammal(X) :- cat(X).
> #show mammal/1.
> ```
> 
> **Solver Results**: The Clingo solver found one model with `mammal(fluffy)`, confirming our logical deduction.
```

### Option B: Manual Formatting

If you prefer to control formatting manually, you can format Logic-LM outputs by:

1. Using `get_asp_guidelines()` once to understand ASP translation patterns
2. Using `translate_to_asp_instructions()` for problem-specific guidance  
3. Manually creating ASP code based on the instructions
4. Using `verify_asp_program()` to validate and solve the ASP code
5. Interpreting results in natural language

## Advanced Configuration

### Environment Variables

No special environment variables are required. The server auto-detects:
- Python version compatibility
- Clingo solver availability
- MCP framework version

### Performance Optimization

The server includes several optimizations:
- **Guideline Caching**: ASP translation guidelines are cached after first load
- **Template Library**: Pre-built ASP patterns for common logical structures
- **Lightweight Instructions**: Problem-specific guidance uses minimal context

### Context Management

To minimize token consumption:
- `get_asp_guidelines()` returns full guidelines (~9,174 chars) - call once per session
- `translate_to_asp_instructions()` returns lightweight guidance (~500 chars) - call for each problem
- Guidelines are cached automatically to prevent repeated large context injections

## Workflow Examples

### Basic Logical Reasoning
```bash
# Get problem-specific ASP translation guidance
mcp__logic-lm__translate_to_asp_instructions "If it's raining, then the ground is wet. It's raining. Is the ground wet?"

# Generate ASP code based on instructions (done by LLM/user)
# cat(fluffy).
# mammal(X) :- cat(X).
# #show mammal/1.

# Verify and solve the ASP program
mcp__logic-lm__verify_asp_program "% Facts\nraining.\n\n% Rule\nwet_ground :- raining.\n\n% Query\n#show wet_ground/0."
```

### Complex Multi-Step Reasoning
```bash
# For complex problems, get full guidelines first
mcp__logic-lm__get_asp_guidelines

# Then get problem-specific instructions
mcp__logic-lm__translate_to_asp_instructions "All birds can fly. Penguins are birds. Penguins cannot fly. Resolve this contradiction."

# Work through the logical analysis with full guideline context
# Generate appropriate ASP code with constraints
# Verify the program handles the contradiction properly
```

## Troubleshooting

### Common Issues

1. **Server won't start**: Check Python version (3.8+ required) and dependencies
2. **Clingo not found**: Install with `pip install clingo` or `conda install -c conda-forge clingo`  
3. **MCP connection issues**: Verify the server path in Claude Code configuration
4. **Guidelines not loading**: Check that `docs/asp_logic_guidelines.md` exists in the server directory

### Health Check

Use the health check tool to verify everything is working:

```bash
mcp__logic-lm__check_solver_health
```

This will report:
- Server status and initialization
- Clingo solver availability and version
- Component health and capabilities
- Recommendations for any issues found

### Getting Help

1. Check the main [README.md](README.md) for detailed documentation
2. Run the health check tool for system diagnostics
3. Test with simple logical problems first
4. Verify ASP code syntax if solver reports errors

## Integration Tips

### With Other MCP Servers
Logic-LM works well alongside other MCP servers for comprehensive problem-solving workflows.

### With Symbolic Solver Integration
If you have symbolic solver integration in your CLAUDE.md, Logic-LM complements it by providing:
- ASP-specific reasoning capabilities
- Template-based logical pattern matching
- Clingo solver access for Answer Set Programming

### Custom Templates
You can extend the ASP template library by editing `src/asp_templates.py` and adding new patterns for domain-specific logical structures.

---

## Next Steps

1. ✅ Complete basic setup and test functionality
2. ✅ Add CLAUDE.md formatting instructions for better UX  
3. ✅ Try the example reasoning problems
4. ✅ Explore complex logical scenarios
5. ✅ Integrate with your existing reasoning workflows

For questions or issues, refer to the troubleshooting section or check the health status of your Logic-LM installation.