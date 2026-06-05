#!/bin/bash
# Python Project Generator
# Usage: new-python-project <project-name> [--web] [--data] [--cli]

set -e

PROJECT_NAME=$1
PROJECT_TYPE=$2

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: new-python-project <project-name> [--web|--data|--cli]"
    echo ""
    echo "Options:"
    echo "  --web   Web application (Flask/FastAPI)"
    echo "  --data  Data science project"
    echo "  --cli   CLI application"
    exit 1
fi

PROJECT_DIR=~/projects/$PROJECT_NAME

# Check if project exists
if [ -d "$PROJECT_DIR" ]; then
    echo "Error: Project '$PROJECT_NAME' already exists"
    exit 1
fi

echo "Creating Python project: $PROJECT_NAME"
echo "Location: $PROJECT_DIR"
echo ""

# Create directory structure
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Create virtual environment
echo "=== Creating virtual environment with uv ==="
uv venv

# Determine project type and dependencies
case "$PROJECT_TYPE" in
    --web)
        PROJECT_FLAVOR="Web Application"
        REQUIREMENTS="flask>=3.0.0
fastapi>=0.104.0
uvicorn>=0.24.0
python-dotenv>=1.0.0
requests>=2.31.0
pydantic>=2.5.0"
        ;;
    --data)
        PROJECT_FLAVOR="Data Science"
        REQUIREMENTS="pandas>=2.0.0
numpy>=1.24.0
matplotlib>=3.7.0
seaborn>=0.12.0
jupyter>=1.0.0
scikit-learn>=1.3.0
python-dotenv>=1.0.0"
        ;;
    --cli)
        PROJECT_FLAVOR="CLI Application"
        REQUIREMENTS="click>=8.1.0
rich>=13.7.0
typer>=0.9.0
python-dotenv>=1.0.0
requests>=2.31.0"
        ;;
    *)
        PROJECT_FLAVOR="General"
        REQUIREMENTS="requests>=2.31.0
python-dotenv>=1.0.0"
        ;;
esac

# Create requirements.txt
cat > requirements.txt << EOF
# $PROJECT_FLAVOR Project Dependencies
$REQUIREMENTS

# Development
pytest>=7.4.0
pytest-cov>=4.1.0
black>=23.12.0
ruff>=0.1.0
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Virtual environment
.venv/
venv/
env/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
dist/
*.egg-info/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Environment
.env
.env.local
*.env

# Testing
.coverage
htmlcov/
.pytest_cache/

# OS
.DS_Store
Thumbs.db

# Jupyter
.ipynb_checkpoints/
*.ipynb
EOF

# Create .env template
cat > .env.example << 'EOF'
# Environment variables template
# Copy to .env and fill in your values
DEBUG=True
EOF

# Create README.md
cat > README.md << EOF
# $PROJECT_NAME

$PROJECT_FLAVOR project.

## Setup

1. Activate virtual environment:
   \`\`\`bash
   source .venv/bin/activate
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   uv pip install -r requirements.txt
   \`\`\`

3. Copy environment file:
   \`\`\`bash
   cp .env.example .env
   # Edit .env with your configuration
   \`\`\`

4. Run the application:
   \`\`\`bash
   python main.py
   \`\`\`

## Development

Run tests:
\`\`\`bash
pytest
\`\`\`

Format code:
\`\`\`bash
black .
ruff check .
\`\`\`

## Project Structure

\`\`\`
$PROJECT_NAME/
├── main.py           # Entry point
├── requirements.txt  # Dependencies
├── .env.example     # Environment template
├── .gitignore
├── README.md
└── tests/           # Test files
\`\`\`
EOF

# Create main.py based on type
case "$PROJECT_TYPE" in
    --web)
        cat > main.py << 'EOF'
#!/usr/bin/env python3
"""
Web application entry point
"""
from flask import Flask
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

@app.route('/')
def index():
    return {'message': 'Hello from Flask!', 'status': 'running'}

@app.route('/health')
def health():
    return {'status': 'healthy'}

if __name__ == '__main__':
    debug = os.getenv('DEBUG', 'False').lower() == 'true'
    app.run(debug=debug, host='0.0.0.0', port=5000)
EOF
        ;;
    --data)
        cat > main.py << 'EOF'
#!/usr/bin/env python3
"""
Data science project
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from dotenv import load_dotenv

load_dotenv()

def main():
    print("Data Science Project initialized")

    # Example: Create sample data
    data = pd.DataFrame({
        'x': np.random.randn(100),
        'y': np.random.randn(100)
    })

    print(f"Generated {len(data)} data points")
    print(data.describe())

    # Example: Simple plot
    # plt.scatter(data['x'], data['y'])
    # plt.savefig('output.png')

if __name__ == '__main__':
    main()
EOF
        ;;
    --cli)
        cat > main.py << 'EOF'
#!/usr/bin/env python3
"""
CLI application
"""
import click
from rich.console import Console
from dotenv import load_dotenv

load_dotenv()
console = Console()

@click.group()
def cli():
    """CLI Application"""
    pass

@cli.command()
@click.argument('name')
def greet(name):
    """Greet someone"""
    console.print(f"[bold green]Hello, {name}![/bold green]")

@cli.command()
def status():
    """Show application status"""
    console.print("[bold blue]Application is running[/bold blue]")

if __name__ == '__main__':
    cli()
EOF
        ;;
    *)
        cat > main.py << 'EOF'
#!/usr/bin/env python3
"""
Main application entry point
"""
from dotenv import load_dotenv
import os

load_dotenv()

def main():
    print("Python project initialized!")
    debug = os.getenv('DEBUG', 'False')
    print(f"Debug mode: {debug}")

if __name__ == '__main__':
    main()
EOF
        ;;
esac

chmod +x main.py

# Create tests directory
mkdir -p tests
cat > tests/__init__.py << 'EOF'
EOF

cat > tests/test_main.py << 'EOF'
"""
Test suite
"""
def test_example():
    assert True, "Example test"
EOF

# Create VS Code settings
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.terminal.activateEnvironment": true
}
EOF

# Initialize git
git init
git add .
git commit -m "Initial commit: $PROJECT_FLAVOR project setup"

echo ""
echo "=== ✓ Project created successfully! ==="
echo ""
echo "Next steps:"
echo "  cd $PROJECT_DIR"
echo "  source .venv/bin/activate"
echo "  uv pip install -r requirements.txt"
echo "  python main.py"
echo ""
echo "Project type: $PROJECT_FLAVOR"
echo "Git initialized with initial commit"
