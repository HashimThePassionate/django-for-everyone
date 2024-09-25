# 🚀 Blog API 

In this section, we will be building a **Blog API** using the powerful features of **Django REST Framework**. This project will include:

- 👥 **Users**: Handle user data and manage permissions.
- 🔐 **Permissions**: Set up secure access for different types of users.
- ⚙️ **Full CRUD Operations**: Create, Read, Update, and Delete blog posts easily.

## 🛠 Key Features We'll Explore:
- **Viewsets**: Simplify the way we handle requests and responses.
- **Routers**: Automatically configure URLs for your API.
- **Documentation**: Generate clear and comprehensive API documentation.


## 🏗️ Step 1: Building the Basic API Section

We'll begin by building the foundation of our API. Like previous projects (such as the Library and Todo APIs), we'll start with:

1. **Traditional Django**: Setting up the base of the project.
2. **Django REST Framework**: Integrating advanced API functionalities.

### Key Difference 📝:
- We’ll use a **custom user model** 🧑‍💻 from the start to manage users effectively.
- **CRUD operations** will be built in from the beginning, thanks to Django REST Framework’s seamless integration.

---

## 🧑‍💻 Custom User Model

Adding a **custom user model** is an optional, but highly recommended, step. Even if you don’t plan to use it immediately, setting it up now keeps the door open for future improvements.

### Why a Custom User Model? 🤔
- Flexibility: You can add more fields and customize user authentication later.
- Scalability: It prepares your project for any future needs.

### 🛠 How to Add a Custom User Model:

1. **Create a new app** called `accounts` to handle user-related tasks.

```bash
python manage.py startapp accounts
```

2. Add this app to the **INSTALLED_APPS** section in your `settings.py` so Django recognizes it.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "accounts",  # new
]
```

That’s it! Your project is now set up to use a custom user model whenever needed in the future.

---

## 🛠 Defining the Custom User Model

Now that we’ve created the `accounts` app, it’s time to define our **Custom User Model**. This step is crucial for more flexible user management in the future.

### 🏗️ Step 1: Create the Custom User Model

Inside the `accounts/models.py`, we will extend Django’s **AbstractUser** and add a new field called `name` to store the user's name. We’ll also include the `__str__` method to return the user’s email address for better readability in the admin panel.

```python
# accounts/models.py
from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    name = models.CharField(null=True, blank=True, max_length=100)

    def __str__(self):
        return self.email
```
### 🔧 Step 2: Update `settings.py` for Custom User

Next, we need to tell Django that we’re using our **CustomUser** model. This is done by updating the `AUTH_USER_MODEL` setting.

```python
# django_project/settings.py
AUTH_USER_MODEL = "accounts.CustomUser"  # new
```
### 🗄️ Step 3: Migrate the Custom User Model

To apply the changes in our database, run the following commands:

```bash
python manage.py makemigrations
python manage.py migrate
```
### 👤 Step 4: Create a Superuser

Create a **superuser** account so that we can access Django’s admin interface:

```bash
python manage.py createsuperuser
```

Make sure to include an email for your custom user when prompted.

### 🚀 Step 5: Run the Django Server

Start the Django development server:

```bash
python manage.py runserver
```
### 🛡️ Admin Access

Now, head over to [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) and log in with your superuser credentials. 

If something looks off, don't worry, the next steps will guide you in refining the admin interface.

---

## 🛠 Customizing the Admin for Custom User Model

When you log in to the admin, you might notice that the **Users** section is missing. That’s because we need to customize the way our **CustomUser** model is displayed and managed in the admin.

### Step 1: Create `accounts/forms.py`

To make the **CustomUser** model functional in the admin, we need to define two forms in a new file `accounts/forms.py`. These forms will be used when creating and changing users in the admin.

```python
# accounts/forms.py
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm.Meta):
        model = CustomUser
        fields = UserCreationForm.Meta.fields + ("name",)

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = UserChangeForm.Meta.fields
```
### 📝 Explanation:

- **UserCreationForm**: This form is used when creating new users.
- **UserChangeForm**: This form is used when updating or changing existing users.
- We import our **CustomUser** model and use it in both forms to ensure the custom fields are available.

With these forms, we can now manage users in the admin with our custom fields, such as the `name` field. Next, we'll need to register these forms in the admin, which we will cover in the next steps.

---

## 🛠 Customizing the Admin for Custom User Display

The final step to fully integrate the **CustomUser** model is to update `accounts/admin.py`. This will ensure the **Users** section appears in the admin, and we can properly display and manage custom user fields.

### Step 1: Update `accounts/admin.py`

We need to modify the admin configuration to use the custom user forms and display the new fields like `name` in the user list. Here’s the code to do that:

```python
# accounts/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = [
        "email",
        "username",
        "name",
        "is_staff",
    ]
    fieldsets = UserAdmin.fieldsets + ((None, {"fields": ("name",)}),)
    add_fieldsets = UserAdmin.add_fieldsets + ((None, {"fields": ("name",)}),)

