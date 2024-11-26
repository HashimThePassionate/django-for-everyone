# 📚 Viewsets and Routers ✨

Welcome to the **Viewsets and Routers** section! In this README, we'll simplify and expand on how **Viewsets** and **Routers** in Django REST Framework can accelerate your API development. Get ready to transform your project with less code and more efficiency! 🚀🔧

---

## 📋 Table of Contents

- [📚 Viewsets and Routers ✨](#-viewsets-and-routers-)
  - [📋 Table of Contents](#-table-of-contents)
  - [📝 Introduction](#-introduction)
  - [🔗 User Endpoints](#-user-endpoints)
  - [➕ Adding New Endpoints](#-adding-new-endpoints)
    - [1. Creating the Serializer 🧬](#1-creating-the-serializer-)
    - [2. Creating the Views 👀](#2-creating-the-views-)
    - [3. Defining URL Routes 🌐](#3-defining-url-routes-)
  - [🔄 Implementing Viewsets](#-implementing-viewsets)
    - [Updated `views.py` with Viewsets 📝](#updated-viewspy-with-viewsets-)
  - [🛠️ Setting Up Routers](#️-setting-up-routers)
    - [Updated `urls.py` with Routers 🌍](#updated-urlspy-with-routers-)
  - [🔒 Managing Permissions](#-managing-permissions)
    - [Adding Admin-Only Permissions 🛡️](#adding-admin-only-permissions-️)
  - [🛡️ API User List Admin Only](#️-api-user-list-admin-only)
  - [🎯 Conclusion](#-conclusion)
  - [💾 Git Commit](#-git-commit)

---

## 📝 Introduction

**Viewsets** and **Routers** are **powerful abstractions** in the Django REST Framework that streamline API development. They add an extra layer of organization on top of traditional views and URLs, allowing for:

- **Reduced Code Duplication**: A single viewset can replace multiple related views.
- **Automatic URL Generation**: Routers handle URL routing, saving you from manual URL definitions.
- **Enhanced Readability**: Fewer lines of code make the project easier to manage and understand, especially in larger projects with numerous endpoints.

In this section, we'll **add new API endpoints** to our existing project and demonstrate how transitioning from traditional views and URLs to viewsets and routers can achieve the same functionality with **significantly less code**. 🛠️✨

---

## 🔗 User Endpoints

Currently, our project includes the following **API endpoints** (all prefixed with `api/v1/` for simplicity):

| **Endpoint**                     | **HTTP Verb** |
|----------------------------------|---------------|
| `/`                              | GET           |
| `/:pk/`                          | GET           |
| `/rest-auth/registration`        | POST          |
| `/rest-auth/login`               | POST          |
| `/rest-auth/logout`              | GET           |
| `/rest-auth/password/reset`      | POST          |
| `/rest-auth/password/reset/confirm` | POST        |

- **Custom Endpoints**: The first two endpoints (`/` and `/:pk/`) are created by us.
- **Provided by `dj-rest-auth`**: The remaining five endpoints are provided by the `dj-rest-auth` package.

Now, let's **extend our API** by adding two more endpoints to **list all users** and **view individual users**. This is a common feature in many APIs and will illustrate the benefits of using viewsets and routers. 🧑‍💻👩‍💻

---

## ➕ Adding New Endpoints

To add new endpoints, follow these **three essential steps**:

1. **Create a new serializer class for the model** 🧬
2. **Create new views for each endpoint** 👀
3. **Define new URL routes for each endpoint** 🌐

Let's explore each step in detail.

### 1. Creating the Serializer 🧬

**Serializers** convert complex data types (like Django models) to native Python data types that can then be easily rendered into JSON, XML, or other content types.

**Steps:**

1. **Import the `CustomUser` model** using `get_user_model` to ensure compatibility with both default and custom user models.
2. **Create a `UserSerializer` class** that specifies which fields to include.

**Code:**

```python
# posts/serializers.py
from django.contrib.auth import get_user_model  # 🛠️ Importing the user model
from rest_framework import serializers
from .models import Post

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ("id", "author", "title", "body", "created_at",)

class UserSerializer(serializers.ModelSerializer):  # ✨ New Serializer
    class Meta:
        model = get_user_model()  # 🛡️ Ensures correct user model is referenced
        fields = ("id", "username",)
```

**Explanation:**

- **`get_user_model()`**: This function dynamically retrieves the current user model, accommodating any custom user models you might have.
- **`UserSerializer`**: This serializer includes the `id` and `username` fields of the user, making it suitable for listing users and viewing individual user details.

### 2. Creating the Views 👀

**Views** handle the logic of your application and dictate how data is presented or manipulated.

**Steps:**

1. **Import necessary modules and serializers**.
2. **Define `UserList` and `UserDetail` classes** using generic views provided by Django REST Framework.

**Code:**

```python
# posts/views.py
from django.contrib.auth import get_user_model  # 🛠️ Importing the user model
from rest_framework import generics
from .models import Post
from .permissions import IsAuthorOrReadOnly
from .serializers import PostSerializer, UserSerializer  # 📦 Importing serializers

class PostList(generics.ListCreateAPIView):
    permission_classes = (IsAuthorOrReadOnly,)  # 🔒 Permission setup
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthorOrReadOnly,)  # 🔒 Permission setup
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class UserList(generics.ListCreateAPIView):  # ➕ New View
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer

class UserDetail(generics.RetrieveUpdateDestroyAPIView):  # ➕ New View
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer
```

**Explanation:**

- **`ListCreateAPIView`**: Handles listing all objects and creating new ones.
- **`RetrieveUpdateDestroyAPIView`**: Handles retrieving, updating, and deleting a single object.
- **`UserList` and `UserDetail`**: These classes provide endpoints to list all users and view individual user details, respectively.

### 3. Defining URL Routes 🌐

**URL Routes** map URLs to the corresponding views, enabling clients to interact with your API.

**Steps:**

1. **Import the new views** (`UserList` and `UserDetail`).
2. **Add URL patterns** for the new user endpoints.

**Code:**

```python
# posts/urls.py
from django.urls import path
from .views import PostList, PostDetail, UserList, UserDetail  # 📦 Importing views

urlpatterns = [
    path("users/", UserList.as_view()),  # ➕ New User List Endpoint
    path("users/<int:pk>/", UserDetail.as_view()),  # ➕ New User Detail Endpoint
    path("", PostList.as_view()),
    path("<int:pk>/", PostDetail.as_view()),
]
```

**Explanation:**

- **`"users/"`**: Maps to the `UserList` view, allowing users to be listed or created.
- **`"users/<int:pk>/"`**: Maps to the `UserDetail` view, allowing retrieval, updating, or deletion of a specific user by their primary key (`pk`).

**Result:**

After implementing these changes, your user list endpoint will be accessible at:

```
http://127.0.0.1:8000/api/v1/users/
```

---

## 🔄 Implementing Viewsets

**Viewsets** are a way to combine the logic for multiple related views into a single class. Instead of having separate classes for listing and detailing, a viewset can handle all these actions, reducing code duplication and simplifying your codebase. 🧩✨

### Updated `views.py` with Viewsets 📝

**Code:**

```python
# posts/views.py
from django.contrib.auth import get_user_model  # 🛠️ Importing the user model
from rest_framework import viewsets  # 📦 Importing viewsets
from .models import Post
from .permissions import IsAuthorOrReadOnly
from .serializers import PostSerializer, UserSerializer

class PostViewSet(viewsets.ModelViewSet):  # 🌟 New ViewSet
    permission_classes = (IsAuthorOrReadOnly,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class UserViewSet(viewsets.ModelViewSet):  # 🌟 New ViewSet
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer
```

**Explanation:**

- **`viewsets.ModelViewSet`**: Provides default implementations for standard actions (list, create, retrieve, update, destroy).
- **`PostViewSet` and `UserViewSet`**: These viewsets replace the individual view classes (`PostList`, `PostDetail`, `UserList`, `UserDetail`), encapsulating all related logic within single classes.
- **Benefits**:
  - **Less Code**: Reduces the number of classes you need to maintain.
  - **Consistency**: Ensures a uniform approach to handling different actions.

---

## 🛠️ Setting Up Routers

**Routers** work in tandem with viewsets to automatically generate URL patterns, eliminating the need to manually define each route. This not only saves time but also ensures consistency across your API endpoints. 🌐🔄

### Updated `urls.py` with Routers 🌍

**Code:**

```python
# posts/urls.py
from django.urls import path
from rest_framework.routers import SimpleRouter  # 📦 Importing SimpleRouter
from .views import UserViewSet, PostViewSet  # 📦 Importing ViewSets

router = SimpleRouter()  # 🛠️ Initializing the router
router.register("users", UserViewSet, basename="users")  # ➕ Registering UserViewSet
router.register("", PostViewSet, basename="posts")  # ➕ Registering PostViewSet

urlpatterns = router.urls  # 🔗 Setting URL patterns to the router's URLs
```

**Explanation:**

- **`SimpleRouter`**: A built-in router that automatically creates the necessary URL patterns for the registered viewsets.
- **`router.register`**:
  - **First Argument**: The prefix for the URL (e.g., `"users"`).
  - **Second Argument**: The viewset class to register.
  - **`basename`**: A base name to use for the URL names.
- **`urlpatterns = router.urls`**: Assigns the router-generated URLs to the `urlpatterns` list, replacing manual URL definitions.

**Benefits:**

- **Automation**: Automatically generates URLs for all actions in the viewset.
- **Simplicity**: Reduces the need for repetitive URL patterns.
- **Scalability**: Easily accommodates additional viewsets without modifying the URL configuration.

**Result:**

After setting up the routers, your endpoints are accessible as before:

- **User List:** `http://127.0.0.1:8000/api/v1/users/`
- **User Detail:** `http://127.0.0.1:8000/api/v1/users/1/`

Additionally, the detail view now includes built-in options like `delete`, thanks to the `ModelViewSet`.

---

## 🔒 Managing Permissions

**Permissions** are crucial for securing your API, ensuring that only authorized users can access or modify certain resources. With viewsets and routers, managing permissions becomes more streamlined. 🛡️🔑

### Adding Admin-Only Permissions 🛡️

To **restrict access** to user-related endpoints to **superusers only**, follow these steps:

1. **Import `IsAdminUser`** from Django REST Framework's permissions.
2. **Set `permission_classes`** for the `UserViewSet` to `[IsAdminUser]`.

**Code:**

```python
# posts/views.py
from django.contrib.auth import get_user_model  # 🛠️ Importing the user model
from rest_framework import viewsets
from rest_framework.permissions import IsAdminUser  # 🛡️ Importing IsAdminUser
from .models import Post
from .permissions import IsAuthorOrReadOnly
from .serializers import PostSerializer, UserSerializer

class PostViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthorOrReadOnly,)  # 🔒 Existing Permission
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class UserViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAdminUser]  # 🔒 New Admin-Only Permission
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer
```

**Explanation:**

- **`IsAdminUser`**: A permission class that allows access only to users with admin privileges (`is_staff=True`).
- **`permission_classes`**:
  - **`PostViewSet`**: Uses `IsAuthorOrReadOnly`, allowing authors to edit their posts while others can only read.
  - **`UserViewSet`**: Now uses `IsAdminUser`, ensuring that only admin users can access user-related endpoints.

**Outcome:**

With these changes:

- **Non-Admin Users**: Will receive a **403 Forbidden** response when attempting to access user endpoints.
- **Admin Users**: Will have full access to list, view, create, update, and delete users.

**Security Note:**

It's essential to **always manage permissions carefully**, especially when dealing with sensitive data like user information. Ensuring that only authorized personnel can perform certain actions helps maintain the integrity and security of your application. 🔐✨

---

## 🛡️ API User List Admin Only

With the **admin-only permissions** in place, here's how your API behaves:

- **User List Endpoint:**
  - **URL:** `http://127.0.0.1:8000/api/v1/users/`
  - **Access:**
    - **Admin Users:** Can **view** and **manage** users.
    - **Non-Admin Users:** **Access Denied** (403 Forbidden).

- **User Detail Endpoint:**
  - **URL:** `http://127.0.0.1:8000/api/v1/users/1/`
  - **Access:**
    - **Admin Users:** Can **view**, **update**, and **delete** individual users.
    - **Non-Admin Users:** **Access Denied** (403 Forbidden).

**Visual Representation:**

| **Endpoint**                    | **Admin Access** | **Non-Admin Access** |
|---------------------------------|-------------------|-----------------------|
| `/api/v1/users/`                | ✅ Allowed        | ❌ Denied             |
| `/api/v1/users/<int:pk>/`       | ✅ Allowed        | ❌ Denied             |

**Benefits:**

- **Enhanced Security:** Protects user data from unauthorized access.
- **Clear Access Control:** Easily distinguish between admin and non-admin capabilities.
- **Maintainability:** Centralized permission management simplifies future updates.

**Recommendation:**

Always start with **restrictive permissions** at the project level and **open up access** as needed per endpoint. Regularly **audit your endpoints** to ensure no unintended access is granted. 🔍🔐

---

## 🎯 Conclusion

**Viewsets** and **Routers** are **game-changers** in Django REST Framework, offering a **streamlined** and **efficient** approach to managing API endpoints. Here's a quick recap of their advantages:

- **Reduced Code Duplication:** One viewset replaces multiple views.
- **Automatic URL Generation:** Routers handle URL routing, saving time and minimizing errors.
- **Enhanced Readability:** A cleaner codebase that's easier to maintain and understand.
- **Scalability:** Easily add new endpoints without extensive modifications.

**Key Takeaways:**

1. **Start Simple:** Begin with traditional views and URLs to understand the basics.
2. **Transition to Viewsets and Routers:** As your API grows and patterns become repetitive, adopt viewsets and routers for better efficiency.
3. **Manage Permissions Carefully:** Always ensure your endpoints are secured with appropriate permissions to protect sensitive data.

While there's an **initial learning curve**, the long-term benefits in **code maintainability** and **development speed** are well worth the effort. Embrace viewsets and routers to keep your Django REST Framework projects **clean**, **efficient**, and **scalable**! 🌟🚀

---

## 💾 Git Commit

After implementing these changes, it's crucial to **commit your work** to version control to keep track of your progress and ensure that your changes are safely stored.

**Steps:**

1. **Check the current status** of your Git repository.
2. **Stage all changes** for commit.
3. **Commit** with a meaningful message.

**Commands:**

```bash
git status -s  # 🔍 Check current status
git add .   # ➕ Stage all changes
git commit -m "Viewsets and Routers"  # 💬 Commit with message
```

**Explanation:**

- **`git status`**: Shows the status of changes in your working directory.
- **`git add .`**: Stages all changes (new files, modifications, deletions) for the next commit.
- **`git commit -m "ViewSets And Routers"`**: Commits the staged changes with a descriptive message.

**Best Practices:**

- **Meaningful Commit Messages:** Clearly describe what changes were made and why.
- **Frequent Commits:** Commit regularly to track progress and make it easier to manage changes.
- **Branching:** Use branches to work on new features or fixes without affecting the main codebase.
