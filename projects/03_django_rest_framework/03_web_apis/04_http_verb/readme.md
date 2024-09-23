# 🔄 HTTP Verbs

## What Are HTTP Verbs? 🤔

Every webpage you visit not only has an **address** (its URL) 🌍, but also a set of approved actions you can perform on it, known as **HTTP verbs**. These verbs tell the web server **what kind of action** you want to take when you interact with a webpage.

So far, we’ve mostly talked about **getting** a web page (using the `GET` request), but the web allows for more than just viewing content. You can also:

- 📝 **Create** new content (like making a new post).
- 🛠️ **Update** existing content (like editing your profile).
- ❌ **Delete** content (like removing a comment).

These actions are common online and are known as **CRUD operations**: **Create, Read, Update, Delete**. 🛠️🔄

## CRUD Operations and HTTP Verbs 🔄

### What is CRUD? 🛠️

CRUD stands for the four main operations you can perform on data:

1. **Create**: Add new data.
2. **Read**: View or retrieve existing data.
3. **Update**: Modify or edit existing data.
4. **Delete**: Remove data.

These actions are the core of almost everything you do on the web. For example, on Facebook, after logging in:

- You can **read** your timeline (view posts).
- **Create** a new post.
- **Edit** an existing post.
- **Delete** an old post.

Each of these actions is mapped to a specific **HTTP verb** in web communication. Let’s see how they align:

### CRUD Operations and Their HTTP Verbs ⚙️

| **CRUD Operation** | **HTTP Verb**  |-|
| 📝 **Create**      | `POST`          |
| 👁️ **Read**        | `GET`           |
| 🛠️ **Update**      | `PUT` (or `PATCH`)|
| ❌ **Delete**       | `DELETE`        |

Let’s break down each HTTP verb and understand what they do:

### 1. **POST** – Create New Content 📝

When you want to **create** something new (e.g., writing a new blog post, uploading a new photo), you use the `POST` method.

- **Example**: When you hit "Post" on Facebook to share a new status, your browser sends a `POST` request to the server with the data (your status message). The server then **creates** the post on your timeline.
### 2. **GET** – Read Existing Content 👁️

The `GET` method is used to **retrieve** or **read** existing content. It’s the most common method, and it’s what happens when you type a URL in your browser and hit **Enter**.

- **Example**: When you visit your Facebook timeline to view posts, your browser sends a `GET` request to the server, asking for all the posts to be displayed.
### 3. **PUT** – Update Content 🛠️

When you want to **update** or modify existing content, the `PUT` method is used. It replaces the entire resource with new information. However, for **partial updates**, you might use the `PATCH` method instead of `PUT`.

- **Example**: If you edit your Facebook status after posting it (changing the text), the browser sends a `PUT` request to the server with the updated content, and the server replaces the old post with the new version.
### 4. **DELETE** – Remove Content ❌

To **delete** content, the `DELETE` method is used. When you decide to remove a post, comment, or file, this request deletes the specified content from the server.

- **Example**: If you delete a post on Facebook, your browser sends a `DELETE` request to the server, which then removes the post from your timeline.

## Summary Table 📝

Here’s a quick reference to remember how CRUD operations and HTTP verbs map to each other:

| **CRUD Action**   | **HTTP Verb**  | **Action**                                |-|
| 📝 **Create**      | `POST`         | Create new content (e.g., new post, new user) |
| 👁️ **Read**        | `GET`          | Retrieve existing content (e.g., view posts)  |
| 🛠️ **Update**      | `PUT`/`PATCH`  | Update existing content (e.g., edit profile)  |
| ❌ **Delete**       | `DELETE`       | Remove content (e.g., delete a comment)      |

### Example Scenario 🌐

Let’s say you’re using a **blog website**. Here’s how the CRUD operations and HTTP verbs would work:

1. **Create** a new blog post 📝:
   - You write your post and hit "Publish."
   - A `POST` request is sent to the server to create the post.
   
2. **Read** a blog post 👁️:
   - You visit the blog homepage to read a post.
   - A `GET` request is made to retrieve the blog posts from the server.

3. **Update** a blog post 🛠️:
   - You decide to edit your post by fixing a typo.
   - A `PUT` or `PATCH` request is sent to update the post with the corrected text.

4. **Delete** a blog post ❌:
   - You no longer want the post, so you delete it.
   - A `DELETE` request is sent to remove the post from the server.

## Real-World Example 🌍

Imagine you are working on an **e-commerce website**:

- **POST** 📝: Add a new product to the store’s catalog.
- **GET** 👁️: View all products listed on the store.
- **PUT** 🛠️: Update the price of an existing product.
- **DELETE** ❌: Remove an out-of-stock product from the catalog.

This is how almost every web application operates behind the scenes using HTTP verbs! 🚀🌐