# 🔐 User Authentication in Django REST Framework 🛡️
Welcome to the **User Authentication Guide** for **Django REST Framework (DRF)**! This document provides an in-depth walkthrough of various authentication methods, their implementation, security considerations, and best practices to ensure a secure and efficient API. Whether you're a beginner or an experienced developer, this guide will help you set up robust authentication for your Blog API.

## 📑 Table of Contents

- [🔐 User Authentication in Django REST Framework 🛡️](#-user-authentication-in-django-rest-framework-️)
  - [📑 Table of Contents](#-table-of-contents)
  - [📚 Overview of Authentication Methods](#-overview-of-authentication-methods)
    - [🔑 Basic Authentication](#-basic-authentication)
      - [🔄 Authentication Flow](#-authentication-flow)
      - [Diagram:](#diagram)
      - [🔐 Pros and Cons](#-pros-and-cons)
      - [🛠️ Implementation in DRF](#️-implementation-in-drf)
    - [🛡️ Session Authentication](#️-session-authentication)
      - [🔄 Authentication Flow](#-authentication-flow-1)
      - [🔐 Pros and Cons](#-pros-and-cons-1)
      - [🛠️ Implementation in DRF](#️-implementation-in-drf-1)
    - [🪙 Token Authentication](#-token-authentication)
      - [🔄 Authentication Flow](#-authentication-flow-2)
      - [Diagram](#diagram-1)
      - [🔐 Pros and Cons](#-pros-and-cons-2)
      - [🔄 Enhanced Token Management](#-enhanced-token-management)
    - [🔒 Default Authentication](#-default-authentication)
      - [📝 Why Use Both Methods?](#-why-use-both-methods)
  - [🛠️ Implementing Token Authentication](#️-implementing-token-authentication)
    - [📦 Updating `settings.py` for Token Authentication](#-updating-settingspy-for-token-authentication)
    - [📦 Adding `authtoken` to `INSTALLED_APPS`](#-adding-authtoken-to-installed_apps)
    - [🔄 Migrating the Database](#-migrating-the-database)
    - [🔗 Verifying Tokens in Django Admin](#-verifying-tokens-in-django-admin)
  - [🔐 Using dj-rest-auth and django-allauth](#-using-dj-rest-auth-and-django-allauth)
    - [📦 Installing Third-Party Packages](#-installing-third-party-packages)
    - [📝 Configuring `settings.py` for dj-rest-auth and django-allauth](#-configuring-settingspy-for-dj-rest-auth-and-django-allauth)
    - [🔗 Updating URL Configuration](#-updating-url-configuration)
    - [🔄 Migrating the Database Again](#-migrating-the-database-again)
    - [📌 Running the Server and Accessing Endpoints](#-running-the-server-and-accessing-endpoints)
  - [📌 Testing Authentication Endpoints](#-testing-authentication-endpoints)
    - [🧑‍🤝‍🧑 Registering a New User](#-registering-a-new-user)
    - [🔍 Confirming Email](#-confirming-email)
    - [👤 Logging In with the New User](#-logging-in-with-the-new-user)
    - [🔑 Retrieving and Using the Auth Token](#-retrieving-and-using-the-auth-token)
  - [💡 Best Practices for Authentication](#-best-practices-for-authentication)
    - [1. **Use HTTPS**](#1-use-https)
    - [2. **Implement Token Expiry and Rotation**](#2-implement-token-expiry-and-rotation)
    - [3. **Secure Token Storage**](#3-secure-token-storage)
    - [4. **Limit Token Scope**](#4-limit-token-scope)
    - [5. **Monitor and Log Authentication Attempts**](#5-monitor-and-log-authentication-attempts)
    - [6. **Implement Multi-Factor Authentication (MFA)**](#6-implement-multi-factor-authentication-mfa)
    - [7. **Use Strong Password Policies**](#7-use-strong-password-policies)
    - [8. **Regularly Update Dependencies**](#8-regularly-update-dependencies)
    - [9. **Educate Users on Security**](#9-educate-users-on-security)
  - [📦 Committing Changes to Git 📦](#-committing-changes-to-git-)
    - [🛠️ Git Commands](#️-git-commands)
  - [🎯 Conclusion](#-conclusion)

## 📚 Overview of Authentication Methods

In the realm of web APIs, **authentication** is the process of verifying the identity of a user or client. Unlike **authorization**, which determines what an authenticated user can do, authentication ensures that users are who they claim to be. **Django REST Framework (DRF)** offers multiple authentication methods, each with its own set of advantages and use cases.

### 🔑 Basic Authentication

**Basic Authentication** is the simplest form of HTTP authentication. It involves sending a username and password with each request, encoded in base64. **[Learn More about base64](./base64.md)**

#### 🔄 Authentication Flow

1. **Client Makes an HTTP Request**:
   - The client attempts to access a protected resource without providing credentials.
   
   ```plaintext
   GET /protected-resource/ HTTP/1.1
   Host: example.com
   ```

2. **Server Responds with 401 Unauthorized**:
   - The server rejects the request and includes a `WWW-Authenticate` header indicating that Basic Authentication is required.
   
   ```plaintext
   HTTP/1.1 401 Unauthorized
   WWW-Authenticate: Basic realm="Access to the protected resource"
   ```

3. **Client Sends Credentials**:
   - The client retries the request, this time including the `Authorization` header with the encoded credentials.
   
   ```plaintext
   GET /protected-resource/ HTTP/1.1
   Host: example.com
   Authorization: Basic dXNlcjpwYXNzd29yZA==
   ```
   
   - **Explanation**: `dXNlcjpwYXNzd29yZA==` is the base64 encoding of `user:password`.

4. **Server Verifies Credentials**:
   - The server decodes the credentials and verifies them against the user database.
   - If valid, the server grants access with a `200 OK` response; otherwise, it responds with `403 Forbidden`.
   
   ```plaintext
   HTTP/1.1 200 OK
   Content-Type: application/json

   {
       "message": "Access granted to protected resource."
   }
   ```

#### Diagram:
```plaintext
Client                                   Server
------                                   ------
------------------------------------->   
GET / HTTP/1.1                        

                                       <-------------------------------------
                                       HTTP/1.1 401 Unauthorized
                                       WWW-Authenticate: Basic

------------------------------------->   
GET / HTTP/1.1                        
Authorization: Basic dXNlcjpwYXNzd29yZA==  

                                       <-------------------------------------
                                       HTTP/1.1 200 OK
```

#### 🔐 Pros and Cons

**Pros**:
- **Simplicity**: Easy to implement and understand.
- **Wide Support**: Supported by almost all HTTP clients and libraries.

**Cons**:
- **Security Risks**:
  - **Base64 Encoding**: Credentials are base64-encoded but not encrypted. They must be sent over HTTPS to prevent interception.
  - **Repeated Exposure**: Credentials are sent with every request, increasing the risk of exposure.
- **Inefficiency**: Sending credentials on every request increases bandwidth usage and server processing.

#### 🛠️ Implementation in DRF

**Configuration**:
Basic Authentication can be enabled by adding it to the `DEFAULT_AUTHENTICATION_CLASSES` in `settings.py`.

```python
# django_project/settings.py
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework.authentication.BasicAuthentication",
    ],
}
```

**Usage**:
Clients must include the `Authorization` header with the Basic credentials in their HTTP requests.

**Example with cURL**:
```bash
curl -u username:password http://127.0.0.1:8000/api/v1/protected-resource/
```

**Security Note**:
Always use HTTPS when implementing Basic Authentication to encrypt the credentials during transmission.

### 🛡️ Session Authentication

**Session Authentication** is traditionally used in monolithic Django applications. It leverages sessions and cookies to maintain user state across requests.

#### 🔄 Authentication Flow

1. **User Logs In**:
   - The user submits their credentials (username/password) via a login form.

   ```bash
   POST /login/ HTTP/1.1
   Host: example.com
   Content-Type: application/json

   {
       "username": "user",
       "password": "password123"
   }
   ```

2. **Server Verifies Credentials**:
   - The server authenticates the user and creates a **session object** stored in the database.
   - A **session ID** is generated and sent to the client as a cookie.

   ```plaintext
   HTTP/1.1 200 OK
   Set-Cookie: sessionid=abc123def456ghi789; HttpOnly; Path=/
   ```

3. **Client Stores Session ID**:
   - The browser automatically stores the `sessionid` cookie.

4. **Subsequent Requests Include Session ID**:
   - The session ID is sent with every HTTP request via the `Cookie` header.

   ```plaintext
   GET /protected-resource/ HTTP/1.1
   Host: example.com
   Cookie: sessionid=abc123def456ghi789
   ```

5. **Server Validates Session ID**:
   - The server retrieves the session object using the session ID and authenticates the user.

6. **User Logs Out**:
   - The session ID is destroyed both on the client and server sides.

#### 🔐 Pros and Cons

**Pros**:
- **Security**: Credentials are sent only once during login. Subsequent requests use the session ID.
- **Efficiency**: Avoids repeated credential verification by using session IDs.
- **Built-In Support**: Django provides robust session management out-of-the-box.

**Cons**:
- **Limited to Single Domain**: Session IDs are tied to the browser and domain, making it unsuitable for APIs serving multiple front-ends (e.g., mobile apps).
- **Scalability Issues**: Maintaining session objects across multiple servers can be complex, especially in distributed environments.
- **Inefficiency with Cookies**: Cookies are sent with every request, even those that don't require authentication, increasing bandwidth usage.

#### 🛠️ Implementation in DRF

**Configuration**:
Session Authentication is enabled by default in DRF. However, it's good practice to make the settings explicit.

```python
# django_project/settings.py
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework.authentication.SessionAuthentication",
    ],
}
```

**Usage**:
- **Browsable API**: Session Authentication powers the DRF Browsable API, allowing users to log in and out via the web interface.
- **CSRF Protection**: When using Session Authentication, ensure that CSRF protection is appropriately handled, especially for state-changing operations.

**Security Note**:
Session IDs should be protected using `HttpOnly` and `Secure` flags to prevent XSS and man-in-the-middle attacks.

### 🪙 Token Authentication

**Token Authentication** is a popular method for APIs, especially with the rise of single-page applications and mobile apps. It is **stateless**, meaning the server does not store any session information.

#### 🔄 Authentication Flow

1. **User Logs In**:
   - The user submits their credentials (username/password) via a login endpoint.

   ```bash
   POST /api/v1/dj-rest-auth/login/ HTTP/1.1
   Host: example.com
   Content-Type: application/json

   {
       "username": "user",
       "password": "password123"
   }
   ```

2. **Server Verifies Credentials**:
   - The server authenticates the user and generates a **unique token**.

3. **Server Sends the Token**:
   - The server responds with the token, which the client stores securely.

   ```json
   {
       "key": "401f7ac837da42b97f613d789819ff93537bee6a"
   }
   ```

4. **Client Stores the Token**:
   - The client stores the token (preferably in a secure, `httpOnly` cookie). **[Learn More about httpOnly](./httponly.md)**

5. **Client Includes the Token in Subsequent Requests**:
   - The client includes the token in the `Authorization` header of each request.

   ```
   Authorization: Token 401f7ac837da42b97f613d789819ff93537bee6a
   ```

6. **Server Verifies the Token**:
   - The server checks the token's validity and authenticates the user accordingly.

#### Diagram
```plaintext
Client                                    Server
------                                    ------
------------------------------------->   
GET / HTTP/1.1                           

                                       <-------------------------------------
                                       HTTP/1.1 401 Unauthorized
                                       WWW-Authenticate: Token

------------------------------------->   
GET / HTTP/1.1                           
Authorization: Token 401f7ac837da42b97f613d789819ff93537bee6a  

                                       <-------------------------------------
                                       HTTP/1.1 200 OK
```

#### 🔐 Pros and Cons

**Pros**:
- **Statelessness**: No need to store session information on the server, enhancing scalability.
- **Multi-Front-End Support**: The same token can be used across different platforms (web, mobile).
- **Flexibility**: Tokens can carry additional information or be configured to expire.

**Cons**:
- **Security Risks**:
  - **Token Theft**: Tokens can be stolen via XSS attacks if not stored securely.
  - **No Built-In Expiry**: DRF's default `TokenAuthentication` does not support token expiration, requiring additional implementation for enhanced security.
- **Token Management**:
  - **Single Token per User**: By default, each user has only one token. This can be problematic if a user logs in from multiple devices or platforms.
  - **Token Revocation**: Implementing token revocation strategies can add complexity.

#### 🔄 Enhanced Token Management

To address some of the cons, consider the following enhancements:

1. **Token Expiry**:
   - Implement token expiration to limit the window during which a stolen token can be used.
   - **Solution**: Use packages like **djangorestframework-simplejwt** which support JWTs with expiration times.

2. **Multiple Tokens per User**:
   - Allow users to have multiple tokens, enabling them to log in from different devices or platforms.
   - **Solution**: Customize the token model or use third-party packages that support this feature.

3. **Token Rotation and Revocation**:
   - Implement mechanisms to rotate tokens and revoke them when necessary.
   - **Solution**: Use JWTs with refresh tokens or maintain a token blacklist.

**JSON Web Tokens (JWTs)** are a newer form of token containing cryptographically signed JSON data. JWTs were originally designed for use in OAuth, an open standard way for websites to share access to user information without actually sharing user passwords. JWTs can be generated on the server with a third-party package like **djangorestframework-simplejwt** or via a third-party service like **Auth0**.

### 🔒 Default Authentication

The first step is to configure our new authentication settings. **Django REST Framework** comes with a number of settings that are implicitly set. For example, `DEFAULT_PERMISSION_CLASSES` was set to `AllowAny` before we updated it to `IsAuthenticated`.

The `DEFAULT_AUTHENTICATION_CLASSES` are set by default, so let’s explicitly add both **SessionAuthentication** and **BasicAuthentication** to our `django_project/settings.py` file.

```python
# django_project/settings.py
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_AUTHENTICATION_CLASSES": [  # new
        "rest_framework.authentication.SessionAuthentication",
        "rest_framework.authentication.BasicAuthentication",
    ],
}
```

#### 📝 Why Use Both Methods?

The answer is they serve different purposes:

- **SessionAuthentication**:
  - **Purpose**: Powers the Browsable API and the ability to log in and log out of it.
  - **Use Case**: Ideal for web-based interactions where users can authenticate via the DRF Browsable API.

- **BasicAuthentication**:
  - **Purpose**: Used to pass the session ID in the HTTP headers for the API itself.
  - **Use Case**: Suitable for API clients (e.g., mobile apps) that can securely handle and transmit credentials.

If you revisit the browsable API at [http://127.0.0.1:8000/api/v1/](http://127.0.0.1:8000/api/v1/) it will work just as before. Technically, nothing has changed; we’ve just made the default settings explicit.

## 🛠️ Implementing Token Authentication

Now we need to update our authentication system to use tokens. The first step is to update our `DEFAULT_AUTHENTICATION_CLASSES` setting to use `TokenAuthentication` as follows:

### 📦 Updating `settings.py` for Token Authentication

```python
# django_project/settings.py
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework.authentication.SessionAuthentication",
        "rest_framework.authentication.TokenAuthentication",  # new
    ],
}
```

**Explanation**:
- **SessionAuthentication**: Retained to continue powering the Browsable API.
- **TokenAuthentication**: Added to handle token-based authentication for API clients.

### 📦 Adding `authtoken` to `INSTALLED_APPS`

We also need to add the `authtoken` app, which generates the tokens on the server. It comes included with Django REST Framework but must be added to our `INSTALLED_APPS` setting:

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 3rd-party apps
    "rest_framework",
    "corsheaders",
    "rest_framework.authtoken",  # new
    # Local apps
    "accounts",
    "posts",
]
```

**Explanation**:
- **rest_framework.authtoken**: Provides the `Token` model and management commands necessary for token-based authentication.

### 🔄 Migrating the Database

Since we have made changes to our `INSTALLED_APPS`, we need to sync our database. Stop the server with `Control+C`. Then run the following command:

```bash
python manage.py migrate
```

**Expected Output**:
```
Operations to perform:
  Apply all migrations: accounts, admin, auth, authtoken, contenttypes, posts, sessions
Running migrations:
  Applying authtoken.0001_initial... OK
  Applying authtoken.0002_auto_20160226_1747... OK
  Applying authtoken.0003_tokenproxy... OK
```

**Explanation**:
- The migrations create the necessary database tables for `authtoken`.

### 🔗 Verifying Tokens in Django Admin

1. **Start the Server Again**:
   
```bash
    python manage.py runserver
```

2. **Access Django Admin**:
   
    Navigate to [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) in your web browser and log in with your superuser account.

3. **Locate the Tokens Section**:
   
    - In the admin interface, you should now see a **"Tokens"** section.
    - Initially, there are no tokens listed because tokens are generated only when users log in via the API.


**Explanation**:
- **Existing Users**: Tokens are only generated after there is an API call for a user to log in. Since we have not done that yet, there are no tokens.

## 🔐 Using dj-rest-auth and django-allauth

We also need to create endpoints so users can log in and log out. Instead of creating a dedicated users app and writing our own URLs, views, and serializers, we will leverage the third-party packages **dj-rest-auth** and **django-allauth**. These packages provide robust, tested solutions for user authentication and management, minimizing the risk of errors and saving development time.

### 📦 Installing Third-Party Packages

First, stop the server with `Control+C` and then install the required packages:

```bash
# Install dj-rest-auth
pipenv install dj-rest-auth
# Install django-allauth
pipenv install django-allauth
pipenv install requests
```

**Notes**:
- **dj-rest-auth**: Provides REST API endpoints for user authentication, registration, password reset, and more.
- **django-allauth**: Offers comprehensive user authentication, including social authentication via platforms like Facebook, Google, and Twitter.

**References**:
- [dj-rest-auth GitHub Repository](https://github.com/jazzband/dj-rest-auth)
- [django-allauth GitHub Repository](https://github.com/pennersr/django-allauth)

### 📝 Configuring `settings.py` for dj-rest-auth and django-allauth

After installing the packages, update your `settings.py` to include the necessary configurations.

1. **Update `INSTALLED_APPS`**:

```python
    # django_project/settings.py
    INSTALLED_APPS = [
        "django.contrib.admin",
        "django.contrib.auth",
        "django.contrib.contenttypes",
        "django.contrib.sessions",
        "django.contrib.messages",
        "django.contrib.staticfiles",
        "django.contrib.sites",  # Required by django-allauth
        # 3rd-party apps
        "rest_framework",
        "corsheaders",
        "rest_framework.authtoken",
        "allauth",                 # django-allauth
        "allauth.account",         # django-allauth
        "allauth.socialaccount",   # django-allauth
        "dj_rest_auth",            # dj-rest-auth
        "dj_rest_auth.registration",  # dj-rest-auth registration
        # Local apps
        "accounts",
        "posts",
    ]
```

**Explanation**:
    - **"django.contrib.sites"**: Part of Django’s “sites” framework, required by **django-allauth** to handle site-specific configurations.
    - **"allauth"**, **"allauth.account"**, **"allauth.socialaccount"**: Core and additional apps provided by **django-allauth** for comprehensive authentication features.
    - **"dj_rest_auth"**, **"dj_rest_auth.registration"**: Provides REST API endpoints for authentication and user registration.

2. **Configure Templates and Email Backend**:

    ```python
    # django_project/settings.py
    TEMPLATES = [
        {
            "BACKEND": "django.template.backends.django.DjangoTemplates",
            "DIRS": [],
            "APP_DIRS": True,
            "OPTIONS": {
                "context_processors": [
                    "django.template.context_processors.debug",
                    "django.template.context_processors.request",  # Required by django-allauth
                    "django.contrib.auth.context_processors.auth",
                    "django.contrib.messages.context_processors.messages",
                    "django.template.context_processors.request",  # Ensure it's included
                ],
            },
        },
    ]

    EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"  # For development
    SITE_ID = 1  # Required by django-allauth
    ```

    **Explanation**:
    - **TEMPLATES**:
      - **"django.template.context_processors.request"**: Ensures that the request context is available in templates, required by **django-allauth**.
    - **EMAIL_BACKEND**:
      - **Development**: Using `console.EmailBackend` prints emails to the console, which is useful for testing without setting up an actual email server.
      - **Production**: Replace with a real email backend (e.g., SMTP, SendGrid) to send actual emails.
    - **SITE_ID**:
      - Part of Django’s “sites” framework. It associates the current project with a specific site/domain, essential for generating accurate URLs in emails sent by **django-allauth**.

3. **Additional DRF Settings for Token Authentication**:

    Ensure that `rest_framework.authtoken` is included in your `INSTALLED_APPS` and configure the authentication classes.

    ```python
    # django_project/settings.py
    REST_FRAMEWORK = {
        "DEFAULT_PERMISSION_CLASSES": [
            "rest_framework.permissions.IsAuthenticated",
        ],
        "DEFAULT_AUTHENTICATION_CLASSES": [
            "rest_framework.authentication.SessionAuthentication",  # Powers the Browsable API
            "rest_framework.authentication.TokenAuthentication",    # Token-based auth
        ],
        "DEFAULT_THROTTLE_CLASSES": [
            "rest_framework.throttling.AnonRateThrottle",
            "rest_framework.throttling.UserRateThrottle",
            "posts.throttling.FivePerFiveMinuteThrottle",  # Custom throttle
        ],
        "DEFAULT_THROTTLE_RATES": {
            "anon": "2/day",                  # 2 requests per day for anonymous users
            "user": "5/day",                  # 5 requests per day for authenticated users
            "five_per_five_minute": "5/5m",   # 5 requests per 5 minutes
        },
        "EXCEPTION_HANDLER": "posts.exceptions.custom_exception_handler",  # Custom exception handler
    }
    ```
4. **🔄 Update Middle for django-allauth**
```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',  # new
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'allauth.account.middleware.AccountMiddleware', # Required by django-allauth
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

**Notes**:
    - **SessionAuthentication**: Enables the DRF Browsable API’s login/logout functionality.
    - **TokenAuthentication**: Allows token-based authentication for API clients.
    - **Throttling**: Controls the rate of API requests to prevent abuse.

### 🔗 Updating URL Configuration

Update your project's `urls.py` to include the authentication endpoints provided by **dj-rest-auth** and **django-allauth**.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/", include("posts.urls")),
    path("api-auth/", include("rest_framework.urls")),  # DRF Browsable API auth
    path("api/v1/dj-rest-auth/", include("dj_rest_auth.urls")),  # dj-rest-auth endpoints
    path("api/v1/dj-rest-auth/registration/",include("dj_rest_auth.registration.urls")),
]
```

**Explanation**:
- **"api/v1/dj-rest-auth/"**: Provides endpoints for login, logout, password reset, and more.
- **"api/v1/dj-rest-auth/registration/"**: Adds endpoints for user registration (sign up) and email confirmation.

**Important Note**: Ensure that URL paths use dashes `-` instead of underscores `_` to prevent common mistakes.

### 🔄 Migrating the Database Again

After updating `INSTALLED_APPS` and configuring settings, apply the migrations to sync the database with the new configurations.

```bash
python manage.py migrate
```

**Expected Output**:
```
Operations to perform:
  Apply all migrations: accounts, admin, auth, authtoken, contenttypes, dj_rest_auth, allauth, posts, sessions
Running migrations:
  Applying authtoken.0001_initial... OK
  Applying allauth.0001_initial... OK
  Applying allauth.0002_auto_20170726_2137... OK
  Applying allauth.0003_auto_20170830_1323... OK
  Applying allauth.0004_auto_20180417_1532... OK
  Applying dj_rest_auth.0001_initial... OK
  ...
```

**Explanation**:
- Migrations create the necessary database tables for **dj-rest-auth** and **django-allauth**, including user models, tokens, and social account integrations.

### 📌 Running the Server and Accessing Endpoints

1. **Start the Server**:

```bash
python manage.py runserver
```

2. **Access Authentication Endpoints**:

    - **Log In**: [http://127.0.0.1:8000/api/v1/dj-rest-auth/login/](http://127.0.0.1:8000/api/v1/dj-rest-auth/login/)
    - **Log Out**: [http://127.0.0.1:8000/api/v1/dj-rest-auth/logout/](http://127.0.0.1:8000/api/v1/dj-rest-auth/logout/)
    - **User Registration**: [http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/](http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/)
    - **Password Reset**: [http://127.0.0.1:8000/api/v1/dj-rest-auth/password/reset/](http://127.0.0.1:8000/api/v1/dj-rest-auth/password/reset/)
    - **Password Reset Confirm**: [http://127.0.0.1:8000/api/v1/dj-rest-auth/password/reset/confirm/](http://127.0.0.1:8000/api/v1/dj-rest-auth/password/reset/confirm/)

**Note**: These endpoints are now available and provide functionality for user authentication and management without requiring you to implement them manually.

---

## 📌 Testing Authentication Endpoints

Testing is crucial to ensure that the authentication system works as expected. Below are step-by-step instructions to test each authentication endpoint.

### 🧑‍🤝‍🧑 Registering a New User

1. **Navigate to the User Registration Endpoint**:

    Open your web browser and go to [http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/](http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/).

2. **Submit a POST Request with User Data**:

    You can use tools like **Postman**, **cURL**, or the DRF Browsable API to send a POST request. Below is an example using **cURL**:

    ```bash
    curl -X POST http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/ \
    -H "Content-Type: application/json" \
    -d '{
        "username": "testuser1",
        "password1": "password123",
        "password2": "password123",
        "email": "testuser1@email.com"
    }'
    ```

    **Expected Response**:

```json
    {
        "key": "401f7ac837da42b97f613d789819ff93537bee6a"
    }
```

**Explanation**:
- **"key"**: This is the authentication token for the newly registered user. It will be used to authenticate future API requests.

3. **Console Output (Email Confirmation)**:

    Since we're using the **console email backend**, an email is printed to the terminal where the server is running. The email contains a confirmation link that the user must visit to activate their account.

```
    Content-Type: text/plain; charset="utf-8"
    MIME-Version: 1.0
    Content-Transfer-Encoding: 7bit
    Subject: [example.com] Please Confirm Your E-mail Address
    From: webmaster@localhost
    To: testuser1@email.com
    Date: Wed, 09 Feb 2022 16:22:38 -0000
    Message-ID:
    <164442375878.25521.7693193428490319037@1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\
    0.0.0.0.0.0.0.0.ip6.arpa>
    Hello from example.com!

    You're receiving this e-mail because user testuser1 has given your e-mail address to register an account on example.com.
    To confirm this is correct, go to http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/account-confirm-email/MQ:1nHpjq:D1vZokltkCU2bqKO_g9cmA_hf2fThyl6vgtC7CpNdfI/
    Thank you for using example.com!
    example.com
    -------------------------------------------------------------------------------
    [09/Feb/2022 16:22:38] "POST /api/v1/dj-rest-auth/registration/ HTTP/1.1" 201 7828
```

**Action Required**:
   - **Copy the Confirmation Link**: Extract the URL from the email content.
   - **Visit the Link**: Open the confirmation link in your web browser to activate the user's account.

    **Note**: In a production environment, the email would be sent to the user's actual email address instead of being printed to the console.

### 🔍 Confirming Email

1. **Access the Confirmation Link**:

    Paste the confirmation link from the console output into your web browser's address bar and navigate to it. For example:

 ```
http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/account-confirm-email/MQ:1nHpjq:D1vZokltkCU2bqKO_g9cmA_hf2fThyl6vgtC7CpNdfI/
```

1. **Confirmation Success**:

    Upon visiting the link, you should receive a message indicating that your email has been confirmed successfully. This activates the user's account, allowing them to log in.

**Explanation**:
    - **Account Activation**: The user's account is now active and can be used to authenticate with the API.
    - **Token Generation**: A token is associated with the user, which can be used for authenticated API requests.

### 👤 Logging In with the New User

1. **Navigate to the Log In Endpoint**:

    Open your web browser and go to [http://127.0.0.1:8000/api/v1/dj-rest-auth/login/](http://127.0.0.1:8000/api/v1/dj-rest-auth/login/).

2. **Submit a POST Request with Login Credentials**:

    You can use the DRF Browsable API, **Postman**, or **cURL** to send a POST request. Here's an example using **cURL**:

```bash
    curl -X POST http://127.0.0.1:8000/api/v1/dj-rest-auth/login/ \
    -H "Content-Type: application/json" \
    -d '{
        "username": "testuser1",
        "password": "password123"
    }'
```

**Expected Response**:

```json
    {
        "key": "401f7ac837da42b97f613d789819ff93537bee6a"
    }
```

**Explanation**:
    - **"key"**: The authentication token for `testuser1`. This token will be used to authenticate future API requests.

3. **Verify Token Generation in Django Admin**:

    - **Access Django Admin**: Navigate to [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) and log in with your superuser account.
    - **Locate the Tokens Section**: You should see a **"Tokens"** section. Click on it to view all user tokens.
    - **Check for `testuser1` Token**: A token entry for `testuser1` should now be present.
  

    **Explanation**:
    - **Existing Users Without Tokens**: Users created before implementing `TokenAuthentication` do not have tokens. Tokens are generated upon their first successful authentication via the API.
    - **Token Availability**: Once a user logs in through the API, their token is created and available in the admin interface.

### 🔑 Retrieving and Using the Auth Token

1. **Store the Token on the Client**:

    In your front-end framework (e.g., React, Vue.js), you need to store the token securely. Common practices include:

    - **Local Storage**:
      - **Pros**: Easy to implement.
      - **Cons**: Vulnerable to XSS attacks.
      
      ```javascript
      // Example in JavaScript
      localStorage.setItem('authToken', '401f7ac837da42b97f613d789819ff93537bee6a');
      ```
    
    - **Cookies**:
      - **Pros**: Can be secured with `httpOnly` and `Secure` flags to mitigate XSS attacks.
      - **Cons**: Requires careful handling to prevent CSRF attacks.
      
```javascript
      // Example in JavaScript
      document.cookie = "authToken=401f7ac837da42b97f613d789819ff93537bee6a; Secure; HttpOnly; SameSite=Strict";
```    
**Security Considerations**:
    - **Avoid Storing in `localStorage`**: Due to XSS vulnerabilities, it's generally safer to store tokens in secure, `httpOnly` cookies.
    - **Use HTTPS**: Always use HTTPS to encrypt data in transit, especially when transmitting tokens.

2. **Include the Token in API Requests**:

    For authenticated API requests, include the token in the `Authorization` header.

```bash
    curl -H "Authorization: Token 401f7ac837da42b97f613d789819ff93537bee6a" http://127.0.0.1:8000/api/v1/posts/
```

**Explanation**:
    - **Authorization Header**: The token is passed in the `Authorization` header as `Token <token_key>`.
    - **Server Verification**: DRF's `TokenAuthentication` class verifies the token and authenticates the user if the token is valid.

3. **Handling Token Expiry and Refresh**:

    **Note**: DRF's default `TokenAuthentication` does not support token expiry or refresh tokens. For enhanced security, consider using packages like **djangorestframework-simplejwt**, which provides JWT support with expiration and refresh capabilities.

    **Example with Simple JWT**:

```bash
    pipenv install djangorestframework-simplejwt
```

```python
    # django_project/settings.py

    REST_FRAMEWORK = {
        "DEFAULT_PERMISSION_CLASSES": [
            "rest_framework.permissions.IsAuthenticated",
        ],
        "DEFAULT_AUTHENTICATION_CLASSES": [
            "rest_framework.authentication.SessionAuthentication",
            "rest_framework_simplejwt.authentication.JWTAuthentication",
        ],
    }
```

```python
    # django_project/urls.py

    from django.contrib import admin
    from django.urls import path, include
    from rest_framework_simplejwt.views import (
        TokenObtainPairView,
        TokenRefreshView,
    )

    urlpatterns = [
        path("admin/", admin.site.urls),
        path("api/v1/", include("posts.urls")),
        path("api-auth/", include("rest_framework.urls")),
        path("api/v1/dj-rest-auth/", include("dj_rest_auth.urls")),
        path("api/v1/dj-rest-auth/registration/", include("dj_rest_auth.registration.urls")),
        path("api/v1/token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
        path("api/v1/token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    ]
```

**Explanation**:
    - **TokenObtainPairView**: Provides a way to obtain both access and refresh tokens.
    - **TokenRefreshView**: Allows clients to obtain a new access token using a valid refresh token.

**References**:
    - [djangorestframework-simplejwt Documentation](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/)

## 💡 Best Practices for Authentication

Implementing authentication correctly is paramount for the security and usability of your API. Here are some best practices to follow:

### 1. **Use HTTPS**

- **Purpose**: Encrypt data in transit to protect sensitive information like tokens and credentials.
- **Implementation**:
  - Obtain and install an SSL/TLS certificate.
  - Redirect all HTTP traffic to HTTPS.
  - Ensure that secure cookies are marked with the `Secure` flag.

### 2. **Implement Token Expiry and Rotation**

- **Token Expiry**:
  - **Purpose**: Limit the duration during which a stolen token can be used.
  - **Implementation**: Use JWTs with an expiration time or implement custom token models that include expiry fields.
  
- **Token Rotation**:
  - **Purpose**: Regularly replace tokens to enhance security.
  - **Implementation**: Use refresh tokens or provide mechanisms for token renewal.

  **Example with JWTs**:
```python
  # django_project/settings.py
  REST_FRAMEWORK = {
      # ... existing settings ...
  }

  SIMPLE_JWT = {
      'ACCESS_TOKEN_LIFETIME': timedelta(minutes=5),
      'REFRESH_TOKEN_LIFETIME': timedelta(days=1),
      # ... other settings ...
  }
```

  **References**:
  - [djangorestframework-simplejwt Documentation](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/)

### 3. **Secure Token Storage**

- **Cookies**:
  - **Best Practices**:
    - Use `HttpOnly` flag to prevent JavaScript access.
    - Use `Secure` flag to ensure cookies are only sent over HTTPS.
    - Use `SameSite` attribute to prevent CSRF attacks.
  
  - **Implementation**:
    ```python
    # Example of setting a secure cookie in a Django view
    response.set_cookie(
        key='auth_token',
        value=token.key,
        httponly=True,
        secure=True,
        samesite='Strict',
    )
    ```

- **Avoid `localStorage`**:
  - **Reason**: Vulnerable to XSS attacks, as JavaScript can access `localStorage` contents.
  - **Alternative**: Use `httpOnly` cookies for storing tokens.

### 4. **Limit Token Scope**

- **Purpose**: Enforce the principle of least privilege by restricting what actions a token can perform.
- **Implementation**:
  - Assign specific permissions or scopes to tokens.
  - Use separate tokens for different access levels (e.g., read-only vs. read-write).

  **Example**:
  ```python
  # Define scopes in settings
  REST_FRAMEWORK = {
      "DEFAULT_AUTHENTICATION_CLASSES": [
          "rest_framework.authentication.TokenAuthentication",
      ],
      "DEFAULT_PERMISSION_CLASSES": [
          "rest_framework.permissions.IsAuthenticated",
      ],
      "DEFAULT_THROTTLE_CLASSES": [
          "rest_framework.throttling.UserRateThrottle",
      ],
      "DEFAULT_THROTTLE_RATES": {
          "user": "1000/day",
      },
  }
  ```

### 5. **Monitor and Log Authentication Attempts**

- **Purpose**: Detect and respond to suspicious activities like brute-force attacks.
- **Implementation**:
  - Log all authentication attempts, both successful and failed.
  - Use monitoring tools to analyze logs and set up alerts for unusual patterns.

  **Example with Django Logging**:
  ```python
  # django_project/settings.py
  LOGGING = {
      'version': 1,
      'disable_existing_loggers': False,
      'handlers': {
          'console': {
              'class': 'logging.StreamHandler',
          },
      },
      'loggers': {
          'django.security.Authentication': {
              'handlers': ['console'],
              'level': 'INFO',
          },
      },
  }
  ```

### 6. **Implement Multi-Factor Authentication (MFA)**

- **Purpose**: Add an extra layer of security by requiring additional verification steps during login.
- **Implementation**:
  - Use packages like **django-otp** or **django-two-factor-auth** to enable MFA.
  
  **Example with django-two-factor-auth**:
  ```bash
  pipenv install django-two-factor-auth
  ```

  ```python
  # django_project/settings.py
  INSTALLED_APPS += [
      "django_otp",
      "django_otp.plugins.otp_totp",
      "two_factor",
  ]

  MIDDLEWARE += [
      "django_otp.middleware.OTPMiddleware",
  ]
  ```

  **References**:
  - [django-two-factor-auth Documentation](https://django-two-factor-auth.readthedocs.io/en/stable/)

### 7. **Use Strong Password Policies**

- **Purpose**: Reduce the risk of account compromise due to weak or easily guessable passwords.
- **Implementation**:
  - Enforce minimum password length.
  - Require a mix of characters (uppercase, lowercase, numbers, symbols).
  - Prevent the use of common or compromised passwords.

  **Example with Django's Password Validators**:
  ```python
  # django_project/settings.py
  AUTH_PASSWORD_VALIDATORS = [
      {
          'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
      },
      {
          'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
          'OPTIONS': {
              'min_length': 12,
          }
      },
      {
          'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
      },
      {
          'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
      },
  ]
  ```

  **References**:
  - [Django Password Validation](https://docs.djangoproject.com/en/4.0/topics/auth/passwords/#module-django.contrib.auth.password_validation)

### 8. **Regularly Update Dependencies**

- **Purpose**: Incorporate security patches and improvements by keeping authentication-related packages up-to-date.
- **Implementation**:
  - Use tools like **pipenv-review** or **pipenvenv** to monitor and update packages.
  
  ```bash
  pipenv install pipenv-review
  pipenv-review --local --interactive
  ```

### 9. **Educate Users on Security**

- **Purpose**: Inform users about best practices to protect their accounts.
- **Implementation**:
  - Encourage the use of strong, unique passwords.
  - Inform users about recognizing phishing attempts.
  - Provide guidance on secure token storage.

## 📦 Committing Changes to Git 📦

After implementing and thoroughly testing the authentication system, it's essential to commit your changes to version control. This practice ensures that your progress is tracked and allows for collaboration with other developers.

### 🛠️ Git Commands

1. **Check Git Status**

    Before committing, check the current status of your repository to see which files have been modified.

```bash
    git status
```

1. **Add All Changes**

    Stage all the changes you've made to be included in the next commit.

```bash
git add .
```
1. **Commit with a Descriptive Message**

    Commit the staged changes with a clear and descriptive message.
```bash
git commit -m "Add user authentication with dj-rest-auth and django-allauth"
```

## 🎯 Conclusion

**User authentication** is one of the hardest areas to grasp when first working with web APIs. Without the benefit of a monolithic structure, developers have to deeply understand and configure their HTTP request/response cycles appropriately.

**Django REST Framework** comes with a lot of built-in support for this process, including built-in `TokenAuthentication`. However, developers must configure additional areas like user registration and dedicated URLs/views themselves. As a result, a popular, powerful, and secure approach is to rely on third-party packages like **dj-rest-auth** and **django-allauth** to minimize the amount of code we have to write from scratch.

By following this guide, you have successfully:

1. **Configured Default Authentication** 🔄:
   - Explicitly set up **SessionAuthentication** and **BasicAuthentication** in `settings.py`.
   - Explained the purposes and use cases for both methods.

2. **Implemented Token Authentication** 🛠️:
   - Updated `settings.py` to include `TokenAuthentication`.
   - Added `rest_framework.authtoken` to `INSTALLED_APPS`.
   - Migrated the database to apply changes.
   - Verified token generation in Django admin.

3. **Utilized dj-rest-auth and django-allauth** 🔐:
   - Installed and configured **dj-rest-auth** and **django-allauth**.
   - Updated URL configurations to include authentication endpoints.
   - Registered new users and confirmed their email addresses.
   - Logged in with new users to generate and retrieve authentication tokens.

4. **Tested Authentication Endpoints** 📌:
   - Registered new users through the API and confirmed their accounts.
   - Logged in to obtain authentication tokens.
   - Used tokens to authenticate API requests securely.
   - Ensured that tokens are correctly associated with user accounts.

5. **Adhered to Best Practices** 💡:
   - Implemented HTTPS, secure token storage, token expiry, and rotation.
   - Monitored authentication attempts and enforced strong password policies.
   - Educated users on security best practices.

6. **Committed Changes to Git** 📦:
   - Tracked all changes using Git to maintain a history of your project's development.
   - Used descriptive commit messages to document significant changes and implementations.

**Next Steps**:

- **Enhance Security**: Consider implementing additional security measures such as multi-factor authentication (MFA) and account lockout policies.
- **Optimize Token Management**: Explore using JWTs with **djangorestframework-simplejwt** for token expiration and refresh capabilities.
- **Expand Authentication Features**: Integrate social authentication providers (e.g., Google, Facebook) using **django-allauth** for a more versatile authentication system.
- **Implement Rate Limiting**: Protect your API from abuse by setting up throttling and rate limiting mechanisms.

**Final Thoughts**:

Authentication is a foundational aspect of web development that demands careful consideration and implementation. By taking the time to configure and test your authentication system thoroughly, you ensure that your application remains **secure**, **reliable**, and **user-friendly**.