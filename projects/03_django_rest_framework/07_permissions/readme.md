# 🔒 Permissions and Rate Limiting in DRF 🛡️

## 📑 Table of Contents

- [🔒 Permissions and Rate Limiting in DRF 🛡️](#-permissions-and-rate-limiting-in-drf-️)
  - [📑 Table of Contents](#-table-of-contents)
  - [🌟 Importance of Permissions](#-importance-of-permissions)
  - [🔹 Understanding Permissions in DRF](#-understanding-permissions-in-drf)
  - [🔹 Project-Level Permissions 🏢](#-project-level-permissions-)
    - [🛠️ Configuring Project-Level Permissions](#️-configuring-project-level-permissions)
    - [🔐 Built-In Permission Classes](#-built-in-permission-classes)
    - [🔄 Implementing a Permission Class](#-implementing-a-permission-class)
  - [🧑‍🤝‍🧑 Creating New Users](#-creating-new-users)
    - [📝 Methods to Create a New User](#-methods-to-create-a-new-user)
    - [🖥️ Admin Add User Page](#️-admin-add-user-page)
    - [🛡️ Admin User Change Page](#️-admin-user-change-page)
    - [👥 Viewing Users](#-viewing-users)
  - [🔗 Adding Log In and Log Out Links](#-adding-log-in-and-log-out-links)
    - [🛠️ Updating URLconf](#️-updating-urlconf)
    - [🔄 Testing the Authentication Links](#-testing-the-authentication-links)
  - [👁️ View-Level Permissions](#️-view-level-permissions)
    - [🛠️ Implementing View-Level Permissions](#️-implementing-view-level-permissions)
    - [🔄 Testing View-Level Permissions](#-testing-view-level-permissions)
    - [🔄 Reverting to Project-Level Permissions](#-reverting-to-project-level-permissions)
  - [🎨 Creating Custom Permissions](#-creating-custom-permissions)
    - [🛠️ Creating a Custom Permission Class](#️-creating-a-custom-permission-class)
    - [🔍 Breaking Down the Custom Permission](#-breaking-down-the-custom-permission)
    - [🛠️ Applying the Custom Permission](#️-applying-the-custom-permission)
    - [🔄 Testing Custom Permissions](#-testing-custom-permissions)
  - [⏳ API Rate Limiting (Throttling) ⏳](#-api-rate-limiting-throttling-)
    - [🌟 Why Implement Rate Limiting?](#-why-implement-rate-limiting)
    - [🔹 Understanding DRF's Throttling Classes](#-understanding-drfs-throttling-classes)
    - [🛠️ Configuring Throttling in `settings.py`](#️-configuring-throttling-in-settingspy)
    - [🔄 Testing Throttling](#-testing-throttling)
    - [🔹 Custom Throttling](#-custom-throttling)
    - [🛠️ Creating a Custom Throttle Class](#️-creating-a-custom-throttle-class)
    - [🔹 Custom Throttling For specific time](#-custom-throttling-for-specific-time)
      - [🛠️ Creating a Custom Throttle Class](#️-creating-a-custom-throttle-class-1)
    - [🔄 Applying Custom Throttle to Specific Views](#-applying-custom-throttle-to-specific-views)
    - [🔄 Testing Custom Throttle](#-testing-custom-throttle)
    - [💡 Best Practices for Throttling](#-best-practices-for-throttling)
  - [📦 Committing Changes to Git 📦](#-committing-changes-to-git-)
    - [🛠️ Git Commands](#️-git-commands)
  - [🎯 Conclusion](#-conclusion)

---

## 🌟 Importance of Permissions

**Security** is a critical aspect of any web application, but it becomes **doubly important** when dealing with web APIs. Without proper permissions, your API can become a playground for malicious users. For instance, an anonymous user could potentially create, read, update, or delete any blog post, including those they did not author. This level of unrestricted access is **extremely dangerous** and must be addressed immediately.

## 🔹 Understanding Permissions in DRF

**Django REST Framework** comes with several **built-in permissions** that help secure your API. These permissions can be applied at different levels:

1. **Project-Level Permissions** 🏢
2. **View-Level Permissions** 👁️
3. **Model-Level Permissions** 🗂️ *(Note: This section can be expanded based on your project's requirements)*

Additionally, you can create **Custom Permissions** to meet specific requirements. By the end of this section, you'll learn how to create a custom permission that allows only the **author of a blog post** to update or delete it.

---

## 🔹 Project-Level Permissions 🏢

**Project-Level Permissions** apply to your entire API project. DRF provides a set of permission classes that you can configure in your project's settings. Here's how you can set them up:

### 🛠️ Configuring Project-Level Permissions

1. **Locate Your Settings File**:
   Open your `django_project/settings.py` file.

2. **Update REST_FRAMEWORK Settings**:
   Add or update the `DEFAULT_PERMISSION_CLASSES` within the `REST_FRAMEWORK` dictionary. For example:

   ```python
   # django_project/settings.py
   REST_FRAMEWORK = {
       "DEFAULT_PERMISSION_CLASSES": [
           "rest_framework.permissions.AllowAny",  # Default setting
       ],
   }
   ```

### 🔐 Built-In Permission Classes

DRF offers four **built-in project-level permission** settings:

1. **AllowAny** 🌍
   - **Description**: Grants full access to any user, whether authenticated or not.
   - **Use Case**: Public APIs where data is meant to be openly accessible.

2. **IsAuthenticated** 🔑
   - **Description**: Only authenticated (logged-in) users can access the API.
   - **Use Case**: APIs that require user authentication to view or modify data.

3. **IsAdminUser** 🛡️
   - **Description**: Only admin or superuser accounts can access the API.
   - **Use Case**: Administrative APIs that should be restricted to site administrators.

4. **IsAuthenticatedOrReadOnly** 📖
   - **Description**: Allows read-only access to unauthenticated users, but restricts write actions to authenticated users.
   - **Use Case**: APIs where data can be viewed publicly, but modifications require user authentication.

### 🔄 Implementing a Permission Class

To switch the permission class to **IsAuthenticated**, update your `settings.py` as follows:

```python
# django_project/settings.py
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",  # Updated permission
    ],
}
```

**Testing the Change**:

1. **Refresh Your Browser**:
   If you’re logged in as a superuser, nothing changes immediately because superusers have access by default.

2. **Log Out**:
   - Navigate to the admin site at `http://127.0.0.1:8000/admin/`.
   - Click the “Log Out” link in the upper right corner.

3. **Access the API**:
   - Go to `http://127.0.0.1:8000/api/v1/`.
   - You should see an **HTTP 403 Forbidden** error, indicating that unauthenticated access is denied. ✅

---

## 🧑‍🤝‍🧑 Creating New Users

To test permissions effectively, you need to create regular users (non-admin) who can access the API based on the permissions you've set.

### 📝 Methods to Create a New User

1. **Using the Command Shell**:
   ```bash
   python manage.py createsuperuser
   ```
   - Follow the prompts to create a new superuser.

2. **Using the Admin Interface**:
   - Navigate to `http://127.0.0.1:8000/admin/`.
   - Log in with your superuser credentials.
   - Click on **“+ Add”** next to **Users**.
   - Enter a **username** and **password** for the new user (e.g., `testuser`).
   - Click **“Save”**.

### 🖥️ Admin Add User Page

- **Name Field**: Available but not required due to a custom user model.
- **Additional Information**: Optional fields like first name, last name, email address, etc.

### 🛡️ Admin User Change Page

- **Save the New User**:
  - Scroll down and click the **“Save”** button.
  - You will be redirected back to the main Users page at `http://127.0.0.1:8000/admin/auth/user/`.

### 👥 Viewing Users

- **Staff Status**: Only one account shows as a superuser.
- **Log Out**: Click the **“Log Out”** link in the upper right corner to exit the admin interface.

---

## 🔗 Adding Log In and Log Out Links

To allow users to log in and out of the browsable API, update your project's URL configuration.

### 🛠️ Updating URLconf

1. **Open `urls.py`**:
   Navigate to `django_project/urls.py`.

2. **Add the Authentication Path**:
   Update the `urlpatterns` to include the `api-auth` path.

   ```python
   # django_project/urls.py
   from django.contrib import admin
   from django.urls import path, include

   urlpatterns = [
       path("admin/", admin.site.urls),
       path("api/v1/", include("posts.urls")),
       path("api-auth/", include("rest_framework.urls")),  # New authentication path
   ]
   ```

### 🔄 Testing the Authentication Links

1. **Navigate to the Browsable API**:
   Go to `http://127.0.0.1:8000/api/v1/`.

2. **Log In Link**:
   - A **“Log in”** link appears in the upper right corner.
   - Click it to log in using the new `testuser` account.

3. **Post Login**:
   - After logging in, you'll see the `testuser` name in the upper right corner with a **“Log out”** link in the dropdown menu.

---

## 👁️ View-Level Permissions

**View-Level Permissions** allow you to apply permissions to specific API views for more granular control. For example, you might want only admin users to access certain endpoints.

### 🛠️ Implementing View-Level Permissions

1. **Open `views.py`**:
   Navigate to `posts/views.py`.

2. **Import Permissions**:
   ```python
   from rest_framework import generics, permissions  # New import
   from .models import Post
   from .serializers import PostSerializer
   ```

3. **Update `PostDetail` View**:
   Apply the `IsAdminUser` permission to restrict access.

   ```python
   # posts/views.py
   class PostList(generics.ListCreateAPIView):
       queryset = Post.objects.all()
       serializer_class = PostSerializer

   class PostDetail(generics.RetrieveUpdateDestroyAPIView):
       permission_classes = (permissions.IsAdminUser,)  # Apply admin-only permission
       queryset = Post.objects.all()
       serializer_class = PostSerializer
   ```

### 🔄 Testing View-Level Permissions

1. **Refresh the Browsable API**:
   - Go to `http://127.0.0.1:8000/api/v1/`.
   - The **Post List** page remains accessible.

2. **Access Post Detail Page**:
   - Navigate to `http://127.0.0.1:8000/api/v1/1/`.
   - An **HTTP 403 Forbidden** error appears, indicating restricted access.

3. **Log In as Admin**:
   - Log out and log back in with your admin credentials.
   - Accessing the Post Detail page should now be possible.

### 🔄 Reverting to Project-Level Permissions

If you prefer to **restrict access to authenticated users** rather than admin users, remove the `permission_classes` field from `PostDetail` and rely on the **project-level permissions** set in `settings.py`.

---

## 🎨 Creating Custom Permissions

While DRF provides robust built-in permissions, sometimes you need **custom permissions** tailored to your specific needs. For example, allowing only the **author of a blog post** to edit or delete it.

### 🛠️ Creating a Custom Permission Class

1. **Create `permissions.py`**:
   In your `posts` app, create a new file named `permissions.py`.

2. **Define the Custom Permission**:
   ```python
   # posts/permissions.py
   from rest_framework import permissions

   class IsAuthorOrReadOnly(permissions.BasePermission):
       """
       Custom permission to only allow authors of a post to edit or delete it.
       """

       def has_permission(self, request, view):
           # Allow access only to authenticated users
           if request.user.is_authenticated:
               return True
           return False

       def has_object_permission(self, request, view, obj):
           # Allow read-only access for any request
           if request.method in permissions.SAFE_METHODS:
               return True

           # Write permissions are only allowed to the author of the post
           return obj.author == request.user
   ```

### 🔍 Breaking Down the Custom Permission

- **Class Definition**:
  - `IsAuthorOrReadOnly` inherits from `permissions.BasePermission`.

- **`has_permission` Method**:
  - Checks if the user is **authenticated**.
  - Returns `True` if authenticated, allowing access to the view.
  - Returns `False` otherwise, denying access.

- **`has_object_permission` Method**:
  - **Read-Only Access**:
    - Allows **GET**, **HEAD**, or **OPTIONS** requests for any user.
  - **Write Access**:
    - Only permits **POST**, **PUT**, **PATCH**, or **DELETE** requests if the **user is the author** of the post (`obj.author == request.user`).

### 🛠️ Applying the Custom Permission

1. **Update `views.py`**:
   ```python
   # posts/views.py
   from rest_framework import generics
   from .models import Post
   from .permissions import IsAuthorOrReadOnly  # Import the custom permission
   from .serializers import PostSerializer

   class PostList(generics.ListCreateAPIView):
       permission_classes = (IsAuthorOrReadOnly,)  # Apply custom permission
       queryset = Post.objects.all()
       serializer_class = PostSerializer

   class PostDetail(generics.RetrieveUpdateDestroyAPIView):
       permission_classes = (IsAuthorOrReadOnly,)  # Apply custom permission
       queryset = Post.objects.all()
       serializer_class = PostSerializer
   ```

### 🔄 Testing Custom Permissions

1. **Create a New Blog Post**:
   - Log in as a **superuser** and create a new post with `testuser` as the author.

2. **Accessing the Post Detail Page**:
   - Navigate to `http://127.0.0.1:8000/api/v1/2/` (assuming the new post has ID 2).

3. **Log In as `testuser`**:
   - Log out of the superuser account.
   - Log in with the `testuser` account.

4. **Verify Permissions**:
   - **Edit/Delete Own Post**: `testuser` can **edit** or **delete** their own post.
   - **Edit/Delete Others' Posts**: Attempting to edit or delete a post not authored by `testuser` will result in an **HTTP 403 Forbidden** error.

5. **Log Out**:
   - Log out from the `testuser` account.
   - Verify that unauthenticated users cannot access any API endpoints, resulting in **HTTP 403 Forbidden** errors.

---

## ⏳ API Rate Limiting (Throttling) ⏳

In addition to setting up permissions, it's essential to manage how your APIs are used to prevent abuse and ensure fair usage among all users. **API Rate Limiting**, also known as **Throttling**, allows you to control the number of requests a user can make to your API within a certain timeframe. This helps protect your API from excessive use and potential denial-of-service (DoS) attacks. Let's explore how to implement and configure throttling in DRF! 🚦

### 🌟 Why Implement Rate Limiting?

- **Prevent Abuse**: Stops malicious users from overwhelming your API with too many requests.
- **Ensure Fair Usage**: Guarantees that all users have equitable access to your API resources.
- **Optimize Performance**: Helps maintain the responsiveness and reliability of your API by controlling the load.

### 🔹 Understanding DRF's Throttling Classes

DRF provides several built-in throttling classes that you can use out of the box:

1. **AnonRateThrottle** 🌐
   - **Description**: Limits the rate of requests from anonymous (unauthenticated) users.
   - **Default Rate**: `100/day` *(can be customized)*.

2. **UserRateThrottle** 👤
   - **Description**: Limits the rate of requests from authenticated users.
   - **Default Rate**: `1000/day` *(can be customized)*.

3. **ScopedRateThrottle** 🔒
   - **Description**: Allows different throttling rates for different parts of your API by defining scopes.
   - **Use Case**: Useful for APIs with varying levels of access requirements.

### 🛠️ Configuring Throttling in `settings.py`

1. **Open `settings.py`**:
   Navigate to `django_project/settings.py`.

2. **Add Throttling Settings**:
   Update the `REST_FRAMEWORK` dictionary to include throttling configurations.

   ```python
   # django_project/settings.py
   REST_FRAMEWORK = {
       "DEFAULT_PERMISSION_CLASSES": [
           "rest_framework.permissions.IsAuthenticated",
       ],
       "DEFAULT_THROTTLE_CLASSES": [
           "rest_framework.throttling.AnonRateThrottle",  # Throttle for anonymous users
           "rest_framework.throttling.UserRateThrottle",  # Throttle for authenticated users
       ],
       "DEFAULT_THROTTLE_RATES": {
           "anon": "100/day",      # 100 requests per day for anonymous users
           "user": "1000/day",     # 1000 requests per day for authenticated users
       },
   }
   ```

### 🔄 Testing Throttling

1. **Make Multiple Requests**:
   - Use a tool like **Postman** or **cURL** to send multiple requests to your API endpoints.
   - For example, send 101 requests as an anonymous user to an endpoint.

2. **Observe Throttling in Action**:
   - After exceeding the limit, you'll receive an **HTTP 429 Too Many Requests** error.

3. **Adjust Throttling Rates**:
   - Modify the `DEFAULT_THROTTLE_RATES` in `settings.py` to suit your application's needs.
   - Example: Change `"anon": "50/day"` to reduce the allowed requests for anonymous users.

### 🔹 Custom Throttling

Sometimes, the built-in throttling classes may not fit your specific requirements. DRF allows you to create **custom throttling classes** by extending `rest_framework.throttling.BaseThrottle`.

### 🛠️ Creating a Custom Throttle Class

1. **Create `throttling.py`**:
   In your `posts` app, create a new file named `throttling.py`.

2. **Define the Custom Throttle**:
   ```python
   # posts/throttling.py
   from rest_framework.throttling import UserRateThrottle

   class BurstRateThrottle(UserRateThrottle):
       scope = 'burst'

       def get_cache_key(self, request, view):
           if not request.user.is_authenticated:
               return None  # Throttle only authenticated users
           return super().get_cache_key(request, view)
   ```

3. **Applying Custom Throttle to Specific Views**:
```python
   # posts/views.py
from rest_framework import generics, permissions
from .models import Post
from .serializers import PostSerializer
from .permissions import IsAuthorOrReadOnly   
from .throttling import  BurstRateThrottle

class PostList(generics.ListCreateAPIView):
    permission_classes = (IsAuthorOrReadOnly,) 
    throttle_classes = (BurstRateThrottle,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer
...
```
4. **Update `settings.py`**:
   Add the new throttle rate under `DEFAULT_THROTTLE_RATES`.

   ```python
   # django_project/settings.py
   REST_FRAMEWORK = {
       "DEFAULT_PERMISSION_CLASSES": [
           "rest_framework.permissions.IsAuthenticated",
       ],
       "DEFAULT_THROTTLE_CLASSES": [
           "rest_framework.throttling.AnonRateThrottle",
           "rest_framework.throttling.UserRateThrottle",
           "posts.throttling.BurstRateThrottle",  # Custom throttle
       ],
       "DEFAULT_THROTTLE_RATES": {
           "anon": "100/day",
           "user": "1000/day",
           "burst": "10/minute",  # Additional rate for burst requests
       },
   }
   ```

### 🔹 Custom Throttling For specific time 
> [Understand Rate Limit in Detail](./posts/rate-limiting.md)

Sometimes, the built-in throttling classes may not fit your specific requirements. DRF allows you to create **custom throttling classes** by extending `rest_framework.throttling.SimpleRateThrottle` or `rest_framework.throttling.UserRateThrottle`.

#### 🛠️ Creating a Custom Throttle Class

1. **Create `throttling.py`**:
   In your `posts` app, create a new file named `throttling.py`.

2. **Define the Custom Throttle**:
   ```python
   # posts/throttling.py
   from rest_framework.throttling import SimpleRateThrottle
   from django.core.exceptions import ImproperlyConfigured

   class FivePerFiveMinuteThrottle(SimpleRateThrottle):
       scope = 'five_per_five_minute'

       def parse_rate(self, rate):
           """
           Override the parse_rate method to handle rates like '5/5m'.
           """
           try:
               num, period = rate.split('/')
               num = int(num)

               # Extract the numeric part and the unit from the period
               duration_number = int(period[:-1])
               duration_unit = period[-1]

               # Map the unit to seconds
               duration_mapping = {
                   's': 1,
                   'm': 60,
                   'h': 3600,
                   'd': 86400,
               }

               if duration_unit not in duration_mapping:
                   raise ValueError(f"Invalid duration unit: {duration_unit}")

               duration = duration_mapping[duration_unit] * duration_number
               return (num, duration)
           except (ValueError, KeyError) as e:
               raise ImproperlyConfigured(
                   f"Invalid throttle rate '{rate}'. Expected format '<number>/<duration>', e.g., '5/5m'. Error: {e}"
               )

       def get_cache_key(self, request, view):
           """
           Generate a unique cache key based on the user's unique identifier.
           """
           if not request.user.is_authenticated:
               return None  # Only throttle authenticated users

           ident = self.get_ident(request)  # Typically the user's ID or IP
           return self.cache_format % {
               'scope': self.scope,
               'ident': ident
           }
   ```

   **Explanation**:
   - **Class Definition**: `FivePerFiveMinuteThrottle` inherits from `SimpleRateThrottle`.
   - **`parse_rate` Method**:
     - Customizes the rate parsing to handle rates like `'5/5m'` (5 requests per 5 minutes).
     - Maps duration units (`s`, `m`, `h`, `d`) to seconds.
   - **`get_cache_key` Method**:
     - Generates a unique cache key based on the authenticated user's identifier.
     - Returns `None` for unauthenticated users, effectively skipping throttling for them.

3. **Create `exceptions.py`**:
   To provide a friendly error message when throttling occurs, create a custom exception handler.

   ```python
   # posts/exceptions.py
   from rest_framework.views import exception_handler
   from rest_framework.exceptions import Throttled

   def custom_exception_handler(exc, context):
       # Call DRF's default exception handler first
       response = exception_handler(exc, context)

       # If the exception is a Throttled exception, customize the response
       if isinstance(exc, Throttled):
           wait_seconds = exc.wait
           wait_minutes = wait_seconds // 60
           wait_seconds = wait_seconds % 60
           wait_time = ""
           if wait_minutes > 0:
               wait_time += f"{wait_minutes} minute(s) "
           wait_time += f"{wait_seconds} second(s)"
           
           # Update the response data with a friendly message
           response.data = {
               "detail": f"Too many requests. Please try again in {wait_time}."
           }

       return response
   ```

   **Explanation**:
   - **Custom Exception Handler**:
     - Checks if the exception is a `Throttled` exception.
     - Formats the wait time into minutes and seconds.
     - Provides a user-friendly error message indicating when they can retry.

4. **Update `settings.py`**:
   Include the custom throttle class and exception handler in your settings.

   ```python
   # django_project/settings.py
   REST_FRAMEWORK = {
       "DEFAULT_PERMISSION_CLASSES": [
           "rest_framework.permissions.IsAuthenticated",
       ],
       "DEFAULT_THROTTLE_CLASSES": [
           "rest_framework.throttling.AnonRateThrottle",
           "rest_framework.throttling.UserRateThrottle",
           "posts.throttling.FivePerFiveMinuteThrottle",  # Custom throttle
       ],
       "DEFAULT_THROTTLE_RATES": {
           "anon": "2/day",                  # Example: 2 requests per day for anonymous users
           "user": "5/day",                  # Example: 5 requests per day for authenticated users
           "five_per_five_minute": "5/5m",   # 5 requests per 5 minutes
       },
       "EXCEPTION_HANDLER": "posts.exceptions.custom_exception_handler",  # Custom exception handler
   }
   ```

---

### 🔄 Applying Custom Throttle to Specific Views

1. **Open `views.py`**:
   Navigate to `posts/views.py`.

2. **Apply Throttle Classes**:
   Update your views to include the custom throttle.

   ```python
   # posts/views.py
   from rest_framework import generics
   from .models import Post
   from .permissions import IsAuthorOrReadOnly
   from .serializers import PostSerializer
   from .throttling import FivePerFiveMinuteThrottle  # Import custom throttle

   class PostList(generics.ListCreateAPIView):
       permission_classes = (IsAuthorOrReadOnly,)
       throttle_classes = (FivePerFiveMinuteThrottle,)  # Apply custom throttle
       queryset = Post.objects.all()
       serializer_class = PostSerializer

   class PostDetail(generics.RetrieveUpdateDestroyAPIView):
       permission_classes = (IsAuthorOrReadOnly,)
       throttle_classes = (FivePerFiveMinuteThrottle,)  # Apply custom throttle
       queryset = Post.objects.all()
       serializer_class = PostSerializer
   ```

---

### 🔄 Testing Custom Throttle

1. **Make Multiple Requests**:
   - Use a tool like **Postman** or **cURL** to send multiple requests to your API endpoints.
   - For example, send **6 requests** as an authenticated user within **5 minutes**.

2. **Observe Throttling in Action**:
   - After exceeding the limit, you'll receive an **HTTP 429 Too Many Requests** error with a friendly message.


3. **Verify Custom Exception Handler**:
   - The response should contain a message like:
     ```
     {
         "detail": "Too many requests. Please try again in 0 minute(s) 30 second(s)."
     }
     ```

4. **Adjust Throttling Rates if Necessary**:
   - Modify the `DEFAULT_THROTTLE_RATES` in `settings.py` to better suit your application's needs.

---

### 💡 Best Practices for Throttling

- **Start with Conservative Limits**: Begin with reasonable limits and adjust based on usage patterns and feedback.
- **Differentiate Between User Types**: Assign different throttling rates for different user roles (e.g., regular users vs. premium users).
- **Monitor and Adjust**: Continuously monitor API usage and adjust throttling rates to balance accessibility and protection.

---

## 📦 Committing Changes to Git 📦

After implementing and testing the permissions and throttling, it's crucial to commit your changes to version control.

### 🛠️ Git Commands

1. **Check Git Status**:
   ```bash
   (.venv) > git status
   ```

2. **Add All Changes**:
   ```bash
   (.venv) > git add .
   ```

3. **Commit with a Message**:
   ```bash
   (.venv) > git commit -m "add permissions and API throttling"
   ```

---

## 🎯 Conclusion

Setting up **proper permissions** and **API rate limiting** is vital for securing your API. Here's a quick recap of best practices:

1. **Project-Level Permissions** 🏢:
   - Start with a **strict default** permission policy, such as `IsAuthenticated`, ensuring that only authenticated users can access the API.

2. **View-Level Permissions** 👁️:
   - Apply specific permissions to individual views for finer control, such as restricting certain endpoints to admin users.

3. **Custom Permissions** 🎨:
   - Create custom permission classes to handle unique scenarios, like allowing only the **author** of a post to edit or delete it.

4. **API Rate Limiting (Throttling)** ⏳:
   - Implement throttling to prevent abuse and ensure fair usage of your API resources.
   - Use built-in throttling classes or create custom throttles to meet your specific needs.