admin.site.register(CustomUser, CustomUserAdmin)
```
### 📝 Explanation:

- We import the **CustomUser** model along with the **CustomUserCreationForm** and **CustomUserChangeForm** we created earlier.
- The `CustomUserAdmin` class customizes how users are displayed in the admin:
  - **list_display**: Specifies the fields that will be shown in the user list (email, username, name, and whether the user is staff).
  - **fieldsets** and **add_fieldsets**: These add our custom `name` field to the existing fields in the user creation and change forms.

### 🎉 Finished!

Once you reload the admin page, the **Users** section will now be visible! You’ll see all users listed, including the superuser you created earlier.

---

## 📝 Creating the Posts App

Now, it's time to set up the core functionality of our Blog by creating a dedicated **Posts** app. Choosing the right name is essential for keeping things clean and simple. While it might be tempting to call the app “blog,” Django automatically adds an "s" in some areas, and "blogs" doesn’t look very appealing. 

Therefore, we’ll call our app **posts** and our model **Post**, which is a cleaner approach.

### 🏗️ Step 1: Create the Posts App

First, stop the local server by pressing `Control+C`, then run the following command to create the **posts** app:

```bash
python manage.py startapp posts
```

### 🔧 Step 2: Update `INSTALLED_APPS`

After creating the app, don't forget to add it to your `INSTALLED_APPS` list in `settings.py` to ensure Django recognizes it.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "accounts",
    "posts",  # new
]
```
That’s it for the setup! You’ve now created the **Posts** app and made sure it’s included in your Django project.

---

## 📝 Creating the Post Model

For our blog, we’ll create a **Post** model with five essential fields:

- **Author**: The user who creates the post.
- **Title**: The title of the blog post.
- **Body**: The main content of the post.
- **Created At**: The timestamp when the post was created.
- **Updated At**: The timestamp when the post was last updated.

Additionally, we’ll use Django's **AUTH_USER_MODEL** to link the post author to the user, and a `__str__` method for easy display of the post’s title.

### 🏗️ Step 1: Define the Post Model

Here’s the model definition in `posts/models.py`:

```python
# posts/models.py
from django.conf import settings
from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=50)
    body = models.TextField()
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
```

### 🛠 Explanation:

- **title**: A short string for the post's title, limited to 50 characters.
- **body**: The main content of the post, stored as text.
- **author**: A ForeignKey that links to the user model, ensuring that each post has an associated author.
- **created_at**: Automatically stores the date and time when the post is created.
- **updated_at**: Automatically updates every time the post is edited.
- **__str__ method**: Returns the post’s title when displayed, making it easier to identify posts in the admin panel.

### 🗄️ Step 2: Update the Database

After defining the model, update the database by creating migrations and applying them:

```bash
python manage.py makemigrations posts
python manage.py migrate
```

This will sync your database with the new **Post** model.That’s it! You’ve successfully created the **Post** model and updated your database.

---

## 🛠 Registering the Post Model in the Admin

To make sure we can easily view and manage our **Post** data in Django’s admin interface, we need to register the **Post** model in `posts/admin.py`.

### 🏗️ Step 1: Update `posts/admin.py`

We’ll register the **Post** model so it shows up in the admin dashboard:

