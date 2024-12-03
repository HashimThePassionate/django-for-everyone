# 📘 **Django Development Server with Custom Settings** 

This guide provides a comprehensive walkthrough of running a Django development server with a custom IP address, port, and settings module. Follow these steps to ensure professional and efficient usage of the `python manage.py runserver` command.

---

## 📋 **Table of Contents**

1. 🌟 [Overview](#-overview)  
2. 🛠️ [Command Breakdown](#-command-breakdown)  
3. 🚀 [Step-by-Step Usage](#-step-by-step-usage)  
4. 🔒 [Best Practices](#-best-practices)  
5. 🛑 [Troubleshooting](#-troubleshooting)  
6. 📝 [Additional Notes](#-additional-notes)  

---

## 📌 **Overview**

The command:
```bash
python manage.py runserver 127.0.0.1:8001 --settings=django_project.settings
```

### Purpose
- Start the Django development server with a custom IP, port, and settings file.

### Use Cases
- Testing alternative configurations.
- Running on a non-default port.
- Isolating multiple development environments.

---

## 🛠️ **Command Breakdown**

### 1️⃣ `python manage.py runserver`
Starts Django's lightweight development server, ideal for local development and testing.

### 2️⃣ `127.0.0.1:8001`
- **`127.0.0.1`**: Specifies the localhost (your machine).
- **`8001`**: Defines the custom port. The default is `8000`, but you can use another to avoid conflicts.

### 3️⃣ `--settings=django_project.settings`
- Directs Django to use a specific settings module. This is especially useful for managing configurations for:
  - Development (`dev_settings.py`).
  - Testing (`test_settings.py`).
  - Production (`prod_settings.py`).

---

## 🚀 **Step-by-Step Usage**

### Step 1: Navigate to Your Project Directory
Use the terminal to move to the root directory of your Django project:
```bash
cd /path/to/your/django_project
```

### Step 2: Run the Command
Start the development server with the custom IP, port, and settings:
```bash
python manage.py runserver 127.0.0.1:8001 --settings=django_project.settings
```

### Step 3: Access the Server
Open your browser and go to:
```
http://127.0.0.1:8001
```

---

## 🔒 **Best Practices**

1. **Manage Ports**: 
   - Use non-default ports like `8001`, `8002`, etc., when running multiple local servers to prevent conflicts.

2. **Customize `settings.py`**:
   - Add necessary configurations in your custom settings file:
     - `ALLOWED_HOSTS = ['127.0.0.1']`
     - `DEBUG = True` (for development only).
     - Proper `DATABASES` configurations.

3. **Environment-Specific Settings**:
   - Create dedicated settings files for environments:
     - Example:
       - `dev_settings.py`
       - `prod_settings.py`
   - Use tools like `environs` to manage sensitive information (e.g., database passwords, API keys).

---

## 🛑 **Troubleshooting**

### 1. `ModuleNotFoundError: No module named 'django_project.settings'`
- Ensure the `--settings` path is correct.
- Check if the `settings` file exists and is named correctly.

### 2. `Port already in use`
- The port you’re trying to use is occupied by another process. Use a different port:
  ```bash
  python manage.py runserver 127.0.0.1:8002
  ```

### 3. `ImproperlyConfigured`
- Validate configurations in your custom settings file.
- Ensure `INSTALLED_APPS`, `DATABASES`, and other settings are correctly defined.

---

## 📝 **Additional Notes**

- **Development Server Limitation**:
  - Django’s development server is **not for production**.
  - Use production-ready servers like **Gunicorn** or **uWSGI**, alongside web servers like **Nginx** or **Apache**.

- **Environment Variables**:
  - Store sensitive data (e.g., secret keys, database credentials) securely.
  - Recommended tools:
    - [`environs`](https://pypi.org/project/environs/)
    - [`python-decouple`](https://pypi.org/project/python-decouple/)

