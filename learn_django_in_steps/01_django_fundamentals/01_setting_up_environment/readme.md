# Setting Up a Development Environment

This guide provides step-by-step instructions for setting up a development environment. It includes instructions for installing Python on Windows, macOS, and Debian, checking the Python version, installing Visual Studio Code (VS Code), and setting up pipenv for virtualization.

## Table of Contents
- [Setting Up a Development Environment](#setting-up-a-development-environment)
  - [Table of Contents](#table-of-contents)
  - [Installing Python](#installing-python)
    - [Windows](#windows)
    - [macOS](#macos)
    - [Debian](#debian)
  - [Checking Python Version](#checking-python-version)
    - [Windows](#windows-1)
    - [macOS](#macos-1)
    - [Linux](#linux)
  - [Installing VS Code](#installing-vs-code)
    - [Windows](#windows-2)
    - [macOS](#macos-2)
    - [Linux](#linux-1)
  - [Installing pipenv](#installing-pipenv)

## Installing Python

### Windows
1. **Download Python Installer:**
    - Go to the [Python downloads page](https://www.python.org/downloads/).
    - Click on the "Download Python" button.

2. **Run the Installer:**
    - Open the downloaded file.
    - Check the box that says "Add Python to PATH".
    - Click on "Install Now".

3. **Verify the Installation:**
    - Open Command Prompt.
    - Type `python --version` and press Enter.

### macOS
1. **Download Python Installer:**
    - Go to the [Python downloads page](https://www.python.org/downloads/).
    - Click on the "Download Python" button.

2. **Run the Installer:**
    - Open the downloaded file.
    - Follow the prompts to complete the installation.

3. **Verify the Installation:**
    - Open Terminal.
    - Type `python3 --version` and press Enter.

### Debian
1. **Update the Package List:**
    ```bash
    sudo apt update
    ```

2. **Install Python:**
    ```bash
    sudo apt install python3
    ```

3. **Verify the Installation:**
    ```bash
    python3 --version
    ```

## Checking Python Version

### Windows
1. Open Command Prompt.
2. Type `python --version` and press Enter.

### macOS
1. Open Terminal.
2. Type `python3 --version` and press Enter.

### Linux
1. Open Terminal.
2. Type `python3 --version` and press Enter.

## Installing VS Code

### Windows
1. **Download the Installer:**
    - Go to the [VS Code downloads page](https://code.visualstudio.com/Download).
    - Click on the "Windows" button.

2. **Run the Installer:**
    - Open the downloaded file.
    - Follow the installation prompts.

### macOS
1. **Download the Installer:**
    - Go to the [VS Code downloads page](https://code.visualstudio.com/Download).
    - Click on the "macOS" button.

2. **Install VS Code:**
    - Open the downloaded `.dmg` file.
    - Drag the Visual Studio Code icon to the Applications folder.

### Linux
1. **Download the Installer:**
    - Go to the [VS Code downloads page](https://code.visualstudio.com/Download).
    - Click on the "Linux" button.

2. **Install VS Code:**
    - For Debian-based systems, download the `.deb` package and install it using:
      ```bash
      sudo apt install ./<file>.deb
      ```
    - Alternatively, use the Snap Store:
      ```bash
      sudo snap install code --classic
      ```

## Installing pipenv

1. **Ensure pip is Installed:**
    ```bash
    python3 -m ensurepip --upgrade
    ```

2. **Install pipenv:**
    ```bash
    pip install --user pipenv
    ```

3. **Verify the Installation:**
    ```bash
    pipenv --version
    ```