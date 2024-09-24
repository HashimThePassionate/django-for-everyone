# 📝 Todo API

Welcome to the **Todo API**! In this section, we'll be building and deploying a powerful back-end for managing your todo tasks. 🎯 The API will include endpoints for listing all todos and handling individual todo tasks. Plus, we'll dive into some essential security features like **Cross-Origin Resource Sharing (CORS)** to ensure that the back-end and front-end can communicate safely and effectively.

## 🌟 What Will You Learn?

By the end of this section, you'll be able to:

- ✅ Build and deploy a **Todo API** back-end.
- 🔗 Understand and implement **API Endpoints** for listing and managing todos.
- 🚀 Learn about **CORS** and why it’s crucial for security when your back-end is interacting with a front-end.
- 🛠️ Strengthen your knowledge of **HTTP** and **REST** architecture.

Although you may have already created your first API and learned about **HTTP** and **REST** concepts, this section will help you see how everything truly fits together! 🤝

--- 

## 🌐 Single Page Apps (SPAs)

**SPAs** are a must for creating dynamic mobile apps that run on platforms like **iOS** and **Android**. They’re also the go-to pattern for modern web apps that leverage JavaScript front-end frameworks like **React**, **Vue**, or **Angular**. 🚀

### 🤔 Why Choose SPAs?

There are several reasons why adopting a **SPA** approach is beneficial:

- 🎯 **Specialized Development**: Developers can focus on their area of expertise, whether it’s the front-end or back-end. It's not common to be skilled in both!
- 🔧 **Tailored Tools**: SPAs allow developers to use testing and build tools specific to their area of work. Building and deploying a Django back-end is very different from doing the same for a JavaScript front-end like React.
- 🔗 **Decoupled Structure**: By separating the front-end from the back-end, there’s no risk of breaking one part of the app when making changes to the other! 💪
- 👥 **Teamwork**: For larger teams, SPAs provide a clear separation of tasks. Even for smaller teams, the adoption cost is relatively low, making it an efficient option.

### ⚠️ Things to Consider

While there are many benefits, keep in mind:

- 💻 **Domain Knowledge**: A good grasp of both the front-end and back-end is needed for SPAs.
- 🏗️ **Maturity**: While **Django** is a mature framework, the front-end ecosystem is constantly evolving. Solo developers might want to weigh the complexity of using a full JavaScript front-end versus adding bits of JavaScript to existing Django templates using modern tools like **htmx**.

--- 

### 🛠️ Django REST Framework

The **Django REST Framework (DRF)** is a powerful toolkit for building APIs with Django. In this section, we will install and configure it to build the backend of our **Todo API**. Let's dive into the process step by step! 🚀

## 🧑‍💻 Installing Django REST Framework

1. First, stop your local Django server by typing `Control + C` in the terminal. 🛑
2. Now, install the Django REST Framework using `pip`:

```bash
pipenv python install djangorestframework
```

This will install **DRF** in your virtual environment. ⚙️

## ⚙️ Adding DRF to Installed Apps

Next, let's add **DRF** to our `INSTALLED_APPS` in the `settings.py` file:

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 3rd party
    "rest_framework",  # new
    # Local
    "todos",
]
```

This will make the Django REST Framework available in your project. 🌟

## 🔐 Setting Up Permissions

To get started with the API, we'll configure permissions to allow unrestricted access. This will be done under the `REST_FRAMEWORK` settings at the bottom of `settings.py`. Add the following:

```python
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.AllowAny",
    ],
}
```

### 🚨 Note:
- **AllowAny** permits unrestricted access to the API. In a real-world application, you’d want to have stricter control over your API's permissions! 🛡️ But for learning purposes, this is a good starting point.
- **Default Settings**: DRF comes with many default settings to help you get started quickly, but you'll need to adjust these before deploying to production. For example, the **AllowAny** permission is automatically set by default, even if you don't explicitly add it. For a full list of default settings, check out the [DRF Documentation](http://www.django-rest-framework.org/api-guide/permissions/#allowany) 📘.

## 🎉 What's Next?

Now that **DRF** is installed, you're ready to build APIs! Unlike traditional Django projects where you create both **views** and **templates**, here we will focus solely on building API endpoints. So, no need to worry about template files! 📝

You also don’t have to create a separate `apis` app for API-related functionality since this project is API-first by design. **Django** gives developers flexibility in structuring their apps, so you can decide the best way to organize them. 🧩

---

## 🌐 URLs Setup for Todo API

Let's start by setting up the **URLs** for our **Todo API**! The URLs act as the entry point for your API endpoints. This is an important step since it connects the client (front-end) to your Django back-end. 🚀

### 🛠️ Setting Up Project-Level URLs

1. Open the `urls.py` file located at `django_project/urls.py`. ✨
2. We’ll import `include` to manage routes, and then we’ll add a new path for our **todos app** at the `api/` endpoint.

Here’s what the updated file should look like:

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include("todos.urls")),  # new
]
```

