# Installing Python 🐠

Django 5.0 supports Python 3.10, 3.11, and 3.12. In this guide, we’ll use Python 3.12.

If you’re using **Linux** or **macOS**, Python might already be installed. If you’re on **Windows**, download Python from [python.org](https://www.python.org/downloads/).

### Steps to Verify Python Installation:

1. Open your command-line shell prompt:
   - **macOS**: Press **Command + Spacebar**, type `Terminal`, and open **Terminal.app**.
   - **Windows**: Open the **Start menu**, search for `bash`, and open **Git Bash** or another Bash terminal.

2. Check if Python 3 is installed by typing for linux or mac users:
   ```bash
   python3 --version
   ```
   For windows users
    ```bash
   python --version
   ```
   If installed, you’ll see something like:
   ```
   Python 3.12.3
   ```

   - If this command doesn’t work, try `python --version` or `py --version` (for Windows).
   - If your Python version is below 3.12 or not installed, download the latest version from [python.org](https://www.python.org/downloads/) and follow the installation instructions.

### Python Launcher on Windows:
For Windows users, it’s recommended to use the `py` command. This detects installed Python versions and delegates to the latest version. Learn more about it [here](https://docs.python.org/3/using/windows.html#launcher).


# Creating a Python Virtual Environment 🛠️

Virtual environments allow you to install packages and modules in an isolated location, preventing conflicts between projects. Instead of the `venv` module, we will use `pipenv`, which provides better dependency management and a user-friendly workflow.

### Why Use Pipenv?

- Manages both `Pipfile` and `Pipfile.lock` for dependency tracking.
- Creates isolated environments for projects.
- Automatically installs and tracks Python versions.

### Installing Pipenv:
Install pipenv globally by running:

```bash
pip install pipenv
```

### Creating a Virtual Environment with Pipenv:
#### For Linux/macOS and Windows:

Navigate to your project directory and run:

```bash
pipenv install
```

This command initializes a new `Pipfile` and sets up a virtual environment.

### Activating the Virtual Environment:

Activate the environment by running:

```bash
pipenv shell
```

Once activated, the shell prompt will show the environment name.

### Installing Dependencies:
To install dependencies for your project, use:

```bash
pipenv install <package_name>
```

### Deactivating the Environment:

To exit the pipenv shell, simply type:

```bash
exit
```

For more details, visit the [Pipenv documentation](https://pipenv.pypa.io/en/latest/).


