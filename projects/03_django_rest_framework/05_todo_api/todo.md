# 📝 **Todo App HTML code** ✨

Welcome to the **Todo App**! This application allows you to manage your tasks efficiently with a sleek and responsive interface. Built using Django and Bootstrap, it offers a seamless experience for creating, updating, and deleting your todos. 🚀

---

## 📑 Table of Contents

1. [🔍 Introduction](#-introduction)
2. [✨ Features](#-features)
3. [🛠 Technologies Used](#-technologies-used)
4. [📂 Project Structure](#-project-structure)
5. [⚙️ Installation](#️-installation)
6. [🚀 Usage](#-usage)
7. [💡 Detailed Code Explanation](#-detailed-code-explanation)
   - [🔗 HTML Structure](#-html-structure)
   - [🎨 CSS Styling](#-css-styling)
   - [💻 JavaScript Functionality](#-javascript-functionality)
8. [🤝 Contributing](#-contributing)
9. [📜 License](#-license)

---

## 🔍 Introduction

The **Todo App** is a simple yet powerful tool designed to help you keep track of your tasks. Whether you're managing personal errands or professional projects, this app provides an intuitive interface to streamline your workflow. 📈

---

## ✨ Features

- **Create Todos** 🆕: Easily add new tasks with a title and description.
- **Update Todos** ✏️: Modify existing tasks to reflect changes.
- **Delete Todos** 🗑️: Remove tasks that are no longer needed.
- **Responsive Design** 📱: Seamless experience across all devices.
- **User Feedback** ✅❌: Receive instant success and error messages.

---

## 🛠 Technologies Used

- **Backend**: Django 🐍
- **Frontend**: HTML5, CSS3, JavaScript
- **Styling**: Bootstrap 5 🎨
- **Icons**: Bootstrap Icons 🔣

---

## 📂 Project Structure

```
django_project/
├── todos/
│   ├── templates/
│   │   └── todos.html
│   ├── static/
│   ├── views.py
│   ├── urls.py
│   ├── models.py
│   └── serializers.py
├── django_project/
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── manage.py
```

---

## ⚙️ Installation

1. **Clone the Repository** 📥

   ```bash
   git clone https://github.com/yourusername/todo-app.git
   cd todo-app
   ```

2. **Create a Virtual Environment** 🐍

   ```bash
   python3 -m venv env
   source env/bin/activate
   ```

3. **Install Dependencies** 📦

   ```bash
   pip install -r requirements.txt
   ```

4. **Apply Migrations** 🔧

   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. **Run the Server** 🚀

   ```bash
   python manage.py runserver
   ```

6. **Access the App** 🌐

   Open your browser and navigate to `http://localhost:8000/`

---

## 🚀 Usage

- **Add a Todo**: Click on the "Add Todo" button, fill in the details, and submit.
- **Edit a Todo**: Click on the "Edit" button next to a todo, modify the details, and update.
- **Delete a Todo**: Click on the "Delete" button next to a todo and confirm the deletion.

---

## 💡 Detailed Code Explanation

Dive deep into the code to understand how the Todo App functions. We'll break down each section with explanations and emojis for clarity.

### 🔗 HTML Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Todo App</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* Custom Styling for Light Theme */
        body {
            background-color: #f8f9fa;
            color: #212529;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .modal-content {
            /* No custom background color to use Bootstrap's default */
        }
        .table thead th {
            background-color: #e9ecef;
        }
        .alert-custom {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
            min-width: 250px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1 class="text-center mb-4">Todo List</h1>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createModal">
            <i class="bi bi-plus-lg"></i> Add Todo
        </button>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Body</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="todo-table-body">
                    <!-- Todo items will be inserted here -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Success Alert -->
    <div id="success-alert" class="alert alert-success alert-dismissible fade show alert-custom" role="alert" style="display: none;">
        <span id="success-message"></span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <!-- Error Alert -->
    <div id="error-alert" class="alert alert-danger alert-dismissible fade show alert-custom" role="alert" style="display: none;">
        <span id="error-message"></span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <!-- Create Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="createModalLabel">Add New Todo</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="create-todo-form">
              <div class="mb-3">
                <label for="create-title" class="form-label">Title</label>
                <input type="text" class="form-control" id="create-title" required>
              </div>
              <div class="mb-3">
                <label for="create-body" class="form-label">Body</label>
                <textarea class="form-control" id="create-body" rows="3" required></textarea>
              </div>
              <button type="submit" class="btn btn-primary w-100">Create</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="updateModalLabel">Update Todo</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="update-todo-form">
              <input type="hidden" id="update-id">
              <div class="mb-3">
                <label for="update-title" class="form-label">Title</label>
                <input type="text" class="form-control" id="update-title" required>
              </div>
              <div class="mb-3">
                <label for="update-body" class="form-label">Body</label>
                <textarea class="form-control" id="update-body" rows="3" required></textarea>
              </div>
              <button type="submit" class="btn btn-primary w-100">Update</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="deleteModalLabel">Delete Todo</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Are you sure you want to delete this todo?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="button" class="btn btn-danger" id="confirm-delete-btn">Delete</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript for CRUD operations -->
    <script>
        const apiBaseUrl = '/api/';

        let deleteTodoId = null;

        // Fetch and display todos
        async function fetchTodos() {
            try {
                const response = await fetch(apiBaseUrl);
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const todos = await response.json();
                const tableBody = document.getElementById('todo-table-body');
                tableBody.innerHTML = '';
                todos.forEach(todo => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${todo.id}</td>
                        <td>${todo.title}</td>
                        <td>${todo.body}</td>
                        <td>
                            <button class="btn btn-secondary btn-sm me-2" onclick="openUpdateModal(${todo.id})">
                                <i class="bi bi-pencil-square"></i> Edit
                            </button>
                            <button class="btn btn-danger btn-sm" onclick="openDeleteModal(${todo.id})">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </td>
                    `;
                    tableBody.appendChild(row);
                });
            } catch (error) {
                console.error('Error fetching todos:', error);
                showError('Failed to fetch todos.');
            }
        }

        // Show success alert
        function showSuccess(message) {
            const successAlert = document.getElementById('success-alert');
            const successMessage = document.getElementById('success-message');
            successMessage.textContent = message;
            successAlert.style.display = 'block';
            setTimeout(() => {
                const alert = new bootstrap.Alert(successAlert);
                alert.close();
            }, 3000);
        }

        // Show error alert
        function showError(message) {
            const errorAlert = document.getElementById('error-alert');
            const errorMessage = document.getElementById('error-message');
            errorMessage.textContent = message;
            errorAlert.style.display = 'block';
            setTimeout(() => {
                const alert = new bootstrap.Alert(errorAlert);
                alert.close();
            }, 5000);
        }

        // Create todo
        document.getElementById('create-todo-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const title = document.getElementById('create-title').value.trim();
            const body = document.getElementById('create-body').value.trim();

            if (!title || !body) {
                showError('Please fill in all fields.');
                return;
            }

            try {
                const response = await fetch(apiBaseUrl + 'create/', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                    },
                    body: JSON.stringify({ title, body }),
                });
                if (!response.ok) {
                    throw new Error('Failed to create todo');
                }
                document.getElementById('create-todo-form').reset();
                const createModal = bootstrap.Modal.getInstance(document.getElementById('createModal'));
                createModal.hide();
                fetchTodos();
                showSuccess('Todo created successfully.');
            } catch (error) {
                console.error('Error creating todo:', error);
                showError('Failed to create todo.');
            }
        });

        // Open update modal and populate data
        async function openUpdateModal(id) {
            try {
                const response = await fetch(`${apiBaseUrl}${id}/`);
                if (!response.ok) {
                    throw new Error('Failed to fetch todo details');
                }
                const todo = await response.json();
                document.getElementById('update-id').value = todo.id;
                document.getElementById('update-title').value = todo.title;
                document.getElementById('update-body').value = todo.body;
                const updateModal = new bootstrap.Modal(document.getElementById('updateModal'));
                updateModal.show();
            } catch (error) {
                console.error('Error fetching todo details:', error);
                showError('Failed to fetch todo details.');
            }
        }

        // Update todo
        document.getElementById('update-todo-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const id = document.getElementById('update-id').value;
            const title = document.getElementById('update-title').value.trim();
            const body = document.getElementById('update-body').value.trim();

            if (!title || !body) {
                showError('Please fill in all fields.');
                return;
            }

            try {
                const response = await fetch(`${apiBaseUrl}${id}/delete/`, { // Using 'delete/' endpoint for update as per your URLs
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                    },
                    body: JSON.stringify({ title, body }),
                });
                if (!response.ok) {
                    throw new Error('Failed to update todo');
                }
                document.getElementById('update-todo-form').reset();
                const updateModal = bootstrap.Modal.getInstance(document.getElementById('updateModal'));
                updateModal.hide();
                fetchTodos();
                showSuccess('Todo updated successfully.');
            } catch (error) {
                console.error('Error updating todo:', error);
                showError('Failed to update todo.');
            }
        });

        // Open delete confirmation modal
        function openDeleteModal(id) {
            deleteTodoId = id;
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }

        // Confirm delete
        document.getElementById('confirm-delete-btn').addEventListener('click', async () => {
            if (!deleteTodoId) return;
            try {
                const response = await fetch(`${apiBaseUrl}${deleteTodoId}/delete/`, {
                    method: 'DELETE',
                    headers: {
                        'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                    },
                });
                if (!response.ok) {
                    throw new Error('Failed to delete todo');
                }
                const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
                deleteModal.hide();
                fetchTodos();
                showSuccess('Todo deleted successfully.');
            } catch (error) {
                console.error('Error deleting todo:', error);
                showError('Failed to delete todo.');
            } finally {
                deleteTodoId = null;
            }
        });

        // Function to get CSRF token from cookies (if CSRF protection is enabled)
        function getCookie(name) {
            let cookieValue = null;
            if (document.cookie && document.cookie !== '') {
                const cookies = document.cookie.split(';');
                for (let i = 0; i < cookies.length; i++) {
                    const cookie = cookies[i].trim();
                    // Does this cookie string begin with the name we want?
                    if (cookie.substring(0, name.length + 1) === (name + '=')) {
                        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                        break;
                    }
                }
            }
            return cookieValue;
        }

        // Initial fetch
        fetchTodos();
    </script>
</body>
</html>
```

---

### 🔗 HTML Structure Explained

Let's break down the HTML code to understand how each part contributes to the Todo App's functionality and appearance. 📚

#### 1. **DOCTYPE and HTML Tag**

```html
<!DOCTYPE html>
<html lang="en">
```
- **`<!DOCTYPE html>`**: Declares the document type and version of HTML.
- **`<html lang="en">`**: Defines the root of the HTML document and sets the language to English.

#### 2. **Head Section**

```html
<head>
    <meta charset="UTF-8">
    <title>Todo App</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* Custom Styling for Light Theme */
        body {
            background-color: #f8f9fa;
            color: #212529;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .modal-content {
            /* No custom background color to use Bootstrap's default */
        }
        .table thead th {
            background-color: #e9ecef;
        }
        .alert-custom {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
            min-width: 250px;
        }
    </style>
</head>
```

- **`<meta charset="UTF-8">`** 📝: Specifies the character encoding for the HTML document.
- **`<title>Todo App</title>`** 🏷️: Sets the title of the webpage displayed on the browser tab.
- **Bootstrap CSS** 🎨:
  ```html
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  ```
  - Integrates Bootstrap for responsive design and pre-built components.
- **Bootstrap Icons** 🔣:
  ```html
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  ```
  - Adds access to a wide range of icons for better visual representation.
- **Custom CSS** 🎨:
  ```css
  <style>
      /* Custom Styling for Light Theme */
      body {
          background-color: #f8f9fa;
          color: #212529;
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      .modal-content {
          /* No custom background color to use Bootstrap's default */
      }
      .table thead th {
          background-color: #e9ecef;
      }
      .alert-custom {
          position: fixed;
          top: 20px;
          right: 20px;
          z-index: 1055;
          min-width: 250px;
      }
  </style>
  ```
  - **`body`**: Sets a light background and dark text for better readability.
  - **`.modal-content`**: Uses Bootstrap's default modal styling without modifications.
  - **`.table thead th`**: Applies a light gray background to table headers.
  - **`.alert-custom`**: Positions alerts fixed at the top-right corner with appropriate sizing.

#### 3. **Body Section**

```html
<body>
    <div class="container my-5">
        <h1 class="text-center mb-4">Todo List</h1>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createModal">
            <i class="bi bi-plus-lg"></i> Add Todo
        </button>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Body</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="todo-table-body">
                    <!-- Todo items will be inserted here -->
                </tbody>
            </table>
        </div>
    </div>
```

- **`<div class="container my-5">`** 📦: Creates a Bootstrap container with vertical margins for spacing.
- **`<h1 class="text-center mb-4">Todo List</h1>`** 🎯: Displays the main heading centered with bottom margin.
- **Add Todo Button** ➕:
  ```html
  <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createModal">
      <i class="bi bi-plus-lg"></i> Add Todo
  </button>
  ```
  - **`class="btn btn-primary mb-3"`**: Styles the button with Bootstrap's primary color and bottom margin.
  - **`data-bs-toggle="modal" data-bs-target="#createModal"`**: Triggers the Create Modal when clicked.
  - **`<i class="bi bi-plus-lg"></i>`**: Adds a plus icon before the "Add Todo" text for better visual cues.
- **Todo Table** 📋:
  ```html
  <div class="table-responsive">
      <table class="table table-striped table-hover">
          <thead>
              <tr>
                  <th>ID</th>
                  <th>Title</th>
                  <th>Body</th>
                  <th>Actions</th>
              </tr>
          </thead>
          <tbody id="todo-table-body">
              <!-- Todo items will be inserted here -->
          </tbody>
      </table>
  </div>
  ```
  - **`class="table-responsive"`** 📱: Makes the table horizontally scrollable on smaller screens.
  - **`class="table table-striped table-hover"`**: Applies Bootstrap's striped rows and hover effects for better readability.
  - **Table Headers** 📝: Defines the columns for ID, Title, Body, and Actions.
  - **`<tbody id="todo-table-body">`**: Placeholder where JavaScript will dynamically insert todo items.

---

### 🎨 CSS Styling

```css
/* Custom Styling for Light Theme */
body {
    background-color: #f8f9fa;
    color: #212529;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
.modal-content {
    /* No custom background color to use Bootstrap's default */
}
.table thead th {
    background-color: #e9ecef;
}
.alert-custom {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1055;
    min-width: 250px;
}
```

- **`body`** 🖌️:
  - **`background-color: #f8f9fa;`**: Sets a light gray background.
  - **`color: #212529;`**: Uses dark gray text for contrast.
  - **`font-family`**: Applies a modern and clean font for better readability.
- **`.modal-content`** 📦:
  - Uses Bootstrap's default modal styling without additional background color changes.
- **`.table thead th`** 🗂️:
  - **`background-color: #e9ecef;`**: Light gray background for table headers to differentiate them from body rows.
- **`.alert-custom`** ⚠️:
  - **`position: fixed;`**: Keeps alerts in a fixed position on the viewport.
  - **`top: 20px; right: 20px;`**: Positions alerts at the top-right corner.
  - **`z-index: 1055;`**: Ensures alerts appear above other elements.
  - **`min-width: 250px;`**: Sets a minimum width for alerts.

---

### 💻 JavaScript Functionality

```javascript
<script>
    const apiBaseUrl = '/api/';

    let deleteTodoId = null;

    // Fetch and display todos
    async function fetchTodos() {
        try {
            const response = await fetch(apiBaseUrl);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const todos = await response.json();
            const tableBody = document.getElementById('todo-table-body');
            tableBody.innerHTML = '';
            todos.forEach(todo => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${todo.id}</td>
                    <td>${todo.title}</td>
                    <td>${todo.body}</td>
                    <td>
                        <button class="btn btn-secondary btn-sm me-2" onclick="openUpdateModal(${todo.id})">
                            <i class="bi bi-pencil-square"></i> Edit
                        </button>
                        <button class="btn btn-danger btn-sm" onclick="openDeleteModal(${todo.id})">
                            <i class="bi bi-trash"></i> Delete
                        </button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Error fetching todos:', error);
            showError('Failed to fetch todos.');
        }
    }

    // Show success alert
    function showSuccess(message) {
        const successAlert = document.getElementById('success-alert');
        const successMessage = document.getElementById('success-message');
        successMessage.textContent = message;
        successAlert.style.display = 'block';
        setTimeout(() => {
            const alert = new bootstrap.Alert(successAlert);
            alert.close();
        }, 3000);
    }

    // Show error alert
    function showError(message) {
        const errorAlert = document.getElementById('error-alert');
        const errorMessage = document.getElementById('error-message');
        errorMessage.textContent = message;
        errorAlert.style.display = 'block';
        setTimeout(() => {
            const alert = new bootstrap.Alert(errorAlert);
            alert.close();
        }, 5000);
    }

    // Create todo
    document.getElementById('create-todo-form').addEventListener('submit', async (e) => {
        e.preventDefault();
        const title = document.getElementById('create-title').value.trim();
        const body = document.getElementById('create-body').value.trim();

        if (!title || !body) {
            showError('Please fill in all fields.');
            return;
        }

        try {
            const response = await fetch(apiBaseUrl + 'create/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                },
                body: JSON.stringify({ title, body }),
            });
            if (!response.ok) {
                throw new Error('Failed to create todo');
            }
            document.getElementById('create-todo-form').reset();
            const createModal = bootstrap.Modal.getInstance(document.getElementById('createModal'));
            createModal.hide();
            fetchTodos();
            showSuccess('Todo created successfully.');
        } catch (error) {
            console.error('Error creating todo:', error);
            showError('Failed to create todo.');
        }
    });

    // Open update modal and populate data
    async function openUpdateModal(id) {
        try {
            const response = await fetch(`${apiBaseUrl}${id}/`);
            if (!response.ok) {
                throw new Error('Failed to fetch todo details');
            }
            const todo = await response.json();
            document.getElementById('update-id').value = todo.id;
            document.getElementById('update-title').value = todo.title;
            document.getElementById('update-body').value = todo.body;
            const updateModal = new bootstrap.Modal(document.getElementById('updateModal'));
            updateModal.show();
        } catch (error) {
            console.error('Error fetching todo details:', error);
            showError('Failed to fetch todo details.');
        }
    }

    // Update todo
    document.getElementById('update-todo-form').addEventListener('submit', async (e) => {
        e.preventDefault();
        const id = document.getElementById('update-id').value;
        const title = document.getElementById('update-title').value.trim();
        const body = document.getElementById('update-body').value.trim();

        if (!title || !body) {
            showError('Please fill in all fields.');
            return;
        }

        try {
            const response = await fetch(`${apiBaseUrl}${id}/delete/`, { // Using 'delete/' endpoint for update as per your URLs
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                },
                body: JSON.stringify({ title, body }),
            });
            if (!response.ok) {
                throw new Error('Failed to update todo');
            }
            document.getElementById('update-todo-form').reset();
            const updateModal = bootstrap.Modal.getInstance(document.getElementById('updateModal'));
            updateModal.hide();
            fetchTodos();
            showSuccess('Todo updated successfully.');
        } catch (error) {
            console.error('Error updating todo:', error);
            showError('Failed to update todo.');
        }
    });

    // Open delete confirmation modal
    function openDeleteModal(id) {
        deleteTodoId = id;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Confirm delete
    document.getElementById('confirm-delete-btn').addEventListener('click', async () => {
        if (!deleteTodoId) return;
        try {
            const response = await fetch(`${apiBaseUrl}${deleteTodoId}/delete/`, {
                method: 'DELETE',
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
                },
            });
            if (!response.ok) {
                throw new Error('Failed to delete todo');
            }
            const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
            deleteModal.hide();
            fetchTodos();
            showSuccess('Todo deleted successfully.');
        } catch (error) {
            console.error('Error deleting todo:', error);
            showError('Failed to delete todo.');
        } finally {
            deleteTodoId = null;
        }
    });

    // Function to get CSRF token from cookies (if CSRF protection is enabled)
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    // Initial fetch
    fetchTodos();
</script>
```

#### 📌 Breakdown of JavaScript Code

Let's dissect the JavaScript code to understand how it enables CRUD operations and enhances user interaction. 🔍

---

##### 1. **API Base URL and Delete ID**

```javascript
const apiBaseUrl = '/api/';

let deleteTodoId = null;
```

- **`apiBaseUrl`** 🌐: Defines the base URL for all API requests.
- **`deleteTodoId`** 🗑️: Stores the ID of the todo to be deleted. Initialized as `null`.

---

##### 2. **Fetch and Display Todos**

```javascript
async function fetchTodos() {
    try {
        const response = await fetch(apiBaseUrl);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const todos = await response.json();
        const tableBody = document.getElementById('todo-table-body');
        tableBody.innerHTML = '';
        todos.forEach(todo => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${todo.id}</td>
                <td>${todo.title}</td>
                <td>${todo.body}</td>
                <td>
                    <button class="btn btn-secondary btn-sm me-2" onclick="openUpdateModal(${todo.id})">
                        <i class="bi bi-pencil-square"></i> Edit
                    </button>
                    <button class="btn btn-danger btn-sm" onclick="openDeleteModal(${todo.id})">
                        <i class="bi bi-trash"></i> Delete
                    </button>
                </td>
            `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error fetching todos:', error);
        showError('Failed to fetch todos.');
    }
}
```

- **`fetchTodos`** 🛒:
  - **Purpose**: Retrieves the list of todos from the backend and displays them in the table.
  - **`fetch(apiBaseUrl)`** 🌐: Sends a GET request to the API to fetch todos.
  - **Error Handling** 🚫:
    - Checks if the response is OK. If not, throws an error.
    - Catches any errors and logs them to the console.
    - Displays an error alert to the user using `showError`.
  - **Displaying Todos** 📋:
    - Clears the existing table body.
    - Iterates over each todo and creates a table row (`<tr>`) with todo details.
    - Adds "Edit" and "Delete" buttons with corresponding icons and event handlers.

---

##### 3. **Show Success Alert**

```javascript
function showSuccess(message) {
    const successAlert = document.getElementById('success-alert');
    const successMessage = document.getElementById('success-message');
    successMessage.textContent = message;
    successAlert.style.display = 'block';
    setTimeout(() => {
        const alert = new bootstrap.Alert(successAlert);
        alert.close();
    }, 3000);
}
```

- **`showSuccess`** ✅:
  - **Purpose**: Displays a success message to the user.
  - **Parameters**: `message` (string) - The success message to display.
  - **Functionality**:
    - Sets the text content of the success message span.
    - Makes the success alert visible.
    - Automatically hides the alert after 3 seconds using `setTimeout`.

---

##### 4. **Show Error Alert**

```javascript
function showError(message) {
    const errorAlert = document.getElementById('error-alert');
    const errorMessage = document.getElementById('error-message');
    errorMessage.textContent = message;
    errorAlert.style.display = 'block';
    setTimeout(() => {
        const alert = new bootstrap.Alert(errorAlert);
        alert.close();
    }, 5000);
}
```

- **`showError`** ❌:
  - **Purpose**: Displays an error message to the user.
  - **Parameters**: `message` (string) - The error message to display.
  - **Functionality**:
    - Sets the text content of the error message span.
    - Makes the error alert visible.
    - Automatically hides the alert after 5 seconds using `setTimeout`.

---

##### 5. **Create Todo**

```javascript
document.getElementById('create-todo-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('create-title').value.trim();
    const body = document.getElementById('create-body').value.trim();

    if (!title || !body) {
        showError('Please fill in all fields.');
        return;
    }

    try {
        const response = await fetch(apiBaseUrl + 'create/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
            },
            body: JSON.stringify({ title, body }),
        });
        if (!response.ok) {
            throw new Error('Failed to create todo');
        }
        document.getElementById('create-todo-form').reset();
        const createModal = bootstrap.Modal.getInstance(document.getElementById('createModal'));
        createModal.hide();
        fetchTodos();
        showSuccess('Todo created successfully.');
    } catch (error) {
        console.error('Error creating todo:', error);
        showError('Failed to create todo.');
    }
});
```

- **Event Listener** 📝:
  - **Target**: `create-todo-form` - The form used to create a new todo.
  - **Event**: `submit` - Triggered when the form is submitted.
- **Functionality**:
  - **Prevent Default Behavior** 🛑: Stops the form from reloading the page.
  - **Retrieve Input Values** 📥:
    - **`title`**: The title of the todo.
    - **`body`**: The description/body of the todo.
  - **Validation** ✅:
    - Checks if both `title` and `body` are filled.
    - If not, displays an error alert.
  - **API Request** 🌐:
    - Sends a POST request to the `create/` endpoint with the todo data in JSON format.
    - Includes the CSRF token in the headers for security.
  - **Post-Request Actions** 🎉:
    - Resets the form fields.
    - Hides the Create Modal.
    - Fetches the updated list of todos.
    - Displays a success alert.
  - **Error Handling** 🚫:
    - Logs the error to the console.
    - Displays an error alert to the user.

---

##### 6. **Open Update Modal and Populate Data**

```javascript
async function openUpdateModal(id) {
    try {
        const response = await fetch(`${apiBaseUrl}${id}/`);
        if (!response.ok) {
            throw new Error('Failed to fetch todo details');
        }
        const todo = await response.json();
        document.getElementById('update-id').value = todo.id;
        document.getElementById('update-title').value = todo.title;
        document.getElementById('update-body').value = todo.body;
        const updateModal = new bootstrap.Modal(document.getElementById('updateModal'));
        updateModal.show();
    } catch (error) {
        console.error('Error fetching todo details:', error);
        showError('Failed to fetch todo details.');
    }
}
```

- **`openUpdateModal`** 🔄:
  - **Purpose**: Opens the Update Modal with pre-filled data for the selected todo.
  - **Parameters**: `id` (number) - The ID of the todo to update.
- **Functionality**:
  - **Fetch Todo Details** 🌐:
    - Sends a GET request to fetch details of the specific todo using its ID.
  - **Error Handling** 🚫:
    - Throws an error if the response is not OK.
    - Catches and logs the error.
    - Displays an error alert to the user.
  - **Populate Modal Fields** 📋:
    - Sets the hidden input `update-id` with the todo's ID.
    - Fills in the `update-title` and `update-body` fields with existing data.
  - **Show Update Modal** 🔄:
    - Initializes and displays the Update Modal using Bootstrap's Modal component.

---

##### 7. **Update Todo**

```javascript
document.getElementById('update-todo-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const id = document.getElementById('update-id').value;
    const title = document.getElementById('update-title').value.trim();
    const body = document.getElementById('update-body').value.trim();

    if (!title || !body) {
        showError('Please fill in all fields.');
        return;
    }

    try {
        const response = await fetch(`${apiBaseUrl}${id}/delete/`, { // Using 'delete/' endpoint for update as per your URLs
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
            },
            body: JSON.stringify({ title, body }),
        });
        if (!response.ok) {
            throw new Error('Failed to update todo');
        }
        document.getElementById('update-todo-form').reset();
        const updateModal = bootstrap.Modal.getInstance(document.getElementById('updateModal'));
        updateModal.hide();
        fetchTodos();
        showSuccess('Todo updated successfully.');
    } catch (error) {
        console.error('Error updating todo:', error);
        showError('Failed to update todo.');
    }
});
```

- **Event Listener** 📝:
  - **Target**: `update-todo-form` - The form used to update an existing todo.
  - **Event**: `submit` - Triggered when the form is submitted.
- **Functionality**:
  - **Prevent Default Behavior** 🛑: Stops the form from reloading the page.
  - **Retrieve Input Values** 📥:
    - **`id`**: The ID of the todo to update.
    - **`title`**: The updated title of the todo.
    - **`body`**: The updated description/body of the todo.
  - **Validation** ✅:
    - Checks if both `title` and `body` are filled.
    - If not, displays an error alert.
  - **API Request** 🌐:
    - Sends a PUT request to the `delete/` endpoint (as per your current URL structure) with the updated todo data in JSON format.
    - Includes the CSRF token in the headers for security.
  - **Post-Request Actions** 🎉:
    - Resets the form fields.
    - Hides the Update Modal.
    - Fetches the updated list of todos.
    - Displays a success alert.
  - **Error Handling** 🚫:
    - Logs the error to the console.
    - Displays an error alert to the user.

---

##### 8. **Open Delete Confirmation Modal**

```javascript
function openDeleteModal(id) {
    deleteTodoId = id;
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    deleteModal.show();
}
```

- **`openDeleteModal`** 🗑️:
  - **Purpose**: Opens the Delete Confirmation Modal for the selected todo.
  - **Parameters**: `id` (number) - The ID of the todo to delete.
- **Functionality**:
  - Sets the global `deleteTodoId` variable with the selected todo's ID.
  - Initializes and displays the Delete Confirmation Modal using Bootstrap's Modal component.

---

##### 9. **Confirm Delete**

```javascript
document.getElementById('confirm-delete-btn').addEventListener('click', async () => {
    if (!deleteTodoId) return;
    try {
        const response = await fetch(`${apiBaseUrl}${deleteTodoId}/delete/`, {
            method: 'DELETE',
            headers: {
                'X-CSRFToken': getCookie('csrftoken'), // CSRF token if needed
            },
        });
        if (!response.ok) {
            throw new Error('Failed to delete todo');
        }
        const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
        deleteModal.hide();
        fetchTodos();
        showSuccess('Todo deleted successfully.');
    } catch (error) {
        console.error('Error deleting todo:', error);
        showError('Failed to delete todo.');
    } finally {
        deleteTodoId = null;
    }
});
```

- **Event Listener** 📝:
  - **Target**: `confirm-delete-btn` - The button to confirm deletion.
  - **Event**: `click` - Triggered when the button is clicked.
- **Functionality**:
  - **Check for Valid ID** 🔍:
    - Ensures `deleteTodoId` is not `null` before proceeding.
  - **API Request** 🌐:
    - Sends a DELETE request to the `delete/` endpoint with the selected todo's ID.
    - Includes the CSRF token in the headers for security.
  - **Post-Request Actions** 🎉:
    - Hides the Delete Modal.
    - Fetches the updated list of todos.
    - Displays a success alert.
  - **Error Handling** 🚫:
    - Logs the error to the console.
    - Displays an error alert to the user.
  - **Cleanup** 🧹:
    - Resets the `deleteTodoId` to `null` after the operation.

---

##### 10. **Get CSRF Token from Cookies**

```javascript
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
```

- **`getCookie`** 🍪:
  - **Purpose**: Retrieves the value of a specified cookie.
  - **Parameters**: `name` (string) - The name of the cookie to retrieve.
  - **Functionality**:
    - Checks if cookies are present.
    - Splits the cookies into an array.
    - Iterates through the array to find the cookie with the specified name.
    - Decodes and returns the cookie value.
    - Returns `null` if the cookie is not found.

---

##### 11. **Initial Fetch of Todos**

```javascript
// Initial fetch
fetchTodos();
```

- **Purpose** 📅: Fetches and displays the list of todos when the page loads.

---

## 🤝 Contributing

We welcome contributions! Whether it's reporting bugs, suggesting features, or submitting pull requests, your support is invaluable. 🙌

1. **Fork the Repository** 🍴
2. **Create a Feature Branch** 🌱

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Commit Your Changes** ✍️

   ```bash
   git commit -m "Add your message here"
   ```

4. **Push to the Branch** 🔀

   ```bash
   git push origin feature/YourFeature
   ```

5. **Open a Pull Request** 📨

