# Debugging Django Application in VS Code

This guide will walk you through the process of setting up debugging for a Django application in Visual Studio Code (VS Code). We'll use a dummy calculation in a view to demonstrate how to set breakpoints and debug the application. We'll assume you have a Django project named `storefront` with two apps: `store` and `tags`.

## Table of Contents
- [Debugging Django Application in VS Code](#debugging-django-application-in-vs-code)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Setting Up VS Code for Django Debugging](#setting-up-vs-code-for-django-debugging)
  - [Creating a Dummy View for Debugging](#creating-a-dummy-view-for-debugging)
  - [Running the Debugger](#running-the-debugger)
  - [Conclusion](#conclusion)

## Prerequisites

- Make sure you have VS Code installed.
- Ensure the Python extension for VS Code is installed.
- Ensure the Python Debugger extension (debugpy) is installed.
- Have the `storefront` project with `store` and `tags` apps set up.

## Setting Up VS Code for Django Debugging

1. **Open the Project in VS Code:**
    - Open your `storefront` project directory in VS Code.

2. **Install Python Debugger Extension:**
    - Install the `debugpy` extension from the VS Code marketplace. You can do this by searching for `debugpy` in the Extensions view (Ctrl+Shift+X) and clicking "Install".

3. **Create a Launch Configuration:**
    - In VS Code, go to the Run and Debug view by clicking the play icon on the sidebar or pressing `Ctrl+Shift+D`.
    - Click on "create a launch.json file" link to add a configuration.
    - Select "Django" from the dropdown list.

4. **Modify `launch.json`:**
    - VS Code will create a `launch.json` file inside the `.vscode` directory. Modify it as follows:

    ```json
    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Django",
                "type": "python",
                "request": "launch",
                "program": "${workspaceFolder}/manage.py",
                "args": [
                    "runserver",
                    "8000"
                ],
                "django": true
            }
        ]
    }
    ```

## Creating a Dummy View for Debugging

1. **Add a Dummy View in `store/views.py`:**

    ```python
    from django.shortcuts import render
    from django.http import HttpResponse

    def dummy_calculation_view(request):
        a = 10
        b = 20
        result = a + b  # Dummy calculation
        return HttpResponse(f"The result of the calculation is {result}")
    ```

2. **Update `store/urls.py` to Include the Dummy View:**

    ```python
    from django.urls import path
    from .views import dummy_calculation_view

    urlpatterns = [
        path('dummy/', dummy_calculation_view, name='dummy_calculation'),
    ]
    ```

3. **Include `store` URLs in Main `urls.py`:**

    **Modify `storefront/urls.py`:**

    ```python
    from django.contrib import admin
    from django.urls import path, include

    urlpatterns = [
        path('admin/', admin.site.urls),
        path('store/', include('store.urls')),
    ]
    ```

## Running the Debugger

1. **Set Breakpoints:**
    - Open `store/views.py` in VS Code.
    - Click on the left margin next to the line number to set breakpoints, for example, on the line `result = a + b`.

2. **Start Debugging:**
    - Go to the Run and Debug view by clicking the play icon on the sidebar or pressing `Ctrl+Shift+D`.
    - Select "Django" configuration and click the green play button to start debugging.

3. **Access the Dummy View:**
    - Open a web browser and navigate to `http://localhost:8000/store/dummy/`.

4. **Inspect Variables:**
    - The debugger will pause execution at the breakpoint you set.
    - You can inspect variables, step through the code, and evaluate expressions in the debug console.

## Conclusion

This guide has shown you how to set up debugging for a Django application in VS Code. By creating a dummy calculation in a view and setting breakpoints, you can easily debug your application and inspect variables at runtime. This setup will help you identify and fix issues more efficiently during development.