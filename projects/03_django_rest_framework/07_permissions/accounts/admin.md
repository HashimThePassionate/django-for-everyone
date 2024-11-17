# 📚 Django Custom User Admin

## 🗂️ Table of Contents
1. 📝 [Introduction](#-introduction)
2. 🔍 [Code Breakdown](#-code-breakdown)
   - 📦 [Required Imports](#-1-required-imports)
   - 👨‍💻 [Custom User Admin Class](#-2-custom-user-admin-class)
   - 🛠️ [Customizing Fieldsets](#-3-customizing-fieldsets)
   - ✨ [Customizing Add Fieldsets](#-4-customizing-add-fieldsets)
   - 🗃️ [Registering Custom User Model](#-5-registering-custom-user-model)
3. 🎯 [Purpose of the Code](#-purpose-of-the-code)
4. 🏁 [Conclusion](#-conclusion)

## 📝 Introduction
This guide explains how to customize the Django Admin for a custom user model. In this scenario, we are extending Django’s default user model using `AbstractUser` and customizing its admin interface to include additional fields such as `name`. We'll also explore how to handle the forms for creating and updating users efficiently.

## 🔍 Code Breakdown

### 📦 1. Required Imports
```python
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser
```

- **`admin`**: Provides functionalities to customize Django's admin interface.
- **`UserAdmin`**: Django’s built-in admin class for managing users.
- **`CustomUserCreationForm`** & **`CustomUserChangeForm`**: Custom forms used to create and edit users.
- **`CustomUser`**: Our custom user model extending `AbstractUser`.

### 👨‍💻 2. Custom User Admin Class
```python
class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ["email", "username", "name", "is_staff"]
```

- **`CustomUserAdmin`**: This class customizes how users are managed in the Django admin interface.
- **`add_form`**: Specifies which form to use when adding a new user.
- **`form`**: Specifies which form to use when updating an existing user.
- **`model`**: Indicates that we are working with the `CustomUser` model.
- **`list_display`**: Controls which fields are visible in the admin user list view.

### 🛠️ 3. Customizing Fieldsets
```python
fieldsets = (
    (None, {"fields": ("username", "password", "name", "email")}),
    ("Permissions", {"fields": ("is_staff", "is_active")}),
)
```

- **`fieldsets`**: Defines sections and fields displayed in the user edit form.
- **Fields Included**:
  - `username`: Unique username.
  - `password`: User's password (hashed).
  - `name`: The custom field added to our user model.
  - `email`: User's email.
- **`Permissions` Section**:
  - `is_staff`: Determines if the user has admin rights.
  - `is_active`: Indicates if the account is active.

### ✨ 4. Customizing Add Fieldsets
```python
add_fieldsets = (
    (None, {
        "classes": ("wide",),
        "fields": ("username", "name", "email", "password1", "password2"),
    }),
)
```

- **`add_fieldsets`**: Defines fields shown when creating a new user.
- **Fields Included**:
  - `username`: User's username.
  - `name`: Custom name field.
  - `email`: User's email.
  - `password1` and `password2`: Password confirmation fields.

### 🗃️ 5. Registering Custom User Model
```python
admin.site.register(CustomUser, CustomUserAdmin)
```

- Registers the `CustomUser` model with the admin site using the `CustomUserAdmin` class.
- Ensures that Django’s admin interface uses the custom forms and fieldsets.

## 🎯 Purpose of the Code
The main goal of this code is to **customize Django’s default user management** to include additional fields (like `name`) while retaining Django's powerful admin interface. This customization allows us to:

- Add extra fields to the user model.
- Control which fields are visible when creating or updating users.
- Use custom forms for better user management.

## 🏁 Conclusion
With this configuration, you’ve extended Django's user model to include custom fields and tailored the admin interface to suit your application's needs. 🎉 This allows for efficient user management while leveraging Django’s built-in functionalities.