```python
# posts/admin.py
from django.contrib import admin
from .models import Post

admin.site.register(Post)
```

### 🚀 Step 2: Start the Server

Now, start up your local server:

```bash
python manage.py runserver
```

### 🎉 View the Post Model in the Admin

Visit [http://127.0.0.1:8000/admin](http://127.0.0.1:8000/admin) and log in with your superuser credentials to see the **Post** model listed in the admin. You can now add, view, edit, and delete posts directly from the Django admin panel!

---

## 📝 Creating a New Blog Post in the Admin

Now that our **Posts** app is set up in the admin, let’s create a new blog post!

### 🏗️ Step 1: Add a New Blog Post

1. In the admin dashboard, click on the **“+ Add”** button next to **Posts**.
2. You’ll see a form where you can create your post:
   - **Author**: Select your superuser (or another user) from the dropdown list.
   - **Title**: Enter a title for your post.
   - **Body**: Add the content for your post.
3. After filling in the details, click **Save**.

### 🎉 Step 2: View All Blog Posts

Once you save your new blog post, you’ll be redirected to the **Posts** page, which lists all the existing blog posts in your app.

---

## 🧪 Adding Tests for the Posts App

After writing new code, it’s essential to add tests to ensure everything works as expected. We will create tests for the **Post** model to verify that its fields and the `__str__` method work correctly.

### 🏗️ Step 1: Create Tests in `posts/tests.py`

Add the following code to the `posts/tests.py` file:

```python
# posts/tests.py
from django.contrib.auth import get_user_model
from django.test import TestCase
from .models import Post

class BlogTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user(
            username="testuser",
            email="test@email.com",
            password="secret",
        )
        cls.post = Post.objects.create(
            author=cls.user,
            title="A good title",
            body="Nice body content",
        )

    def test_post_model(self):
        self.assertEqual(self.post.author.username, "testuser")
        self.assertEqual(self.post.title, "A good title")
        self.assertEqual(self.post.body, "Nice body content")
        self.assertEqual(str(self.post), "A good title")
```

### 🛠 Explanation:

- **setUpTestData**: This method sets up initial data for the test. It creates a test user and a test post before running the test cases.
- **test_post_model**: This method tests that:
  - The author’s username is correct.
  - The post’s title and body content match the expected values.
  - The `__str__` method returns the correct post title.


### 🚀 Step 2: Run the Tests

To run the tests and ensure everything is working, use the following command:

```bash
python manage.py test
```

### 🎉 Test Output

If the tests are successful, you should see output similar to this:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.105s
OK
Destroying test database for alias 'default'...
```

---
Here’s the README explanation for setting up **Django REST Framework**:

---

## 🌐 Setting Up Django REST Framework

**Django REST Framework (DRF)** makes it easy to transform our database models into a fully functional **RESTful API**. There are three key steps in this process:

1. **urls.py**: Defines the URL routes for our API.
2. **serializers.py**: Converts the data to JSON format.
3. **views.py**: Contains the logic for each API endpoint.

---

### 🛠 Step 1: Install Django REST Framework

First, install Django REST Framework by running the following command:

```bash
pipenv install djangorestframework
```

### 🏗️ Step 2: Update `settings.py`

Next, add **Django REST Framework** to your `INSTALLED_APPS` and configure basic permission settings:

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "rest_framework",  # new
    "accounts",
    "posts",
]

REST_FRAMEWORK = {  # new
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.AllowAny",
    ],
}
```

- **AllowAny**: This setting allows unrestricted access during development, which is useful for testing but not secure for production. We will update the permissions in a later section.

We’ve now set up **Django REST Framework** in our project. Next, we need to create the **URLs**, **serializers**, and **views** for our API.

---

## 🌐 Setting Up API URLs

The first step in exposing our **Blog API** is to define the **URL routes**. These routes determine the location of our API endpoints and how we access them.

### 🛠 Step 1: Update Project-Level `urls.py`

In the project-level `urls.py` file, we need to include the `posts` app’s URLs and create a versioned route for our API.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/", include("posts.urls")),  # new
]
```

#### Why Version the API? 🤔
- **Versioning** helps when you need to make major updates to the API without breaking existing apps or clients that rely on the older version.
- We start with **v1** and can add **v2** later if needed, ensuring smooth transitions.

### 🏗️ Step 2: Create `posts/urls.py`

Now, create a `posts/urls.py` file to define the routes for our **PostList** and **PostDetail** views (which we’ll write in the next section).

```python
# posts/urls.py
from django.urls import path
from .views import PostList, PostDetail

