# Creating a Django Project

This guide provides step-by-step instructions to set up a new Django project using `pipenv` for environment management. The project will be named `storefront`.

## Table of Contents
- [Creating a Django Project](#creating-a-django-project)
  - [Table of Contents](#table-of-contents)
  - [Create Project Directory](#create-project-directory)
  - [Set Up Virtual Environment](#set-up-virtual-environment)
  - [Install Django](#install-django)
  - [Create Django Project](#create-django-project)
  - [Run Django Server](#run-django-server)

## Create Project Directory

1. **Create a Directory for Your Project:**
    ```bash
    mkdir storefront
    ```

2. **Change to the Project Directory:**
    ```bash
    cd storefront
    ```

## Set Up Virtual Environment

1. **Create a Virtual Environment with `pipenv`:**
    ```bash
    pipenv shell
    ```

2. **Activate the Virtual Environment: with same command**
    ```bash
    pipenv shell
    ```

## Install Django

1. **Install Django Using `pipenv`:**
    ```bash
    pipenv install django
    ```

## Create Django Project

1. **Run `django-admin` Command to Create a Project:**
    ```bash
    django-admin startproject storefront .
    ```

## Run Django Server

1. **Run the Server on Port 9000:**
    ```bash
    python manage.py runserver 9000
    ```

2. **Access the Server:**
    - Open your web browser and go to `http://localhost:9000`.

---

Follow these steps to successfully create and run your Django project named `storefront`. If you encounter any issues, refer to the Django documentation for further assistance.