# 🎨 Custom Views Permissions For Login

These custom views extend Django Allauth’s `LoginView` and `SignupView` to add custom logic for assigning permissions to users after they successfully log in or sign up.

## Complete Code Snippet

```python
# acccounts/views.py
from allauth.account.views import LoginView, SignupView
from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType

class CustomLoginView(LoginView):
    def form_valid(self, form):
        response = super().form_valid(form)
        user = self.request.user
        self.assign_special_status_permission(user)  # Assign permission after login
        return response

    def assign_special_status_permission(self, user):
        # Assign 'books.special_status' permission to the user if not already assigned
        content_type = ContentType.objects.get(app_label='books', model='book')
        special_permission = Permission.objects.get(codename='special_status', content_type=content_type)

        if not user.has_perm('books.special_status'):
            user.user_permissions.add(special_permission)


class CustomSignupView(SignupView):
    def form_valid(self, form):
        response = super().form_valid(form)
        user = self.user
        self.assign_special_status_permission(user)  # Assign permission after signup
        return response

    def assign_special_status_permission(self, user):
        # Assign 'books.special_status' permission to the user if not already assigned
        content_type = ContentType.objects.get(app_label='books', model='book')
        special_permission = Permission.objects.get(codename='special_status', content_type=content_type)

        if not user.has_perm('books.special_status'):
            user.user_permissions.add(special_permission)
```
```python
class CustomLoginView(LoginView):
    def form_valid(self, form):
        response = super().form_valid(form)  # ✅ Call the parent class's form_valid method to handle the login process
        user = self.request.user  # 👤 Get the current logged-in user from the request object
        self.assign_special_status_permission(user)  # 🛡️ Assign the special permission to the user
        return response  # 🚀 Return the response as usual
```

- **`form_valid(self, form)`**:  
  - 📥 **Method Triggered on Valid Form Submission**: When a user submits the login form and it’s valid, this method gets called.
  - 🧩 **Calling Parent Class's `form_valid`**: `super().form_valid(form)` handles the default login process, including logging the user in and managing the redirection.
  - 👤 **Get the Logged-in User**: `self.request.user` retrieves the user who just logged in.
  - 🛡️ **Assign Permission to the User**: We call `self.assign_special_status_permission(user)` to give the user the `books.special_status` permission.
  - 🚀 **Return the Response**: The method concludes by returning the response, ensuring that the usual post-login actions (like redirection) happen smoothly.

#### 2. **🛡️ assign_special_status_permission Method**: Grant Permission to User

```python
def assign_special_status_permission(self, user):
    # 🔍 Fetch the content type for the Book model to locate the right permission
    content_type = ContentType.objects.get(app_label='books', model='book')  
    
    # 🔑 Fetch the permission object for 'special_status' related to the Book model
    special_permission = Permission.objects.get(codename='special_status', content_type=content_type)

    # ❓ Check if the user already has the permission
    if not user.has_perm('books.special_status'):  
        # ➕ Add the permission to the user if not already assigned
        user.user_permissions.add(special_permission)
```

- **`ContentType.objects.get(app_label='books', model='book')`**:  
  - 🔍 **Find the Content Type for the `Book` Model**: We use `ContentType` to get metadata about the `Book` model. This is needed to find the right permission related to this model.
  
- **`Permission.objects.get(codename='special_status', content_type=content_type)`**:  
  - 🔑 **Retrieve the `special_status` Permission Object**: We get the `Permission` object using its `codename` (`special_status`) and the `ContentType` of the `Book` model. This represents the specific permission to be granted.

- **`if not user.has_perm('books.special_status')`**:  
  - ❓ **Check if the User Already Has Permission**: Before adding the permission, we check if the user already has it to avoid duplication.

- **`user.user_permissions.add(special_permission)`**:  
  - ➕ **Add Permission to the User**: If the user doesn’t have the permission, we add it using `user.user_permissions.add(special_permission)`.

#### 3. **📝 CustomSignupView**: Extending Allauth's SignupView

The `CustomSignupView` works similarly to `CustomLoginView`, but it handles user signup.

```python
class CustomSignupView(SignupView):
    def form_valid(self, form):
        response = super().form_valid(form)  # ✅ Call the parent class's form_valid method to handle the signup process
        user = self.user  # 👶 Get the newly signed-up user
        self.assign_special_status_permission(user)  # 🛡️ Assign the special permission to the user
        return response  # 🚀 Return the response as usual
```

- **`form_valid(self, form)`**:  
  - 📥 **Method Triggered on Valid Form Submission**: When a user submits the signup form and it’s valid, this method gets triggered.
  - 🧩 **Calling Parent Class's `form_valid`**: `super().form_valid(form)` handles the default signup logic (creating a new user, logging them in, etc.).
  - 👶 **Get the Newly Created User**: `self.user` fetches the newly created user instance.
  - 🛡️ **Assign Permission to the New User**: `self.assign_special_status_permission(user)` grants the `books.special_status` permission to the new user.
  - 🚀 **Return the Response**: Finally, return the response to proceed with the usual post-signup actions (like redirection).

### 🌟 Summary of the Process

1. **🔐 Login Process**:
   - When a user logs in using the `CustomLoginView`, the `form_valid` method is called upon successful login.
   - The `assign_special_status_permission` method checks if the user has the `books.special_status` permission. If not, it assigns it. 🛡️

2. **📝 Signup Process**:
   - When a user signs up using the `CustomSignupView`, the `form_valid` method is called after the new user is created.
   - The `assign_special_status_permission` method assigns the `books.special_status` permission to the newly created user if they don't already have it. 🛡️

### 🎉 Conclusion

By customizing Django Allauth's `LoginView` and `SignupView`, you can automatically assign the `books.special_status` permission to users upon login or signup. This makes the user experience smooth and efficient, eliminating the need for manual permission assignment. 🌟🚀