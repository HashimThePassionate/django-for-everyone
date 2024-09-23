# 🔄 HTTP Status Codes

Once your browser sends an **HTTP request** to a server (for example, when you visit a website), things don’t always go smoothly! 🛑 That’s why the server responds with an **HTTP status code** to tell the browser what happened with the request.

## Understanding HTTP Status Codes 🔍

HTTP status codes are **three-digit numbers** that accompany every HTTP response. These codes help your browser (and you) understand what happened during the request. Based on the code, you’ll know if:

- ✅ The request was **successful**.
- 🔀 The resource has been **redirected**.
- ❌ There was a **client error** (something wrong with your request).
- ⚠️ There was a **server error** (the server couldn’t process the request).

### How to Read Status Codes 🧠

You can tell what a status code means just by looking at the first digit:

- **2xx** – ✅ **Success**: The action was received, understood, and accepted.
- **3xx** – 🔀 **Redirection**: The resource has moved to a different URL.
- **4xx** – ❌ **Client Error**: Something went wrong on the client’s side (bad request).
- **5xx** – ⚠️ **Server Error**: Something went wrong on the server’s side.

## Most Common HTTP Status Codes 🌟

Below is a table of the most important HTTP status codes that are used in web development. These are the codes you’ll encounter **90%** of the time!

| **Status Code** | **Meaning**           | **Explanation**                                                                                                                                 |
|-----------------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| **200**         | ✅ **OK**              | The request was successful, and the server returned the requested resource. For example, when you successfully load a webpage.                    |
| **201**         | ✅ **Created**         | A new resource was successfully created. Often used after a `POST` request, like when you create a new user or blog post.                         |
| **204**         | ✅ **No Content**      | The request was successful, but there’s no content to send back. Typically used when updating a resource (`PUT`) without needing a response body.  |
| **301**         | 🔀 **Moved Permanently** | The requested resource has been permanently moved to a new URL. This often happens when a webpage changes its address.                           |
| **302**         | 🔀 **Found**           | The resource is temporarily located at a different URL, but will return to the original one. Useful for temporary redirects.                      |
| **304**         | 🔀 **Not Modified**    | The resource has not been modified since the last request. The browser uses the cached version instead of downloading it again.                    |
| **400**         | ❌ **Bad Request**     | The server couldn't understand the request due to invalid syntax. This usually happens when the client (browser or app) makes an incorrect request.|
| **401**         | ❌ **Unauthorized**    | The client needs to authenticate itself to access the requested resource. Usually seen on protected pages that require login credentials.           |
| **403**         | ❌ **Forbidden**       | The client is authenticated but does not have permission to access the resource. For example, trying to access restricted admin pages.              |
| **404**         | ❌ **Not Found**       | The requested resource could not be found. This is the classic "Page not found" error when a URL doesn’t exist.                                   |
| **405**         | ❌ **Method Not Allowed**| The HTTP method used (GET, POST, etc.) is not allowed for this resource.                                                                          |
| **500**         | ⚠️ **Internal Server Error** | The server encountered an unexpected condition and couldn’t complete the request. Commonly occurs when there’s a bug in the server’s code.         |
| **502**         | ⚠️ **Bad Gateway**     | The server received an invalid response from the upstream server. This can happen when using proxy servers or when services fail to communicate.    |
| **503**         | ⚠️ **Service Unavailable** | The server is currently unavailable, often due to maintenance or overload.                                                                         |
| **504**         | ⚠️ **Gateway Timeout** | The server did not receive a response in time from another server it needed to complete the request. This often happens with overloaded networks.   |

---

## Key Status Codes in Detail 🧐

Here’s a closer look at some of the most frequently encountered status codes:

### 1. **200 OK** ✅

- **Meaning**: The request was processed successfully, and the server returned the requested resource (like a webpage).
- **When You’ll See It**: Most often, you’ll see this when a website loads correctly in your browser.

### 2. **201 Created** ✅

- **Meaning**: A new resource was successfully created on the server.
- **When You’ll See It**: You’ll encounter this after successfully creating something on a site, such as a new user account or blog post.

### 3. **204 No Content** ✅

- **Meaning**: The request was successful, but there’s no content to return.
- **When You’ll See It**: This is often used when you’ve updated or deleted something, and there’s no need to send back any data.

### 4. **301 Moved Permanently** 🔀

- **Meaning**: The resource has been permanently moved to a new URL.
- **When You’ll See It**: You’ll get this when a webpage has changed its address permanently. Your browser will automatically be redirected to the new URL.

### 5. **404 Not Found** ❌

- **Meaning**: The requested resource couldn’t be found on the server.
- **When You’ll See It**: This is the famous "404 error" when a webpage doesn’t exist or the URL is wrong.

### 6. **500 Internal Server Error** ⚠️

- **Meaning**: Something went wrong on the server, and it couldn’t process the request.
- **When You’ll See It**: This usually happens when there’s a bug or issue on the server itself, causing it to crash or fail unexpectedly.

## How Status Codes Work in HTTP Messages 📥📤

In an **HTTP message**, the status code is placed in the **request/response line** at the top. Here’s what a typical HTTP request and response might look like:

### HTTP Request Example 📤

```
GET /home HTTP/1.1
Host: www.example.com
```

### HTTP Response Example 📥

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1234

<!DOCTYPE html>
<html>
<body>
   <h1>Hello, world!</h1>
</body>
</html>
```

In the response, the status line shows:

- **HTTP version**: `HTTP/1.1`
- **Status code**: `200`
- **Status message**: `OK`


## Conclusion 🎯

Understanding **HTTP status codes** is crucial for diagnosing and troubleshooting web issues. The most common codes like `200 OK`, `404 Not Found`, and `500 Internal Server Error` will be the ones you encounter most frequently. But knowing how to interpret other status codes like `301 Moved Permanently` or `401 Unauthorized` can help you understand what's happening behind the scenes in web applications! 🌐