urlpatterns = [
    path("<int:pk>/", PostDetail.as_view(), name="post_detail"),  # View a single post by its ID
    path("", PostList.as_view(), name="post_list"),  # View all posts
]
```

### 📍 Explanation of Routes:

1. **`api/v1/`**: This is the base URL for our API.
   - **`api/v1/`** will list all blog posts.
   - **`api/v1/<int:pk>/`** will display the details of a specific post by its primary key (`pk`).

For example:
- The first blog post will be available at **`api/v1/1/`**.
- The second blog post will be available at **`api/v1/2/`**.

This URL setup gives us the foundation to access both a **list** of blog posts and the **details** of individual posts.

Next, we’ll move on to setting up the **views** and **serializers** for these endpoints!

---

## 📝 Creating Serializers

A **serializer** in Django REST Framework converts our model data into **JSON** format, making it ready for API responses. It also allows us to include or exclude fields, giving us flexibility in controlling the data we expose.

### 🛠 Step 1: Create `posts/serializers.py`

First, create a new file `posts/serializers.py` and define a serializer for the **Post** model.

```python
# posts/serializers.py
from rest_framework import serializers
from .models import Post

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = (
            "id",
            "author",
            "title",
            "body",
            "created_at",
        )
```

### 🛠 Explanation:

- **PostSerializer**: This class converts the **Post** model’s data into **JSON** format.
- **Meta Class**: Here, we define:
  - **model**: The model to serialize, which is `Post`.
  - **fields**: The fields to include in the serialized output:
    - **id**: The unique identifier for each post.
    - **author**: The user who created the post.
    - **title**: The title of the post.
    - **body**: The main content of the post.
    - **created_at**: The timestamp when the post was created.

### Why Exclude Fields? 🛡️
- We excluded the **updated_at** field to demonstrate how easily we can control which fields are exposed. This flexibility allows us to hide sensitive or unnecessary data from the API.

Now that the **PostSerializer** is ready, we can use it to transform our model data into JSON for API responses. In the next step, we'll move on to creating the **views** that will utilize this serializer.

---

## 📝 Creating Views for the Blog API

Now that we’ve set up our serializers, it's time to create the **views**. Django REST Framework provides **generic views** that allow us to easily implement common API patterns, such as listing, creating, reading, updating, and deleting resources.

### 🛠 Step 1: Create `PostList` and `PostDetail` Views

In `posts/views.py`, we’ll create two views:

- **PostList**: Lists all blog posts and allows creating new ones.
- **PostDetail**: Allows reading, updating, or deleting individual blog posts.

```python
# posts/views.py
from rest_framework import generics
from .models import Post
from .serializers import PostSerializer

