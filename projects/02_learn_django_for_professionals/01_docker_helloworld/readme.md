# Docker Hello, World!

🎉 **Welcome to Docker Hello, World!** 🎉

Configuring a local development environment can be challenging due to the numerous variables like different computers, operating systems, versions of Django, and virtual environment options. This challenge becomes even more significant when working in a team where everyone needs the same setup.

## 🌍 **Why Docker?**

In recent years, **Docker** has become the go-to solution for developers working on production-level projects. Docker allows you to faithfully reproduce a production environment locally, ensuring that everything from the Python version to Django installation and additional services like a production-level database are consistent across all platforms—whether you're on a Mac, Windows, or Linux computer.

Docker also simplifies collaboration in teams. Instead of sharing outdated README files for setting up a development environment, you can share two files—a `Dockerfile` and a `docker-compose.yml` file—and be confident that everyone’s local environment is the same.

While Docker is not perfect—it’s still relatively new, complex, and under active development—it offers a consistent and shareable development environment that can be run locally on any computer or deployed to any server. This makes it a solid choice for professional projects.

In this section, we'll learn about Docker and "Dockerize" our first Django project.

📌 [Docker](https://www.docker.com/)

## 🛠️ **What is Docker?**

Docker is a tool that uses Linux containers to isolate entire operating systems, a concept rooted in virtualization. Virtualization allows multiple users to run isolated environments on the same physical machine. However, virtual machines (VMs) can be resource-heavy and slow, requiring significant disk space, CPU, and memory resources.

Docker takes a different approach by virtualizing from the Linux layer up, offering a more lightweight and faster alternative to VMs. For most web applications, Docker containers are more than sufficient, providing the necessary isolation while using fewer resources.

An analogy: Virtual Machines are like standalone homes with their infrastructure, while Docker containers are like apartments sharing common infrastructure but tailored to specific needs.

📌 [Learn more about Virtualization](https://en.wikipedia.org/wiki/Virtualization)

📌 [Learn more about Virtual Machines](https://en.wikipedia.org/wiki/Virtual_machine)

### 🌐 **Learn Docker**

If you're interested in learning more about Docker, you can follow my Docker repository on GitHub, which contains various resources and examples to help you master Docker:

📂 [Hashim's Docker Repository](https://github.com/HashimThePassionate/Docker)

## 🔍 **Virtual Environments vs Containers**

### **Virtual Environments**

Virtual environments in Python are used to isolate Python packages, allowing you to manage dependencies for multiple projects on the same machine. For example, Project A might use Python 3.10 and Django 4.0, while Project B uses Python 3.5 and Django 1.11. By creating separate virtual environments, you can ensure that each project has the correct dependencies.

The simplest way to create a virtual environment is with the `venv` module, included in Python 3. However, virtual environments only isolate Python packages, not other software like databases, and they rely on a global Python installation.

### **Containers**

Linux containers, like those used in Docker, go a step further by isolating the entire operating system, including Python and other dependencies. This allows for a more complete and consistent environment, independent of the host system.

Docker simplifies the process of setting up and managing containers, making it an essential tool for professional development.

📺 [Dive into Docker](https://diveintodocker.com/ref-dfp)

## 🚀 **Install Docker**

### **Installing Docker on macOS**

To get started with Docker on macOS, sign up for a free account on Docker Hub and install the Docker Desktop app:

- [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)

### **Installing Docker on Windows**

For Windows users, the process is similar:

- [Docker for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

#### **Problems Installing Docker Desktop on Windows**

While installing Docker Desktop on Windows, you might encounter several issues:

1. **Windows Subsystem for Linux (WSL) 2 Requirement**: Docker Desktop on Windows requires WSL 2, which might not be enabled on your machine. To resolve this, ensure that WSL 2 is installed and enabled. You can follow these steps:
   - Open PowerShell as Administrator.
   - Run `wsl --install` to enable WSL and install Ubuntu by default.
   - To upgrade to WSL 2, run `wsl --set-version Ubuntu-20.04 2`.

2. **Hyper-V and Virtualization Issues**: Docker requires Hyper-V and virtualization to be enabled. If they are not, you may need to enable them in your BIOS settings:
   - Restart your computer and enter the BIOS/UEFI settings.
   - Look for options related to virtualization (e.g., Intel VT-x, AMD-V) and enable them.
   - Save the settings and reboot your computer.

3. **Compatibility Issues**: Older versions of Windows, such as Windows 7 or 8, do not support Docker Desktop. In such cases, consider upgrading to Windows 10 or 11, or use Docker Toolbox as an alternative.

If you encounter additional issues, the [Docker Docs](https://docs.docker.com/desktop/windows/install/) provide detailed troubleshooting steps.

Once Docker is installed, verify the installation by running the following command in your command line:

```shell
docker --version
Docker version 20.10.14, build a224086
```

## 🌟 **Docker Hello, World!**

To confirm that Docker is working correctly, run the "Hello, World" Docker image:

```shell
docker run hello-world
```

This command will pull the "Hello, World" image from Docker Hub and run it in a container, producing the following output:

```shell
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

To inspect Docker, use the `docker info` command:

```shell
docker info
```

This command will provide detailed information about your Docker setup, including the number of containers and images.

## 🌱 **Creating a Django Project**

Now, let's create a Django "Hello, World" project, first locally, and then move it into Docker.

### **Step 1: Set Up Your Project Locally**

1. **Navigate to the Desktop:**

    ```shell
    # Windows
    cd onedrive\desktop

    # macOS
    cd desktop
    ```

2. **Create a Directory for Your Project:**

    ```shell
    mkdir docker-helloworld
    cd docker-helloworld
    ```

3. **Creating, Activating  a  Virtual Environment and install django:**

    ```shell
    pipenv install django==5.0.7
    ```

### **Step 2: Start the Django Project**

1. **Create the Django Project:**

    ```shell
    django-admin startproject django_project .
    ```

2. **Apply Migrations and Start the Server:**

    ```shell
    python manage.py migrate
    python manage.py runserver
    ```

3. **Visit the Django Welcome Page:**

    Open your browser and navigate to `http://127.0.0.1:8000/` to see the Django Welcome page.

### **Step 3: Create a Simple Homepage**

1. **Stop the Server** and create a new app:

    ```shell
    python manage.py startapp pages
    ```

2. **Add the New App to `settings.py`:**

    ```python
    # django_project/settings.py
    INSTALLED_APPS = [
        "django.contrib.admin",
        "django.contrib.auth",
        "django.contrib.contenttypes",
        "django.contrib.sessions",
        "django.contrib.messages",
        "django.contrib.staticfiles",
        # Local
        "pages",  # new
    ]
    ```

3. **Set Up URL Routing:**

    ```python
    # django_project/urls.py
    from django.contrib import admin
    from django.urls import path, include  # new

    urlpatterns = [
        path("admin/", admin.site.urls),
        path("", include("pages.urls")),  # new
    ]
    ```

4. **Create a Simple View:**

    ```python
    # pages/views.py
    from django.http import HttpResponse

    def home_page_view(request):
        return HttpResponse("Hello, World!")
    ```

5. **Create a URL Configuration for the App:**

    ```python
    # pages/urls.py
    from django.urls import path
    from .views import home_page_view

    urlpatterns = [
        path("", home_page_view, name="home"),
    ]
    ```

6. **Run the Server** and visit the homepage to see "Hello, World!":

    ```shell
    python manage.py runserver
    ```
## 🐳 **Understanding Dockerfile and Docker Compose**

Before we dive into Dockerizing the Django project, it's important to understand two critical components: **Dockerfile** and **Docker Compose**.

### **What is a Dockerfile?**

A **Dockerfile** is a script that contains a series of instructions on how to build a Docker image. It starts with a base image (e.g., a version of Python), then layers on additional software, configurations, and the application code. When you build a Docker image using a Dockerfile, Docker reads the instructions from top to bottom and creates an image that is a snapshot of your application environment.

In simpler terms, a Dockerfile is like a recipe that tells Docker how to create an image for your application.

### **What is Docker Compose?**

**Docker Compose** is a tool that allows you to define and manage multi-container Docker applications. With Docker Compose, you can use a YAML file (`docker-compose.yml`) to define the services, networks, and volumes that make up your application. This way, you can manage your entire application stack with a single command.

In simpler terms, Docker Compose is like an orchestration tool that helps you manage and run multiple Docker containers at once.

## 🌱 **Dockerizing Your Django Project**

Now let's move your Django project into Docker to make it more portable and consistent across different environments.

### **Step 5: Create a Dockerfile**

The `Dockerfile` contains a set of instructions to build a Docker image. Here's an example `Dockerfile` for your Django project:

```Dockerfile
# Pull base image
FROM python:3.12-slim

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .
```

**Explanation of the Dockerfile:**

1. **FROM python:3.12-slim**
   - **Base Image**: This sets the foundation for your Docker container.
   - **Slim Version**: Uses the minimal `slim` variant of Python 3.12, which is lightweight and optimized, reducing the overall image size for efficiency.

2. **ENV PIP_DISABLE_PIP_VERSION_CHECK 1**
   - **Disabling Pip Version Check**: This environment variable turns off pip's automatic version check.
   - **Why?**: It speeds up the build process by preventing pip from checking for newer versions, avoiding unnecessary network calls.

3. **ENV PYTHONDONTWRITEBYTECODE 1**
   - **Skip .pyc Files**: This setting tells Python not to generate `.pyc` files.
   - **Why?**: In a container, these compiled Python files aren't needed, saving space and keeping your environment clean.

4. **ENV PYTHONUNBUFFERED 1**
   - **Unbuffered Output**: Ensures Python outputs are displayed in real-time.
   - **Why?**: Useful for logging, this makes sure you see your print statements and logs immediately without delay.

5. **WORKDIR /code**
   - **Set Working Directory**: Defines `/code` as the directory where all subsequent commands will run.
   - **Why?**: This organizes your files and sets a base path for the rest of your operations.

6. **COPY ./requirements.txt .**
   - **Copy Requirements File**: Transfers the `requirements.txt` from your local machine to the Docker container's current directory.
   - **Why?**: This file lists all the Python packages your project needs.

7. **RUN pip install -r requirements.txt**
   - **Install Dependencies**: Runs pip to install all the packages listed in `requirements.txt`.
   - **Why?**: This step ensures all necessary libraries are available in your Docker environment.

8. **COPY . .**
   - **Copy Project Files**: Copies all your local files into the Docker container's working directory (`/code`).
   - **Why?**: This makes your entire project accessible inside the container for execution.

### **Step 6: Create a `.dockerignore` File**

A `.dockerignore` file is used to specify which files and directories should be ignored when creating a Docker image. This can help reduce the size of the image and improve security. Here's an example `.dockerignore` file:

```plaintext
Pipfile
Pipfile.lock
.git
.gitignore
```

**Explanation of the `.dockerignore` File:**

1. **`Pipfile` and `Pipfile.lock`**: These files are already copied into the Docker image, so they can be ignored to avoid redundancy.

2. **`.git`**: This excludes the Git directory from being copied, which is unnecessary for the Docker image.

3. **`.gitignore`**: This excludes the `.gitignore` file itself, which is only relevant to Git and not the Docker image.

### **Step 7: Build the Docker Image with a Tag**

To build the Docker image using the `Dockerfile`, run the following command:

```shell
docker build -t docker-helloworld .
```

**Explanation of the Docker Build Command:**

1. **`docker build -t docker-helloworld .`**: This command builds the Docker image from the current directory (`.`) and tags it with the name `docker-helloworld`. This tagging makes it easier to reference the image later, especially when deploying or running containers.

This command will create a Docker image based on the instructions in the `Dockerfile`. The `.` at the end specifies that the `Dockerfile` is located in the current directory.

### **Step 8: Create a `docker-compose.yml` File**

The `docker-compose.yml` file defines how the Docker container should run. Here's an example `docker-compose.yml` file for your Django project:

```yaml
services:
  web:
    build: .
    ports:
      - "8000:8000"
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
```

**Explanation of the `docker-compose.yml` File:**

1. **`version: "3.9"`**: This specifies the version of Docker Compose being used. Version 3.9 is one of the most recent versions.

2. **`services:`**: This section defines the different services that will run in your Docker containers. In this case, we only have one service called `web`.

3. **`build: .`**: This tells Docker Compose to build the image using the `Dockerfile` located in the current directory.

4. **`ports: - "8000:8000"`**: This maps port 8000 on the Docker container to port 8000 on your local machine, allowing you to access the Django development server at `http://127.0.0.1:8000/`.

5. **`command: python manage.py runserver 0.0.0.0:8000`**: This is the command that will be run inside the container to start the Django development server.

6. **`volumes: - .:/code`**: This mounts the current directory on your local machine to the `/code` directory inside the Docker container, allowing you to sync code changes between your local environment and the Docker container.

### **Step 9: Run the Docker Container**

To start the Docker container using Docker Compose, run the following command:

```shell
docker-compose up
```

This command will build the image if it hasn't been built already and then start the container according to the configuration in the `docker-compose.yml` file.

Visit `http://127.0.0.1:8000/` in your browser to confirm everything is working.

### **Step 10: Stop the Docker Container**

When you're done, stop the Docker container with the following commands:

```shell
docker-compose down
```

This command will stop and remove the container, freeing up system resources.

### **Step 11: Use Git for Version Control**

1. **Initialize Git:**

    ```shell
    git init
    ```

2. **Create a `.gitignore` File:**

    ```plaintext
    Pipfile
    Pipfile.lock
    __pycache__/
    db.sqlite3
    .DS_Store  # Mac only
    ```

3. **Add and Commit Your Files:**

    ```shell
    git add .
    git commit -m 'docker-helloworld'
    ```

4. **Compare Your Code with the Official Repository:**

    You can compare your code with the official repository available on GitHub.

### **Conclusion**

Docker provides a self-contained environment that includes everything you need for local development: web services, databases, and more. The general pattern for using Docker with Django is:

1. Create a new virtual environment and install Django.
2. Create a new Django project.
3. Write a `Dockerfile` and build the image.
4. Write a `docker-compose.yml` file and run the container.

With practice, this workflow will become second nature.

In the next section, we'll create a new Django project using Docker and add PostgreSQL as our database.