### 📌 Why "api/"?

It's a great idea to have all API endpoints under a consistent path like `api/`. This keeps things organized and allows you to easily add traditional Django web pages later without conflicts. 👍

## 📂 Creating App-Level URLs

Next, let’s set up the **todos** app-level URLs. In your `todos/` folder, create a `urls.py` file and add the following code:

```python
# todos/urls.py
from django.urls import path
from .views import ListTodo, DetailTodo

urlpatterns = [
    path("<int:pk>/", DetailTodo.as_view(), name="todo_detail"),
    path("", ListTodo.as_view(), name="todo_list"),
]
```

### 🧭 What's Happening Here?

- **ListTodo**: This view will display a list of all your todos and will be available at the root `api/`.
- **DetailTodo**: This view will show the details of individual todos, accessible by their primary key (**pk**) at the endpoint `api/<int:pk>/` (e.g., `api/1/`, `api/2/`, etc.). The **pk** is automatically generated by Django for each todo you create in the database. 🔑

Here's how we can convert the **Serializers** explanation into a beautiful and beginner-friendly README format with clear steps, explanations, and engaging emojis:

---

## 🛠️ Serializers in Django REST Framework

Now that we’ve set up our URLs, it’s time to focus on **serializers**! A **serializer** helps us convert our **Todo model data** into **JSON**, which is what our API will output at the configured endpoints. Let’s dive into creating and understanding serializers! 🧑‍💻

### 🔄 What is a Serializer?

In **Django REST Framework (DRF)**, a **serializer** transforms Django model data into JSON format, making it easy to share data via APIs. Without serializers, your models wouldn't be able to "speak" in JSON, which is the language of the web! 🌐

### ✨ Setting Up the Serializer

Follow these steps to create the serializer for your **Todo model**:

1. In your `todos/` app, create a new file named `serializers.py`. 📄
2. Add the following code to `serializers.py`:

```python
# todos/serializers.py
from rest_framework import serializers
from .models import Todo

class TodoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todo
        fields = (
            "id",
            "title",
            "body",
        )
```

### 🧩 Code Breakdown:

- **Importing serializers**: First, we import the `serializers` module from **Django REST Framework** and our **Todo model**.
- **Creating the Serializer**: We extend the `ModelSerializer` class to create our custom `TodoSerializer`.
- **Meta class**: Inside the `Meta` class, we define:
  - `model`: The model to serialize, in this case, the **Todo model**.
  - `fields`: The fields we want to expose via the API: `id`, `title`, and `body`.

### 🔑 Why These Fields?

- **id**: This field is automatically created by Django for each todo, similar to a **primary key (pk)**. We'll include this field in our API to uniquely identify each todo.
- **title** and **body**: These are the fields we defined in the **Todo model**, and they’ll be exposed in the API output. 📋

### 🧐 id vs pk – What's the Difference?

- **id**: This is a built-in Python function that refers to a field automatically added to every model by the Django **ORM**.
- **pk**: The **primary key** is a field Django expects in its generic class-based views like `DetailView`. Both terms are commonly used, but **id** is more familiar when working with model fields. 🔑

---

##  Views in Django REST Framework