class PostList(generics.ListCreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
```

### 🛠 Explanation:

- **PostList (ListCreateAPIView)**:
  - This view handles both **GET** and **POST** requests.
  - **GET**: Returns a list of all blog posts.
  - **POST**: Allows creating new blog posts by submitting data.

- **PostDetail (RetrieveUpdateDestroyAPIView)**:
  - This view handles **GET**, **PUT**, **PATCH**, and **DELETE** requests for individual blog posts.
  - **GET**: Retrieves the details of a specific blog post.
  - **PUT/PATCH**: Updates an existing blog post.
  - **DELETE**: Deletes a blog post.

### 🌟 Why Use Generic Views?

Django REST Framework’s generic views make it incredibly easy to create fully functional API endpoints with minimal code. By simply choosing the appropriate view class, you can implement **list**, **create**, **retrieve**, **update**, and **delete** functionality without reinventing the wheel. All of this functionality is built-in, tested, and works seamlessly.

### 🎉 API Is Ready!

Your Blog API is now fully functional with basic **CRUD** operations (Create, Read, Update, Delete). We’ll continue to make improvements, but for now, you can test your API using Django REST Framework's browsable interface.

---

## 🌐 Interacting with the Browsable API

Once our Blog API is set up, we can use Django REST Framework’s **Browsable API** to interact with it directly from a web browser. This feature allows us to **view**, **create**, **update**, and **delete** blog posts easily.

### 🛠 Step 1: Start the Local Server

To begin interacting with the API, start the Django development server:

```bash
python manage.py runserver
```

### 🏗️ Step 2: Access the API Endpoints

#### Post List View

Navigate to the **Post List** endpoint by visiting:

[http://127.0.0.1:8000/api/v1/](http://127.0.0.1:8000/api/v1/)

- You’ll see a list of all blog posts in **JSON** format.
- You can use both **GET** (to view posts) and **POST** (to create new posts) methods directly from the browsable interface.

#### Post Detail View

To view the details of a single post, visit:

[http://127.0.0.1:8000/api/v1/1/](http://127.0.0.1:8000/api/v1/1/)  
(Replace `1` with the **id** of the post you want to view.)

- The **GET**, **PUT**, **PATCH**, and **DELETE** methods are available for each post:
  - **GET**: View the post details.
  - **PUT/PATCH**: Update the post using the form provided.
  - **DELETE**: Delete the post with the click of a button.

### 📝 Example: Editing a Post

1. On the **Post Detail** page, you’ll see a form with the current post details.
2. Add some additional text to the **title** (e.g., “(edited)”).
3. Click the **PUT** button to save the changes.
4. Return to the **Post List** view, and you’ll see the updated post with the new title.

### 🌟 Customizing the API

Django REST Framework’s serializers are powerful and flexible. You can easily customize what fields are displayed in the API (such as showing a user’s **username** instead of just the **id**). For more advanced projects, you may also want to optimize the serializers using **select_related** and **prefetch_related** for performance, especially when dealing with larger datasets.

Your API is now fully interactive through the browsable interface, making it easy to test and work with the data.

---

## 🌐 Configuring CORS for API Access

Since our API might be consumed from a different domain, we need to configure **CORS (Cross-Origin Resource Sharing)**. This allows us to control which domains are permitted to interact with our API, ensuring secure access.

### 🛠 Step 1: Install `django-cors-headers`

First, stop the local server by pressing `Control+C`, and then install the `django-cors-headers` package:

```bash
pipenv install django-cors-headers
```

### 🏗️ Step 2: Update `settings.py`

Next, update the `settings.py` file to add CORS functionality:

1. Add **`corsheaders`** to the `INSTALLED_APPS` list.
2. Include **`CorsMiddleware`** in the `MIDDLEWARE` section.
3. Create a **`CORS_ALLOWED_ORIGINS`** list to specify which domains can access the API.

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
    "rest_framework",
    "corsheaders",  # new
    "accounts",
    "posts",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",  # new
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

# Allow specific domains to access the API
CORS_ORIGIN_WHITELIST = [
    "http://localhost:3000",  # e.g., for React frontend
    "http://localhost:8000",
]

# Allow cross-domain CSRF requests (e.g., from React)
CSRF_TRUSTED_ORIGINS = ["http://localhost:3000"]  # new
```
### 📝 Explanation:

- **CORS_ORIGIN_WHITELIST**: This list specifies which domains are allowed to interact with your API. For example, `localhost:3000` is typically used for React development.
- **CSRF_TRUSTED_ORIGINS**: This setting allows forms from a different domain to send cross-domain requests securely. We’ve set this to the React frontend’s port `3000` for now, but it can be updated later as needed.

### 🔧 Step 3: Commit Changes

Finally, commit your Blog API code:

```bash
git add .
git commit -m "Blog API"
```

### 🎉 Conclusion

Your **Blog API** is now fully functional and ready for local development with CORS configured. This will ensure that your frontend (such as React) can communicate with the API securely. 

However, there’s one issue: anyone can currently update or delete blog posts. In the next section, we’ll implement **permissions** to protect the API.