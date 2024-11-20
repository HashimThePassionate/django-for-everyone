# 📚 Base64 Encoding and Basic Authentication 📚

Base64 encoding is often used in **HTTP Basic Authentication**, one of the simplest forms of authentication on the web. This guide combines an explanation of Base64 with an example of Basic Authentication using Django **Class-Based Views (CBVs)**.


## 📑 Table of Contents 📚

- [📚 Base64 Encoding and Basic Authentication 📚](#-base64-encoding-and-basic-authentication-)
  - [📑 Table of Contents 📚](#-table-of-contents-)
  - [🤔 What is Base64?](#-what-is-base64)
    - [Why "Base64"?](#why-base64)
  - [🛠️ Why Use Base64?](#️-why-use-base64)
  - [⚙️ How Base64 Works 🧩](#️-how-base64-works-)
  - [🔐 What is the Authorization Header?](#-what-is-the-authorization-header)
    - [How Does It Work? ⚙️](#how-does-it-work-️)
    - [Example of the `Authorization` Header](#example-of-the-authorization-header)
      - [Example:](#example)
  - [📜 Examples with Code 💻](#-examples-with-code-)
    - [Encoding in Python 🐍](#encoding-in-python-)
    - [Decoding in Python 🐍](#decoding-in-python-)
  - [🔑 What is Basic Authentication?](#-what-is-basic-authentication)
  - [🔐 Basic Authentication Example with Django CBV](#-basic-authentication-example-with-django-cbv)
    - [Step 1: Create a Class-Based View to Handle Authentication](#step-1-create-a-class-based-view-to-handle-authentication)
    - [Step 2: Add the Class-Based View to `urls.py`](#step-2-add-the-class-based-view-to-urlspy)
    - [Client Side: Using Python `requests`](#client-side-using-python-requests)
  - [💡 Detailed Logic of `BasicAuthView`](#-detailed-logic-of-basicauthview)
    - [1️⃣ Extracting the Authorization Header](#1️⃣-extracting-the-authorization-header)
    - [2️⃣ Decoding Base64 Credentials](#2️⃣-decoding-base64-credentials)
    - [3️⃣ Validating Credentials](#3️⃣-validating-credentials)
  - [🔒 Is Base64 Secure?](#-is-base64-secure)


## 🤔 What is Base64?

Base64 is an encoding technique that converts binary data (like files, images, or credentials) into a readable text format. It uses only:
- 🔤 **Alphanumeric characters** (`A-Z`, `a-z`, `0-9`)
- ➕ Two special characters: `+` and `/`
- 🛑 Padding character: `=` (if required)

### Why "Base64"?  
The term comes from the fact that it uses **64 distinct characters** to represent the encoded data. 🔢


## 🛠️ Why Use Base64?

Base64 is used to:

1. 🌐 **Transmit Binary Data**: In text-based systems like HTTP, email, or JSON, binary data (e.g., images, files) needs to be converted to text.
2. 🔒 **Preserve Data Integrity**: Binary data may become corrupted when transmitted over text-based protocols. 🛡️
3. 📋 **Ensure Compatibility**: Base64 ensures safe transmission of data in systems that only accept text. ✅


## ⚙️ How Base64 Works 🧩

The encoding process involves three steps:

1. **Convert Input to Binary 🔢**: Each character is converted to its binary form (ASCII value).
2. **Group Bits 🧮**: The binary data is divided into 6-bit groups (as Base64 uses 64 characters, and \(2^6 = 64\)).
3. **Map to Base64 Characters 🗺️**: Each 6-bit group is mapped to a Base64 character from this set:
   ```
   A-Z, a-z, 0-9, +, /
   ```
4. **Add Padding ➕**: If the input isn’t a multiple of 3 bytes (24 bits), padding (`=`) is added. 🛑


## 🔐 What is the Authorization Header?

The `Authorization` header is an **HTTP header** used to send authentication credentials to a server. This header allows the client to **identify itself** to the server by sending credentials such as a username and password.

### How Does It Work? ⚙️

1. 🌐 **Client Request**: The client sends the `Authorization` header as part of an HTTP request. 
2. 📜 **Format**:
   ```
   Authorization: <authentication type> <credentials>
   ```
   - **Authentication type**: Specifies the authentication method (e.g., `Basic` for Basic Authentication).
   - **Credentials**: Encoded credentials such as a username and password.
3. 🛡️ **Server Validation**: The server reads the `Authorization` header, validates the credentials, and allows or denies access.


### Example of the `Authorization` Header

For **Basic Authentication**, the `Authorization` header format is:

```
Authorization: Basic <Base64-encoded-credentials>
```

#### Example:
If the username is `Muhammad Hashim` and the password is `password`:
1. Combine the username and password:
   ```
   Muhammad Hashim:password
   ```
2. Encode this string using Base64:
   ```
   TXVoYW1tYWQgSGFzaGltOnBhc3N3b3Jk
   ```
3. Add it to the `Authorization` header:
   ```
   Authorization: Basic TXVoYW1tYWQgSGFzaGltOnBhc3N3b3Jk
   ```


## 📜 Examples with Code 💻

### Encoding in Python 🐍

Let’s encode the string `Muhammad Hashim:password`. 🔑

```python
import base64

# Original string
data = "Muhammad Hashim:password"

# Encoding to Base64
encoded_data = base64.b64encode(data.encode())

print("Encoded:", encoded_data.decode())
```

**🖥️ Output**:
```
Encoded: TXVoYW1tYWQgSGFzaGltOnBhc3N3b3Jk
```


### Decoding in Python 🐍

Now, let’s decode the Base64-encoded string back to its original form. 🔍

```python
import base64

# Encoded string
encoded_data = "TXVoYW1tYWQgSGFzaGltOnBhc3N3b3Jk"

# Decoding from Base64
decoded_data = base64.b64decode(encoded_data).decode()

print("Decoded:", decoded_data)
```

**🖥️ Output**:
```
Decoded: Muhammad Hashim:password
```


## 🔑 What is Basic Authentication?

**Basic Authentication** is a simple HTTP authentication mechanism that requires the client to send a username and password with every request. 

- These credentials are encoded using Base64 and sent in the HTTP `Authorization` header.
- The server decodes and validates the credentials to authenticate the user.


## 🔐 Basic Authentication Example with Django CBV

Here’s how to implement Basic Authentication using Django **Class-Based Views (CBVs)**:

### Step 1: Create a Class-Based View to Handle Authentication

```python
from django.http import JsonResponse
from django.views import View
from base64 import b64decode

# Hardcoded credentials for demonstration
USERNAME = "Muhammad Hashim"
PASSWORD = "password"

class BasicAuthView(View):
    def get(self, request, *args, **kwargs):
        auth_header = request.headers.get("Authorization")

        # If no Authorization header is provided
        if not auth_header or not auth_header.startswith("Basic "):
            response = JsonResponse({"message": "Unauthorized"})
            response.status_code = 401
            response["WWW-Authenticate"] = 'Basic realm="Access to the secure area"'
            return response

        # Decode Base64 credentials
        base64_credentials = auth_header.split(" ")[1]
        decoded_credentials = b64decode(base64_credentials).decode()
        username, password = decoded_credentials.split(":")

        # Validate credentials
        if username == USERNAME and password == PASSWORD:
            return JsonResponse({"message": "Access granted!"})

        # Invalid credentials
        response = JsonResponse({"message": "Unauthorized"})
        response.status_code = 401
        return response
```


### Step 2: Add the Class-Based View to `urls.py`

```python
from django.urls import path
from .views import BasicAuthView

urlpatterns = [
    path('secure-data/', BasicAuthView.as_view(), name='basic_auth'),
]
```


### Client Side: Using Python `requests`

```python
import requests
from requests.auth import HTTPBasicAuth

# Django server URL
url = "http://127.0.0.1:8000/secure-data/"

# Credentials
username = "Muhammad Hashim"
password = "password"

# Send request with Basic Authentication
response = requests.get(url, auth=HTTPBasicAuth(username, password))

print("Response:", response.json())
```


## 💡 Detailed Logic of `BasicAuthView`

### 1️⃣ Extracting the Authorization Header
- The `Authorization` header is retrieved from the request headers.
- If the header is missing or invalid, a `401 Unauthorized` response is returned with a `WWW-Authenticate` header.

### 2️⃣ Decoding Base64 Credentials
- The `Authorization` header value (`Basic <Base64 string>`) is split, and the Base64 credentials are decoded.
- The decoded string is in the format `username:password`.

### 3️⃣ Validating Credentials
- The decoded credentials are compared with predefined username and password values.
- If the credentials match, access is granted; otherwise, a `401 Unauthorized` response is returned.


## 🔒 Is Base64 Secure?

🚨 **Base64 is NOT encryption!** It’s only an encoding technique! 🛡️ Always use HTTPS to secure communication.