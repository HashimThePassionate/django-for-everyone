### 🌐 What is an **HttpOnly Cookie**?

An **HttpOnly cookie** is a type of cookie that cannot be accessed by JavaScript running in the browser. It is a flag used when setting a cookie to ensure it is only sent with HTTP requests to the server, making it more secure and reducing the risk of cross-site scripting (XSS) attacks.


### 🔒 Benefits of HttpOnly Cookies

1. **Improved Security**:
   - The cookie cannot be accessed or manipulated by client-side scripts, reducing the risk of XSS attacks.
   
2. **Authentication Tokens**:
   - Commonly used to store sensitive tokens (like session IDs, JWTs, or CSRF tokens) securely.
   
3. **Mitigate Script Injection**:
   - Prevents malicious JavaScript from stealing sensitive cookie data.


### 🛠️ How to Set an HttpOnly Cookie

#### Example in Django:

```python
from django.http import HttpResponse

def set_cookie_view(request):
    response = HttpResponse("HttpOnly cookie has been set!")
    response.set_cookie(
        key="auth_token",            # Name of the cookie
        value="secure_token_value",  # Value of the cookie
        httponly=True,               # HttpOnly flag
        secure=True,                 # Send over HTTPS only
        samesite="Strict"            # Prevent cross-site requests
    )
    return response
```

Explanation:
- **`key`**: The name of the cookie (e.g., `auth_token`).
- **`value`**: The value of the cookie (e.g., `secure_token_value`).
- **`httponly=True`**: Ensures the cookie is only accessible via HTTP requests, not JavaScript.
- **`secure=True`**: Ensures the cookie is only sent over HTTPS.
- **`samesite="Strict"`**: Restricts cross-origin requests from including the cookie.


#### Example Response Header:

When the client receives the HTTP response, the cookie is set like this:

```http
Set-Cookie: auth_token=secure_token_value; Path=/; Secure; HttpOnly; SameSite=Strict
```


### 🖥️ Example of Using HttpOnly Cookie in Authentication

#### 1️⃣ Server Sets the Cookie:

The server sets an HttpOnly cookie when a user logs in.

```python
from django.http import JsonResponse

def login_view(request):
    # Assume successful login
    response = JsonResponse({"message": "Login successful!"})
    response.set_cookie(
        key="auth_token",
        value="secure_jwt_token",
        httponly=True,
        secure=True,
        samesite="Lax"
    )
    return response
```

#### 2️⃣ Client Includes the Cookie in Subsequent Requests:

The browser automatically sends the HttpOnly cookie with each request to the server.

```http
GET /api/secure-data/ HTTP/1.1
Host: example.com
Cookie: auth_token=secure_jwt_token
```


### 🚫 Why HttpOnly Cookies Protect Against XSS

If a malicious script tries to access the cookie using `document.cookie`, it won’t work for HttpOnly cookies:

#### Malicious JavaScript Example:

```javascript
// Attempt to access cookies
console.log(document.cookie); // Output: ""
```

