# Initial Set Up

This section focuses on configuring your Windows or macOS computer to work on Django projects. Configuring your computer correctly now will save you a lot of pain and heartache later. It is important to be comfortable with the command line and shell commands, understand how to use virtual environments, install the latest version of Python, use a text editor, and work with Git for version control. By the end of this section, you will have created your first Django project from scratch and be able to create and modify new Django projects with just a few keystrokes.

## The Command Line

The command line is a text-only interface that harkens back to the original days of computing. It is an alternative to the mouse or finger-based graphical user interface familiar to most computer users. Regular computer users will never need to use the command line, but for software developers, it is a vital and regularly used tool necessary to execute programs, install software, use Git for version control, and connect to servers in the cloud. With practice, most developers find that the command line is a faster and more powerful way to navigate and control a computer.

Given its minimal user interface—just a blank screen and a blinking cursor—the command line is intimidating to newcomers. There is often no feedback after a command has run, and it is possible to wipe the contents of an entire computer with a single command if you’re not careful: no warning will pop up! As a result, use the command line with caution. Refrain from mindlessly copying and pasting commands you find online; rely only on trusted resources.

### Accessing the Command Line

- **Windows**: The built-in terminal and shell on Windows are both called PowerShell. To access it, locate the taskbar next to the Windows button on the bottom of the screen and type in “PowerShell” to launch the app. It will open a new window with a dark blue background and a blinking cursor after the `>` prompt.

    ```sh
    PS C:\Windows\System32>
    ```

    Navigate to the users directory:

    ```sh
    PS C:\Windows\System32> cd \users
    PS C:\Users>
    ```

- **macOS**: The built-in terminal is called Terminal. Open it via the Spotlight app by pressing the Command and Space bar keys simultaneously and then typing in “terminal.” Alternatively, open a new Finder window, navigate to the Applications directory, scroll down to open the Utilities directory, and double-click the Terminal application.

    ```sh
    Hashims-Macbook-Pro:~ hashim%
    ```

    Navigate to the desktop directory:

    ```sh
    cd desktop
    pwd
    /Users/hashim/desktop
    ```

### Common Shell Commands

There are many available shell commands, but developers generally rely on half a dozen commands for day-to-day use and look up more complicated commands as needed.

- **whoami**: Returns the computer name/username on Windows and the username on macOS.

    ```sh
    # Windows
    whoami
    hashim\dell

    # macOS
    whoami
    hashim
    ```

- **pwd**: Outputs the current location within the file system.

    ```sh
    # Windows
    pwd
    Path
    ----
    C:\Users

    # macOS
    pwd
    /Users/hashim
    ```

### Creating and Navigating Directories

To save your Django code in the desktop directory for convenience, use the `cd` (change directory) command followed by the intended location.

- **Windows**:

    ```sh
    cd hashim
    cd onedrive\desktop
    pwd
    Path
    ----
    C:\Users\hashim\onedrive\desktop
    ```

- **macOS**:

    ```sh
    cd desktop
    pwd
    /Users/hashim/desktop
    ```

To create a new directory, use the `mkdir` command followed by the name. We will create a `code` directory on the desktop and a new directory named `01_initial_setup` within it.

```sh
# Windows
mkdir code
cd code
mkdir 01_initial_setup
cd 01_initial_setup

# macOS
mkdir code
cd code
mkdir 01_initial_setup
cd 01_initial_setup
```

You can check that it has been created by looking on your desktop or running the `pwd` command.

### Clearing the Terminal and Exiting

- **clear**: Clears the terminal of past commands and outputs.

- **deactivate**: Deactivates a virtual environment.

- **exit**: Exits the terminal.

    ```sh
    exit
    ```

## Install Python 3

### On Windows

Microsoft hosts a community release of Python 3 in the Microsoft Store. In the search bar at the bottom of your screen, type in “python” and select the result for Python 3.12 on the Microsoft Store. Click on the blue “Get” button to download it. To confirm that Python is installed correctly, open a new Terminal window with PowerShell and type `python --version`.

```sh
python --version
Python 3.12.3
```

Then, type `python` to open the Python interpreter from the command-line shell.

