# Python Project Generator

`new-python-project.sh` scaffolds a new Python project with a virtual environment, dependencies, and standard tooling already wired up.

## Installation

Copy the script to your `PATH`:

```bash
cp new-python-project.sh ~/.local/bin/new-python-project
chmod +x ~/.local/bin/new-python-project
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage

=== "General"
    ```bash
    new-python-project my-project
    ```

=== "Web app (Flask/FastAPI)"
    ```bash
    new-python-project my-web-app --web
    ```

=== "Data science"
    ```bash
    new-python-project ml-analysis --data
    ```

=== "CLI"
    ```bash
    new-python-project my-tool --cli
    ```

## What you get

Every generated project includes:

- Virtual environment via `uv`
- `requirements.txt` with relevant dependencies for the project type
- `.gitignore` configured for Python
- `README.md` with setup instructions
- VS Code settings
- Git initialized with an initial commit
- Test structure with `pytest`
