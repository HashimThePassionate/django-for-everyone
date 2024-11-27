# 📄 Schemas and Documentation ✨

Welcome to the **Schemas and Documentation** section! In this README, we'll explore how to document your Django REST Framework (DRF) API effectively. Proper documentation ensures that your API is easily understandable and usable by other developers, whether they're within your team or accessing your public API. Let's dive in! 🚀📝

---

## 📋 Table of Contents

- [📄 Schemas and Documentation ✨](#-schemas-and-documentation-)
  - [📋 Table of Contents](#-table-of-contents)
  - [🔍 Introduction](#-introduction)
    - [Why Documentation Matters](#why-documentation-matters)
  - [🔗 Current API Endpoints](#-current-api-endpoints)
  - [🛠️ Adding Schemas](#️-adding-schemas)
    - [1. Installing drf-spectacular 📦](#1-installing-drf-spectacular-)
    - [2. Configuring `settings.py` ⚙️](#2-configuring-settingspy-️)
      - [**a. Add to `INSTALLED_APPS`**](#a-add-to-installed_apps)
      - [**b. Configure REST Framework Settings**](#b-configure-rest-framework-settings)
      - [**c. Add Metadata for the Schema**](#c-add-metadata-for-the-schema)
    - [3. Generating the Schema 📄](#3-generating-the-schema-)
    - [4. Serving the Schema Dynamically 🌐](#4-serving-the-schema-dynamically-)
      - [**a. Update `urls.py`**](#a-update-urlspy)
      - [**b. Accessing the Schema**](#b-accessing-the-schema)
  - [📚 Adding Documentation](#-adding-documentation)
    - [1. Integrating Redoc 📖](#1-integrating-redoc-)
      - [**a. Update `urls.py`**](#a-update-urlspy-1)
      - [**b. Accessing Redoc Documentation**](#b-accessing-redoc-documentation)
    - [2. Integrating SwaggerUI 🛠️](#2-integrating-swaggerui-️)
      - [**a. Update `urls.py`**](#a-update-urlspy-2)
      - [**b. Accessing SwaggerUI Documentation**](#b-accessing-swaggerui-documentation)
  - [🎯 Conclusion](#-conclusion)
  - [💾 Git Commit](#-git-commit)
    - [**Steps:**](#steps)
    - [**Best Practices:**](#best-practices)
    - [**Example Workflow:**](#example-workflow)

---

## 🔍 Introduction

Once your API is complete, it's crucial to **document its functionality** quickly and accurately. In most companies and teams, the developer using the API is different from the one who built it. Additionally, if your API is public, comprehensive documentation is essential for its usability. 📚🌟

### Why Documentation Matters

- **Collaboration**: Helps team members understand and use the API effectively.
- **Usability**: Ensures external developers can integrate with your API seamlessly.
- **Maintenance**: Facilitates easier updates and troubleshooting by providing clear guidelines.

To achieve this, we'll add both **machine-readable schemas** and **human-readable documentation** to our Blog project, automating their generation to keep them up-to-date with the latest API changes. 🤖📄

---

## 🔗 Current API Endpoints

Before we enhance our documentation, let's review the **current list of API endpoints** in our project:

| **Endpoint**                         | **HTTP Verb** |
|--------------------------------------|---------------|
| `/`                                  | GET           |
| `/:pk/`                              | GET           |
| `users/`                             | GET           |
| `users/:pk/`                         | GET           |
| `/rest-auth/registration`            | POST          |
| `/rest-auth/login`                   | POST          |
| `/rest-auth/logout`                  | GET           |
| `/rest-auth/password/reset`          | POST          |
| `/rest-auth/password/reset/confirm`  | POST          |

- **Custom Endpoints**: `/` and `/:pk/`
- **Provided by `dj-rest-auth`**: The remaining seven endpoints

In this section, we'll **add schemas and documentation** to make our API more accessible and maintainable. 📈🔧

---

## 🛠️ Adding Schemas

Schemas provide a **machine-readable** description of your API, detailing available endpoints, URLs, HTTP verbs, inputs, authentication methods, and more. The **OpenAPI** specification is the current standard for API schemas. We'll use the **drf-spectacular** package to generate an OpenAPI 3 schema for our Django REST Framework project. 📜🤖

### 1. Installing drf-spectacular 📦

First, install the **drf-spectacular** package using Pip:

```bash
pipenv install drf-spectacular
```

*🛠️ **Tip:*** Ensure you're within your project's virtual environment before running the installation command.

### 2. Configuring `settings.py` ⚙️

Next, integrate **drf-spectacular** into your Django project by modifying the `settings.py` file.

#### **a. Add to `INSTALLED_APPS`**

Open `django_project/settings.py` and add `"drf_spectacular"` to the `INSTALLED_APPS` list:

```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "django.contrib.sites",
    # 3rd-party apps
    "rest_framework",
    "corsheaders",
    "rest_framework.authtoken",
    "allauth",
    "allauth.account",
    "allauth.socialaccount",
    "dj_rest_auth",
    "dj_rest_auth.registration",
    "drf_spectacular",  # 🆕 Added drf-spectacular
    # Local
    "accounts",
    "posts",
]
```

*🔍 **Note:*** Ensure `"drf_spectacular"` is placed appropriately within the `INSTALLED_APPS` list to avoid any import issues.

#### **b. Configure REST Framework Settings**

Still in `settings.py`, update the `REST_FRAMEWORK` configuration to use drf-spectacular's `AutoSchema`:

```python
# django_project/settings.py

REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework.authentication.SessionAuthentication",
        "rest_framework.authentication.TokenAuthentication",
    ],
    "DEFAULT_THROTTLE_CLASSES": [
        "rest_framework.throttling.AnonRateThrottle",
        "rest_framework.throttling.UserRateThrottle",
        "posts.throttling.FivePerFiveMinuteThrottle",
    ],
    "DEFAULT_THROTTLE_RATES": {
        "anon": "2/day",
        "user": "5/day",
        "burst": "10/minute",
        "five_per_five_minute": "5/5m",
    },
    # Custom exception handler
    "EXCEPTION_HANDLER": "posts.exceptions.custom_exception_handler",
    "DEFAULT_SCHEMA_CLASS": "drf_spectacular.openapi.AutoSchema",  # 🆕 Set AutoSchema
}
```

*🔧 **Explanation:*

- **`DEFAULT_SCHEMA_CLASS`**: Instructs DRF to use drf-spectacular's `AutoSchema` for generating the API schema.

#### **c. Add Metadata for the Schema**

Add a new section `SPECTACULAR_SETTINGS` to include metadata like title, description, and version:

```python
# django_project/settings.py

SPECTACULAR_SETTINGS = {
    "TITLE": "Blog API Project",  # 📝 Title of the API
    "DESCRIPTION": "A sample blog to learn about DRF",  # 📝 Brief description
    "VERSION": "1.0.0",  # 🆕 Version of the API
    # OTHER SETTINGS can be added here
}
```

*📝 **Tip:*** Customize the `TITLE`, `DESCRIPTION`, and `VERSION` to reflect your project's specifics.

### 3. Generating the Schema 📄

With **drf-spectacular** installed and configured, generate the schema using the provided management command:

```bash
python manage.py spectacular --file schema.yml
```

*📂 **Outcome:* A `schema.yml` file is created in your project's root directory. This file contains a **machine-readable** description of your entire API in YAML format.

*🔍 **Note:*** While `schema.yml` is perfect for machines, it's not very human-friendly. For better readability, we'll serve the schema dynamically and add human-readable documentation.

### 4. Serving the Schema Dynamically 🌐

Instead of manually generating `schema.yml` each time your API changes, you can serve the schema directly from your API. This ensures that the schema is always up-to-date. Here's how to do it:

#### **a. Update `urls.py`**

Open `django_project/urls.py` and import `SpectacularAPIView`. Then, add a new URL path to serve the schema:

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import SpectacularAPIView  # 🆕 Import SpectacularAPIView

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/", include("posts.urls")),
    path("api-auth/", include("rest_framework.urls")),
    path("api/v1/dj-rest-auth/", include("dj_rest_auth.urls")),
    path(
        "api/v1/dj-rest-auth/registration/",
        include("dj_rest_auth.registration.urls"),
    ),
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),  # 🆕 Schema URL
]
```

*🔍 **Explanation:*

- **`SpectacularAPIView`**: A view that serves the API schema.
- **`path("api/schema/", ...)`**: Registers the schema view at the specified URL.

#### **b. Accessing the Schema**

Start your local server:

```bash
python manage.py runserver
```

Navigate to the schema URL in your browser:

```
http://127.0.0.1:8000/api/schema/
```

*💡 **Tip:*** This URL will display the **automatically generated schema** of your entire API, ready to be consumed by tools or for further documentation purposes.

---

## 📚 Adding Documentation

While schemas are excellent for machines, **human-readable documentation** is essential for developers to understand and use your API effectively. We'll use two popular documentation tools supported by **drf-spectacular**: **Redoc** and **SwaggerUI**. These tools transform your schema into interactive and user-friendly documentation interfaces. 📖✨

### 1. Integrating Redoc 📖

**Redoc** is a powerful tool for generating API documentation from OpenAPI schemas. Here's how to integrate it into your Django project:

#### **a. Update `urls.py`**

Import `SpectacularRedocView` and add a new URL path for Redoc:

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,  # 🆕 Import SpectacularRedocView
)

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/", include("posts.urls")),
    path("api-auth/", include("rest_framework.urls")),
    path("api/v1/dj-rest-auth/", include("dj_rest_auth.urls")),
    path(
        "api/v1/dj-rest-auth/registration/",
        include("dj_rest_auth.registration.urls"),
    ),
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path(
        "api/schema/redoc/",
        SpectacularRedocView.as_view(url_name="schema"),
        name="redoc",
    ),  # 🆕 Redoc Documentation URL
]
```

*🔍 **Explanation:*

- **`SpectacularRedocView`**: Renders the Redoc interface based on your API schema.
- **`path("api/schema/redoc/", ...)`**: Registers the Redoc documentation at the specified URL.

#### **b. Accessing Redoc Documentation**

With the server running, navigate to:

```
http://127.0.0.1:8000/api/schema/redoc/
```

*🌐 **Outcome:* You'll see a beautifully rendered **Redoc** interface displaying your API documentation, complete with interactive features like expandable endpoints and parameter details.

### 2. Integrating SwaggerUI 🛠️

**SwaggerUI** is another popular tool for API documentation, offering a sleek and interactive interface. Here's how to set it up:

#### **a. Update `urls.py`**

Import `SpectacularSwaggerView` and add a new URL path for SwaggerUI:

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,
    SpectacularSwaggerView,  # 🆕 Import SpectacularSwaggerView
)

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/", include("posts.urls")),
    path("api-auth/", include("rest_framework.urls")),
    path("api/v1/dj-rest-auth/", include("dj_rest_auth.urls")),
    path(
        "api/v1/dj-rest-auth/registration/",
        include("dj_rest_auth.registration.urls"),
    ),
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path(
        "api/schema/redoc/",
        SpectacularRedocView.as_view(url_name="schema"),
        name="redoc",
    ),
    path(
        "api/schema/swagger-ui/",
        SpectacularSwaggerView.as_view(url_name="schema"),
        name="swagger-ui",
    ),  # 🆕 SwaggerUI Documentation URL
]
```

*🔍 **Explanation:*

- **`SpectacularSwaggerView`**: Renders the SwaggerUI interface based on your API schema.
- **`path("api/schema/swagger-ui/", ...)`**: Registers the SwaggerUI documentation at the specified URL.

#### **b. Accessing SwaggerUI Documentation**

With the server running, navigate to:

```
http://127.0.0.1:8000/api/schema/swagger-ui/
```

*🌐 **Outcome:* You'll see an interactive **SwaggerUI** interface displaying your API documentation, allowing you to explore and test your API endpoints directly from the browser.

---

## 🎯 Conclusion

Adding **schemas** and **documentation** is a vital step in making your API **accessible**, **maintainable**, and **secure**. Here's a quick recap of what we've achieved:

- **Schemas**:
  - **Machine-Readable**: Allows tools and services to understand your API structure.
  - **Automatic Generation**: With **drf-spectacular**, your schema stays up-to-date with your API changes.
  
- **Documentation**:
  - **Human-Readable**: Tools like **Redoc** and **SwaggerUI** transform schemas into interactive and user-friendly interfaces.
  - **Interactive Testing**: Developers can test API endpoints directly from the documentation interface.
  
- **Automation**:
  - **Dynamic Schema Serving**: Avoids the need to manually regenerate schema files.
  - **Consistent Documentation**: Ensures that your documentation always reflects the current state of your API.

**Key Takeaways**:

1. **Integrate drf-spectacular** early to streamline schema generation.
2. **Use Redoc and SwaggerUI** to provide comprehensive and interactive documentation.
3. **Automate schema and documentation updates** to maintain consistency and reduce manual effort.
4. **Prioritize clear and detailed documentation** to enhance API usability and developer experience.

By implementing these tools and practices, your Django REST Framework project becomes more robust, easier to use, and better suited for collaboration and public use. 🌟🚀

---

## 💾 Git Commit

After enhancing your API with schemas and documentation, it's essential to **commit your changes** to version control to track progress and maintain a history of your project. Here's how to do it:

### **Steps:**

1. **Check the Current Status**

```bash
git status  # 🔍 View the current status of your repository
```

   *🔎 **Explanation:* This command shows the changes that have been made but not yet committed.*

2. **Stage All Changes**

```bash
git add -A   # ➕ Stage all changes (new files, modifications, deletions)
```

   *📦 **Explanation:* The `-A` flag stages all changes in the repository.*

3. **Commit with a Meaningful Message**

```bash
git commit -m "Schemas and Documentation"  # 💬 Commit with message
```

*📝 **Explanation:* The `-m` flag allows you to add a commit message inline. A clear message like `"Schemas and Documentation"` describes what was done.*

### **Best Practices:**

- **Meaningful Commit Messages:** Clearly describe what changes were made and why. This helps in understanding the project's history.
  
- **Frequent Commits:** Commit regularly to capture incremental changes. This makes it easier to track progress and revert if necessary.
  
- **Use Branches:** For new features or major changes, create separate branches to isolate work and prevent conflicts.

### **Example Workflow:**

```bash
git status -s
git add .
git commit -m "Schemas and Documentation"
```

*🚀 **Outcome:* Your changes are now committed to the repository with a descriptive message, ensuring that your project's history remains clear and organized.*