In this section, we will set up the views that control how our **Todo API** behaves when it receives requests. We’ll use two of Django REST Framework’s **generic views** to keep things simple and organized. 🎯

### 🧩 What Are We Doing?

We’ll create two views:
1. **ListTodo**: To display a list of all todos.
2. **DetailTodo**: To display the details of a specific todo by its **id**.

Let’s get started! 🚀

### 🛠️ Setting Up Views

Follow these steps to create the views in the `todos/views.py` file:

1. Open your `todos/views.py` file. 📄
2. Update it with the following code:

```python
# todos/views.py
from rest_framework import generics
from .models import Todo
from .serializers import TodoSerializer

class ListTodo(generics.ListAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

class DetailTodo(generics.RetrieveAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
```

### 🧑‍💻 Code Breakdown:

- **Importing Required Modules**: At the top, we import the `generics` module from **Django REST Framework**, our **Todo model**, and the **TodoSerializer** we created earlier. 📦
  
- **ListTodo**: This view extends `ListAPIView` to display a list of all todos. It uses:
  - `queryset`: Retrieves all **Todo** objects from the database.
  - `serializer_class`: Specifies that the **TodoSerializer** will be used to transform the data into JSON. 🌐
  
- **DetailTodo**: This view extends `RetrieveAPIView` to display a single todo's details by its **id**. It also uses:
  - `queryset`: Retrieves all **Todo** objects.
  - `serializer_class`: Specifies that **TodoSerializer** will handle the data serialization.

### 📍 Understanding the Views

- **ListTodo**: This view corresponds to the URL that displays a list of all todos (defined in `todos/urls.py`).
- **DetailTodo**: This view corresponds to the URL that shows the details of a specific todo using its **id** (e.g., `api/1/`, `api/2/`). 📋

### 🔄 Code Redundancy

You might notice that both views are repeating the **queryset** and **serializer_class**. This is something we’ll optimize later using **viewsets** and **routers**, which allow us to write cleaner and more efficient code. But for now, this approach works perfectly! 🔧

---

## 🌐 Browsable API in Django REST Framework

Now that our **Todo API** is set up, it’s time to interact with it using **Django REST Framework’s** browsable API! This is a fantastic feature that lets us view and interact with our API directly from the browser without the need for external tools. 🚀

### 🖥️ Accessing the Browsable API

1. Make sure your **local server** is running. You can start it using:

   ```bash
   python manage.py runserver
   ```

