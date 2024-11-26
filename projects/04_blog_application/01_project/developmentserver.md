# 📘 Running the Django Development Server with Custom Settings

This guide walks you through using the `python manage.py runserver` command to run a Django development server with a custom IP address, port, and settings module. Let's explore how to use this command effectively and professionally.


## 📋 **Table of Contents**

1. [Overview](#-overview)
2. [Command Breakdown](#-command-breakdown)
3. [Step-by-Step Usage](#-step-by-step-usage)
4. [Best Practices](#-best-practices)
5. [Troubleshooting](#-troubleshooting)
6. [Additional Notes](#-additional-notes)


## 📌 **Overview**

The command:
```bash
python manage.py runserver 127.0.0.1:8001 --settings=django_project.settings
```

- **Purpose**: Start the Django development server with a custom IP address, port, and settings file.
- **Key Scenarios**:
  - Testing alternative configurations.
  - Running on a non-default port.
  - Ensuring isolation for multiple development environments.


## 🛠 **Command Breakdown**

### 1️⃣ `python manage.py runserver`
- Starts the Django development server, a lightweight server intended for local development and testing.

### 2️⃣ `127.0.0.1:8001`
- **`127.0.0.1`**: Refers to the localhost (your local machine).
- **`8001`**: The custom port number where the server will run. 
  - Default port is `8000`, but you can specify another port to avoid conflicts or for a specific setup.

### 3️⃣ `--settings=django_project.settings`
- **Purpose**: Specifies a custom settings module to use.
  - This allows you to switch between configurations for development, testing, or production environments.


## 📂 **Step-by-Step Usage**

### 1. Navigate to Your Project Directory
Ensure you are in the root directory of your Django project:
```bash
cd /path/to/your/django_project
```

### 2. Run the Command
Start the server with a specific IP address, port, and settings module:
```bash
python manage.py runserver 127.0.0.1:8001 --settings=django_project.settings
```

### 3. Access the Server
Open your browser and visit:
```
http://127.0.0.1:8001
```


## 🔒 **Best Practices**

- **Port Management**: Use non-default ports when running multiple servers locally to avoid conflicts.
- **Settings Module**: Ensure the specified settings file is correctly configured with necessary parameters like:
  - `ALLOWED_HOSTS`
  - `DATABASES`
  - `DEBUG`
- **Environment-Specific Settings**: Organize your settings files (e.g., `dev_settings.py`, `prod_settings.py`) and maintain consistency.


## ⚠️ **Troubleshooting**

1. **Error: `ModuleNotFoundError: No module named 'django_project.settings'`**
   - Verify the settings module path and ensure the file exists.

2. **Error: `Port already in use`**
   - Change the port number:
     ```bash
     python manage.py runserver 127.0.0.1:8002
     ```

3. **Error: `ImproperlyConfigured`**
   - Double-check the configurations in your custom settings file.


## 📝 **Additional Notes**

- The development server is **not suitable for production use**. Always use a production-ready server like **Gunicorn** or **uWSGI** with a proper web server (e.g., Nginx, Apache).
- Specify environment variables for critical settings (e.g., secret keys, database credentials) using tools like `python-decouple` or `environs`.
