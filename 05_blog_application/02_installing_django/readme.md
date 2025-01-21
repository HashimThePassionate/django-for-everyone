# **Installing Django** 🌐

If you’ve already installed Django 5.0, you can skip this section and proceed to the **Creating Your First Project** section.

Django is a Python module, which means it can be installed in any Python environment. If you haven’t installed Django yet, follow this quick guide to set it up on your machine.


## Installing Django with Pipenv 📦

Instead of using `pip`, we recommend using `pipenv` for dependency management and virtual environments. Pipenv makes it easier to manage dependencies and ensure consistency across environments.

### Installation Steps:
1. Navigate to your project directory and install Django with Pipenv:
   ```bash
   pipenv install Django~=5.0.4
   ```
   This command installs the latest Django 5.0 version and automatically manages it within a Pipenv virtual environment.

2. Activate the Pipenv shell:
   ```bash
   pipenv shell
   ```

3. Verify the installation by running:
   ```bash
   python -m django --version
   ```
   - If the output starts with `5.0`, Django is successfully installed.
   - If you see the error `No module named Django`, it means Django is not installed. Review the installation options in the [official Django documentation](https://docs.djangoproject.com/en/5.0/intro/install/).