```sh
python
Python 3.12.3 (v3.12.3:f6650f9ad7, Apr 9 2024, 08:18:47)
[MSC v.1937 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

Exit the Python interpreter by typing either `exit()` or `Ctrl-Z` plus Return.

### On macOS

The official installer on the Python website is the best approach. In a new browser window, go to the Python downloads page and click on the button underneath the text “Download the latest version for Mac OS X.” As of this writing, that is Python 3.12. The package will be in your Downloads directory: double-click on it to launch the Python Installer and follow the prompts. To confirm the download was successful, open a new Terminal window and type `python3 --version`.

```sh
python3 --version
Python 3.12.3
```

Then, type `python3` to open the Python interpreter.

```sh
python3
Python 3.12.3 (v3.12.3:f6650f9ad7, Apr 9 2024, 08:18:47)
[Clang 13.0.0 (clang-1300.0.29.30)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

Exit the Python interpreter by typing either `exit()` or `Ctrl-D` plus Return.

## Python Interactive Mode

From the command line, type either `python` on Windows or `python3` on macOS to bring up the Python Interpreter, also known as Python Interactive mode. The new prompt of `>>>` indicates that you are now inside Python itself and not the command line.

```sh
>>> 1 + 1
2
>>> print("Hello Python!")
Hello Python!
```

Exit Python from the command line by typing either `exit()` and the Enter key or using `Ctrl + z` on Windows or `Ctrl + d` on macOS.

## Install Pipenv

Before setting up your virtual environment, you need to install Pipenv using `pip`. Pipenv simplifies the management of virtual environments and dependencies.

```sh
pip install pipenv
```

## Virtual Environments with Pipenv

Installing the latest versions of Python and Django is the correct approach for any new project. However, in the real world, it is common for existing projects to rely on older versions of each. Virtual environments allow you to create and manage separate environments for each Python project on the same computer. You should use a dedicated virtual environment for each new Python and Django project.

To create a virtual environment using Pipenv, follow these steps:

1. **Navigate to your project directory**:

    ```sh
    # Windows
    cd onedrive\desktop\code\01_initial_setup

    # macOS
    cd ~/desktop/code/01_initial_setup
    ```

2. **Create and activate a virtual environment**:

    ```sh
    pipenv shell
    ```

The shell prompt now has the environment name prefixed, which indicates that the virtual environment is active.

## PyPI (Python Package Index)

PyPI is the central location for all Python projects. We will use `pip`, the most popular package installer, to install Python packages. It already comes included with Python 3, but to ensure we are on the latest version of `pip`, let’s take a moment to update it.

```sh
python -m pip install --upgrade pip
```

## Install Django

Now that we have learned how to install Python properly, use virtual environments, and update `pip` to the latest version, it is time to install Django for the first time.

In the `01_initial_setup` directory, install Django using Pipenv.

```sh
pipenv install django~=5.0.0
```

This command uses the comparison operator `~=` to install the latest version of Django 5.0.x.

## First Django Project

To create a new Django project, use the command `django-admin startproject django_project .`.

```sh
django-admin startproject django_project .
```

If you just run `django-admin startproject django_project` without a period at the end, then by default, Django will create this directory structure:

```
django_project/
├── django_project
│

   ├── __init__.py
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
```

By adding a period to the end of the command, Django will install the project in the current directory, resulting in a simpler structure:

```
├── django_project
│   ├── __init__.py
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── manage.py
```

## The Development Server

Django includes a built-in, lightweight local development web server accessible via the `runserver` command. The development server automatically reloads Python code for each request and serves static files. However, some actions, such as adding files, will not automatically trigger a restart, so if your code is not working as expected, a manual restart is always a good first step. By default, the server runs on port 8000 on the IP address 127.0.0.1, which is known as the “loopback address.”

Start the local development server:

```sh
python manage.py runserver
```

Visit [http://127.0.0.1:8000/](http://127.0.0.1:8000/) in your web browser to ensure the Django welcome page is visible.

Stop the local server with `Control + c`. Then, exit the virtual environment by typing `exit`.

```sh
# Windows or macOS
exit
```

## Text Editors

The command line is where we execute commands for our programs, but a text editor is where code is written. The computer doesn’t care what text editor you use—the result is just code—but a good text editor can provide helpful hints and catch typos for you. Two popular options are PyCharm and Visual Studio Code (VSCode).

### VSCode Configurations

If you’re not already using a text editor, download and install VSCode from the official website. There are three recommended configurations you can add to improve your developer productivity:

1. **Add the official Python extension**:
   - On Windows: Navigate to `File -> Settings -> Extensions`.
   - On macOS: Navigate to `Code -> Settings -> Extensions`.
   - Search for “python” and install the official Microsoft extension.

2. **Add Black, a Python code formatter**:
   - Run the command to install Black:

    ```sh
    pip install black
    ```

   - In VSCode, open the settings:
     - On Windows: Navigate to `File -> Preferences -> Settings`.
     - On macOS: Navigate to `Code -> Preferences -> Settings`.
   - Search for “default formatter” and select “Black Formatter.”
   - Search for “format on save” and enable “Editor: Format on Save.”

   - Create and save a new file called `hello.py` within the `01_initial_setup` directory:

    ```python
    print('Hello, World!')
    ```

   - On save, it should update to:

    ```python
    print("Hello, World!")
    ```

3. **Open VSCode directly from your terminal**:
   - Press `Command + Shift + P` simultaneously within VSCode to open the command palette.
   - Type `shell: Install code command in PATH` and hit enter.
   - Navigate to the `01_initial_setup` directory and type `code .` to open it in VSCode.

    ```sh
    code .
    ```

## Install Git

Git is a version control system indispensable to modern software development. With Git, you can collaborate with other developers, track all your work via commits, and revert to any previous code version.

### On Windows

Download Git from the [official website](https://git-scm.com/) and follow the installation prompts. Make sure to select “Use Visual Studio Code as Git’s default editor” and “Override the default branch name for new repositories” to use “main.”

Confirm Git installation:

```sh
git --version
git version 2.45.2.windows.1
```

### On macOS

Check if Git is installed:

```sh
git --version
git version 2.45.2
```

If not, install Git via Xcode by typing `xcode-select --install`.

Configure Git:

```sh
git config --global user.name "Your Name"
git config --global user.email "yourname@email.com"
git config --global init.defaultBranch main
```

## Conclusion

Configuring a software development environment from scratch is challenging. Even experienced programmers have difficulty with the task, but it is a one-time pain that is more than worth it. We can now start new Django projects quickly and have learned about the command line, Python interactive mode, how to install the latest version of Python and Django, configured our text editor, and installed Git. Everything is ready for our first proper Django website in the next section.