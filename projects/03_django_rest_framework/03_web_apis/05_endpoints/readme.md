# 🌐 Endpoints & HTTP

## 1. Endpoints 🔗

In a traditional website, we deal with web pages like `example.com/1/`, which serve HTML, CSS, JavaScript, images, and other resources. But when it comes to **web APIs**, things are a little different. Web APIs still use URLs, but instead of delivering webpages for humans to view, they provide **API endpoints** that contain **data**—usually in the JSON format.


### What is an Endpoint? 🚪

An **API endpoint** is a specific **URL** that serves **data** rather than a webpage. Each endpoint typically responds with JSON (a lightweight format for data exchange) 📦 and allows certain actions like **GET**, **POST**, **PUT**, and **DELETE** via **HTTP verbs**.

### Example 🌟

Let’s say we have a new website called **mysite**. Here are two example endpoints:

| **Endpoint**                               | **Description**                              |
---|
| `https://www.mysite.com/api/users`         | **GET** – Returns all users (a collection)   |
| `https://www.mysite.com/api/users/<id>`    | **GET** – Returns a specific user (an individual resource) |


### Endpoint Breakdown 💡

1. **GET** `/api/users`:  
   - This endpoint returns a **list of all users**. It’s what we call a **collection endpoint** because it fetches multiple resources (in this case, users).
  
2. **GET** `/api/users/<id>`:  
   - This endpoint returns information about a **specific user** based on their unique ID. It’s a **single resource endpoint** because it retrieves data for just one user.


### CRUD Operations with Endpoints 🔄

Endpoints work together with HTTP verbs to manage **CRUD operations**:

- **Create** (`POST`): We can create a new resource by sending a `POST` request to `/api/users`.
- **Read** (`GET`): We can read data by sending a `GET` request to `/api/users` (all users) or `/api/users/<id>` (a single user).
- **Update** (`PUT`): We can update a user’s information by sending a `PUT` request to `/api/users/<id>`.
- **Delete** (`DELETE`): We can remove a user by sending a `DELETE` request to `/api/users/<id>`.

These **endpoints** allow us to interact with the server in different ways using **HTTP verbs**.


## 2. HTTP – How the Web Communicates 🌐

Now that we’ve talked about **endpoints**, let’s dive into **HTTP** (Hypertext Transfer Protocol), which is the communication method used between a **client** (like your browser) and a **server** (the computer where the website or API is hosted).


### How HTTP Works 🛠️

**HTTP** is a **request-response** protocol that operates over an existing **TCP connection**. The client (often a browser, but it could also be an app or another device) sends a **request** to the server, and the server sends a **response** back. This is how the web works!

- The **client** makes the request 📩.
- The **server** responds with data 📬.

#### Example 🌟

Imagine you want to access **Google’s homepage**:

1. You type `https://www.google.com` into your browser.
2. Your browser sends a **GET** request to Google’s server asking for the homepage.
3. The server sends back a **response** with the HTML, CSS, and images that make up the Google homepage.
4. Your browser then displays the page on your screen!


### HTTP Request Components 📤

Every **HTTP request** has three main parts:

1. **Request line**: Contains the **HTTP method** (like `GET`), the **path** (e.g., `/`), and the **HTTP version** (e.g., `HTTP/1.1`).
2. **Headers**: Provide extra information about the request, such as the domain and accepted language.
3. **Body** (optional): Used when sending data (like when making a `POST` request to submit a form).

#### Example 🌟

Here’s what a **GET request** for Google’s homepage might look like:

```
GET / HTTP/1.1
Host: google.com
Accept_Language: en-US
```

- **GET** is the HTTP method.
- `/` is the path (homepage).
- `Host: google.com` tells the server the domain we are accessing.
- `Accept_Language: en-US` tells the server that we prefer American English.


### HTTP Response Components 📥

Once the server processes the request, it sends back an **HTTP response**. Like requests, responses also have three main parts:

1. **Response line**: Contains the **HTTP version** (e.g., `HTTP/1.1`), a **status code** (e.g., `200 OK` for success), and a **status message**.
2. **Headers**: Provide additional info like the content type and content length.
3. **Body** (optional): Contains the actual data being sent back, such as HTML or JSON.

#### Example 🌟

If Google’s homepage were a simple "Hello, World!" page, the response might look like this:

```
HTTP/1.1 200 OK
Date: Mon, 24 Jan 2022 23:26:07 GMT
Server: gws
Accept-Ranges: bytes
Content-Length: 13
Content-Type: text/html; charset=UTF-8

Hello, world!
```

- **HTTP/1.1** is the version of HTTP used.
- `200 OK` means the request was successful.
- **Headers** provide details about the response, such as the content type (`text/html`) and length (13 bytes).
- The **body** contains the actual content, in this case, `"Hello, world!"`.


### HTTP Message Format 📦

Both **HTTP requests** and **HTTP responses** follow the same format:

```
Request/Response Line
Headers...
(optional) Body
```


## Multiple HTTP Requests and Responses 🔄

Most web pages are made up of multiple resources, such as HTML, CSS, JavaScript, and images. To load a complete page, multiple **HTTP request/response cycles** are required. For example, if a webpage has:

- **HTML** (structure)
- **CSS** (styles)
- **Images** (media)

The browser needs to make separate **requests** for each resource:

1. One request for the HTML.
2. Another request for the CSS file.
3. A third request for the image.

This back-and-forth between the client and the server happens every time you load a webpage! 🌐💻


## Recap 🎯

- **Endpoints** are URLs that serve **data** (usually JSON) instead of webpages.
- **HTTP** is the protocol that governs communication between a **client** and a **server**.
- HTTP requests consist of a **request line**, **headers**, and an optional **body**.
- HTTP responses consist of a **response line**, **headers**, and an optional **body**.