2. Navigate to the following URL in your browser:

   🌍 **API List View**: [http://127.0.0.1:8000/api/](http://127.0.0.1:8000/api/)

Here, you’ll see a list of all the **todos** that were created earlier in the database. This is the **API list view** endpoint, which shows the collection of todos stored in the system. 📋

### 🔍 What Are Endpoints and Resources?

- **Endpoint**: The URL used to make a request to the API (e.g., `api/`).
- **Resource**: A single item (like a specific todo) available at an endpoint (e.g., `api/1/`).

These terms are often used interchangeably but have different meanings. 🌟

### 🧭 Navigating to API Detail Views

Each individual todo can be accessed by its **id** at the following URLs:

- 🌍 **Todo 1**: [http://127.0.0.1:8000/api/1/](http://127.0.0.1:8000/api/1/)
- 🌍 **Todo 2**: [http://127.0.0.1:8000/api/2/](http://127.0.0.1:8000/api/2/)
- 🌍 **Todo 3**: [http://127.0.0.1:8000/api/3/](http://127.0.0.1:8000/api/3/)

This allows you to see the **details** for each todo, such as the **title** and **body**, through a clean and user-friendly interface provided by Django REST Framework. 🎯

## 🚀 Browsable API Features

- **Interactive**: You can add, update, or delete data right from the browser! ✨
- **Developer-Friendly**: It’s a great way to test and see your API in action without needing to use tools like Postman or curl. 🛠️
---

## 🧪 API Tests for Todo API

Testing is a critical part of API development. We need to ensure that our API endpoints return the correct status codes, use the correct URLs, and display the expected content. In this section, we will create tests for our **Todo API** using **Django REST Framework’s** built-in testing helpers. 🚀

### 🧑‍💻 What Are We Testing?

1. **List View Test**: We’ll test that the list of todos is displayed correctly.
2. **Detail View Test**: We’ll test that individual todo details are shown properly when accessed via their **id**.

Let’s start setting up our tests! 🛠️

### 🛠️ Setting Up API Tests

1. Open the `todos/tests.py` file in your text editor. 📝
2. Add the following code to test both the **list view** and **detail view** of our API:

```python
# todos/tests.py
from django.test import TestCase
from django.urls import reverse  # new
from rest_framework import status  # new
from rest_framework.test import APITestCase  # new
from .models import Todo

class TodoModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.todo = Todo.objects.create(
            title="First Todo",
            body="A body of text here"
        )

    def test_model_content(self):
        self.assertEqual(self.todo.title, "First Todo")
        self.assertEqual(self.todo.body, "A body of text here")
        self.assertEqual(str(self.todo), "First Todo")

    def test_api_listview(self):  # new
        response = self.client.get(reverse("todo_list"))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(Todo.objects.count(), 1)
        self.assertContains(response, self.todo)

    def test_api_detailview(self):  # new
        response = self.client.get(
            reverse("todo_detail", kwargs={"pk": self.todo.id}),
            format="json"
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(Todo.objects.count(), 1)
        self.assertContains(response, "First Todo")
```

### 🧩 Code Breakdown:

- **Imports**:
  - `reverse`: To reverse the named URLs.
  - `status`: To verify that the correct HTTP status codes are returned.
  - `APITestCase`: To handle API-specific test cases.
  
- **TodoModelTest**: This class contains:
  - **setUpTestData**: Creates a test todo instance with a title and body.
  - **test_model_content**: Verifies that the model’s fields are correctly set.
  - **test_api_listview**: Checks if the list of todos is displayed correctly at the **todo_list** endpoint.
  - **test_api_detailview**: Ensures the details of a specific todo are displayed at the **todo_detail** endpoint, identified by its **id** (pk).

### 🧪 Running the Tests

Now, let’s run the tests to make sure everything is working as expected. Use the following command:

```bash
(.venv) > python manage.py test
```

### 📊 Test Output Example:

You should see an output like this:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 3 tests in 0.007s

OK
Destroying test database for alias 'default'...
```

- **Ran 3 tests**: This confirms that all 3 tests (model content, list view, and detail view) passed successfully! 🎉

### 🔒 Additional Considerations

Since our back-end will communicate with a front-end on a different port, we need to address potential security concerns like **CORS** (Cross-Origin Resource Sharing). We’ll cover this in the next section! 🛡️

---

## 🔒 CORS (Cross-Origin Resource Sharing) in Django

When building web applications, security is always a key concern. One such security measure is **CORS (Cross-Origin Resource Sharing)**, which becomes important when your **back-end** and **front-end** are hosted on different domains or even different ports. Let’s break this down and explain how to handle CORS in a Django project. 🚀

## 🤔 What is CORS?

**CORS** refers to a browser security feature that restricts web pages from making requests to a different domain or port than the one that served the web page.

For example:
- Your **front-end** is hosted on `localhost:3000` (React or Vue app).
- Your **back-end API** is hosted on `localhost:8000` (Django).

Without **CORS**, browsers would block requests from the front-end to the back-end because they’re on different ports/domains. This is a security feature meant to prevent malicious websites from accessing sensitive data hosted on another site.

## 🔧 How Does CORS Work?

When a client (like a front-end web app) makes a request to your **back-end API** hosted on a different domain or port, the server must include specific **HTTP headers** that indicate which domains (or ports) are allowed to make requests.

These HTTP headers look like this:

```http
Access-Control-Allow-Origin: http://localhost:3000
```

This header tells the browser it’s safe to allow requests from the front-end hosted on `http://localhost:3000`.


## 🛠️ Setting Up CORS in Django

The easiest way to manage CORS in Django is to use a third-party package called `django-cors-headers`. This package automatically handles CORS by adding the necessary HTTP headers to your responses based on your configuration.

### Steps to Set Up CORS:

### 1. **Install `django-cors-headers`**

First, make sure your Django server is not running. You can stop it using `Control + C`. Then, install the package:

```bash
pipenv install django-cors-headers
pip freeze > requirements.txt
```

This will add `django-cors-headers` to your project dependencies.

### 2. **Update `settings.py`**

You need to modify your `settings.py` file to enable and configure CORS.

#### a) Add `corsheaders` to `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 3rd party apps
    "rest_framework",
    "corsheaders",  # new: CORS handling
    # Local apps
    "todos",
]
```

### b) Add `CorsMiddleware` to `MIDDLEWARE`:

Make sure `CorsMiddleware` is placed **above** `CommonMiddleware` in your middleware settings. This ensures that CORS headers are processed before other middleware.

```python
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",  # new: Handle CORS
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]
```

This middleware ensures that the proper headers are added to responses for cross-domain requests.

### c) Define Allowed Origins with `CORS_ALLOWED_ORIGINS`:

At the bottom of `settings.py`, add a `CORS_ALLOWED_ORIGINS` list. This will specify which domains are allowed to interact with your API:

```python
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",  # For your front-end (e.g., React/Vue app)
    "http://localhost:8000",  # For your Django API
]
```

- **`localhost:3000`** is typically the port for React or Vue development servers.
- **`localhost:8000`** is the default Django development port.

These settings allow your front-end (on `3000`) to make API requests to your back-end (on `8000`) without any security blocks from the browser.

### 🧑‍💻 Why is Middleware Order Important?

Middleware in Django is processed from **top to bottom**. So, it’s crucial that **`CorsMiddleware`** is added before **`CommonMiddleware`**. This ensures that the CORS headers are processed early in the request-response cycle and are included in the response.

---

## 🔐 CSRF (Cross-Site Request Forgery) Protection

When building web applications, security concerns like **Cross-Site Request Forgery (CSRF)** need to be addressed. Django comes with built-in CSRF protection, but when your **front-end** is a **React**, **Vue**, or other SPA framework, this protection isn’t automatically applied. Let’s break down how to handle this properly in Django. 🚀

### 🤔 What is CSRF?

**CSRF** stands for **Cross-Site Request Forgery**, a type of attack where a malicious site tricks users into submitting unauthorized requests to another site (e.g., your Django app). To prevent this, Django generates a **CSRF token** for each form submission, ensuring that the request comes from a trusted source.

In traditional Django apps, CSRF protection is automatically added to all forms in templates. However, in a **SPA** setup, the front-end (like React or Vue) is hosted separately, often on a different domain or port. This separation means the CSRF token isn’t automatically available, so we need to configure Django to trust requests from the front-end.

---

### 🛠️ Configuring CSRF for SPAs

When your **front-end** is hosted on a different port or domain (e.g., `localhost:3000` for React), you need to tell Django to trust requests coming from that origin. This is done by using the **CSRF_TRUSTED_ORIGINS** setting.

### Steps to Set Up CSRF Protection:

### 1. **Add Trusted Origins to `settings.py`**

At the bottom of your `settings.py` file, add the **CSRF_TRUSTED_ORIGINS** configuration. This will tell Django to trust cross-domain requests coming from the specified origin (in this case, `localhost:3000` for React development).

Here’s how to add it:

```python
# django_project/settings.py

CSRF_TRUSTED_ORIGINS = ["http://localhost:3000"]  # Allow cross-origin requests from React
```

### 🔑 Explanation:

- **`CSRF_TRUSTED_ORIGINS`**: This setting tells Django to allow cross-domain requests (like POST, PUT, DELETE) from the specified origin(s). In this case, we trust requests coming from `http://localhost:3000`, which is the default port for **React** during development.
  
  If your front-end is hosted on a different domain or port, simply update the value to match.

### 2. **How It Works**

Now that you’ve added `localhost:3000` as a trusted origin, Django will accept **cross-domain** requests from this port, even if they include form submissions or sensitive data that requires CSRF validation. 🎉

---

## 🚀 Back-End API Deployment (with Heroku)

Deploying your **Django API** to production is a crucial step to make your application accessible over the internet. In this section, we’ll deploy our **Todo API** backend using **Heroku**, a popular platform-as-a-service (PaaS) for deploying web applications. Let’s go step by step! 💻

## 🛠️ Deployment Checklist

Here’s what we need to do to successfully deploy our Django app to Heroku:
1. **Configure static files** and install **WhiteNoise**.
2. Install **Gunicorn** as the production web server.
3. Create necessary deployment files: `requirements.txt and `Procfile`.
4. Update the **ALLOWED_HOSTS** configuration to include Heroku.

### 🔧 Step 1: Setting Up Static Files with WhiteNoise

First, let’s configure static file handling for production using **WhiteNoise**, which helps serve static files (like CSS, JS, etc.) directly from our Django app.

#### a) Create a Static Directory

In the terminal, create a new `static` directory:

```bash
mkdir static
```

Then, create an empty `.keep` file within this directory so that it’s tracked by Git:

```bash
touch static/.keep
```

#### b) Install WhiteNoise

Next, install **WhiteNoise** to handle static files in production:

```bash
pipenv install whitenoise
```

#### c) Update `settings.py`

Update the `django_project/settings.py` file as follows:

#### Add WhiteNoise to `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    # other installed apps
    "whitenoise.runserver_nostatic",  # new
    "django.contrib.staticfiles",
]
```

#### Add WhiteNoise Middleware:

Ensure `WhiteNoiseMiddleware` is added **above** `CommonMiddleware` in `MIDDLEWARE`:

```python
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",  # new
    "corsheaders.middleware.CorsMiddleware",
    # other middlewares
]
```

#### Configure Static Files:

Add the following settings for static files:

```python
STATIC_URL = "/static/"
STATICFILES_DIRS = [BASE_DIR / "static"]  # new
STATIC_ROOT = BASE_DIR / "staticfiles"  # new
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"  # new
```

#### d) Collect Static Files

To bundle all static files for deployment, run the following command:

```bash
python manage.py collectstatic
```

This will collect and compile all static files into the `staticfiles/` directory for use in production.

### 🔧 Step 2: Install Gunicorn (Production Web Server)

**Gunicorn** is a production-grade web server for running Django applications. Let’s install it:

```bash
pipenv install gunicorn
```
### 🔧 Step 3: Create Deployment Files

Now, let’s create the files needed for Heroku deployment.

### a) `Procfile`

Create file named `Procfile` in the root directory with the following line:

```txt
web: gunicorn django_project.wsgi --log-file -
```

The **Procfile** tells Heroku how to run the app using **Gunicorn**.

### b) `requirements.txt`

Generate a **requirements.txt** file with all the dependencies of your project:

```bash
pip freeze > requirements.txt
```

### 🔧 Step 4: Update `ALLOWED_HOSTS`

To ensure your Django app allows requests from Heroku and local development environments, update `ALLOWED_HOSTS` in `settings.py`:

```python
ALLOWED_HOSTS = [".herokuapp.com", "localhost", "127.0.0.1"]
```

This allows your app to handle requests from the `.herokuapp.com` domain and local environments.

## 🛠️ Step 5: Deploy to Heroku

Now that the app is ready, let’s push it to Heroku.

### a) Log Into Heroku

Log into Heroku from your terminal:

```bash
heroku login
```

Follow the prompts to complete the login process.

### b) Create a Heroku App

Create a new app on Heroku:

```bash
heroku create hashim-todo
```

This command creates a new Heroku app with the name `hashim-todo`. The output will show your app’s URL, for example:

```bash
https://hashim-todo.herokuapp.com/
```

### c) Push Your Code to Heroku

Push the code to Heroku using Git:

```bash
git push heroku main
```

### d) Scale the Web Dyno

Activate a web dyno to run the app:

```bash
heroku ps:scale web=1
```

### e) Open Your Deployed App

To open your app in the browser, run:

```bash
heroku open
```
---
