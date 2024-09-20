# 🎉 Django File Upload Project

## 🛠️ Step 1: Project Setup Using `pipenv` and Django

1. **Install `pipenv`** 🐍:

   If you don’t have `pipenv` installed, install it using pip:

   ```bash
   pip install pipenv
   ```

   - `pipenv` is a tool that manages Python packages and virtual environments. It creates an isolated environment for dependencies, ensuring no conflicts with other projects.

2. **Create a New Directory for Your Project** 📁:

   Navigate to the folder where you want to create your Django project, then create a new directory:

   ```bash
   mkdir django_file_upload_project
   cd django_file_upload_project
   ```

   - `mkdir django_file_upload_project`: Creates a new directory named `django_file_upload_project`.
   - `cd django_file_upload_project`: Changes the current directory to `django_file_upload_project`.

3. **Create a Virtual Environment and Install Django** 🌐:

   ```bash
   pipenv install django
   ```

   - `pipenv install django`: Creates a virtual environment and installs Django in it. This environment is isolated from other Python environments on your system.

4. **Activate the Virtual Environment** 🚀:

   ```bash
   pipenv shell
   ```

   - `pipenv shell`: Activates the virtual environment created by `pipenv`. All subsequent commands will run within this environment.

5. **Create a Django Project** 🏗️:

   ```bash
   django-admin startproject file_upload_project .
   ```

   - `django-admin startproject file_upload_project .`: Creates a new Django project named `file_upload_project`.
     - `file_upload_project`: The name of the Django project.
     - `.` (dot): Indicates that the project should be created in the current directory instead of creating a new folder.

6. **Create a Django App** 🧩:

   ```bash
   python manage.py startapp fileuploadapp
   ```

   - `python manage.py startapp fileuploadapp`: Creates a new Django app named `fileuploadapp` within the `file_upload_project`.
     - **Django App**: A self-contained module that provides a specific functionality to the Django project. In this case, `fileuploadapp` will handle file uploads.

7. **Add the App to `INSTALLED_APPS` in `settings.py`** 🔧:

   Open `file_upload_project/settings.py` and add the app name to the `INSTALLED_APPS` list:

   ```python
   # file_upload_project/settings.py

   INSTALLED_APPS = [
       'django.contrib.admin',
       'django.contrib.auth',
       'django.contrib.contenttypes',
       'django.contrib.sessions',
       'django.contrib.messages',
       'django.contrib.staticfiles',
       'fileuploadapp',  # Register our app
   ]
   ```

   - **`INSTALLED_APPS`**: A list of all Django applications that are activated in this project. By adding `'fileuploadapp'` to the list, Django becomes aware of the app and will process its models, views, templates, etc.

## 🎨 Step 2: Setting Up Static Files and Custom CSS

1. **Create Static Directories for CSS and JavaScript** 🎨:

   Inside `fileuploadapp`, create a `static` directory and subdirectories for `css` and `js`:

   ```bash
   mkdir fileuploadapp/static
   mkdir fileuploadapp/static/css
   mkdir fileuploadapp/static/js
   ```

   - **`static/`**: The folder where all static assets (such as CSS, JavaScript, and images) are stored.
   - **`css/`**: Subdirectory for stylesheets.
   - **`js/`**: Subdirectory for JavaScript files.

2. **Create a `custom.css` File in `static/css`** 🖌️:

   Create a `custom.css` file with the following content to style the web pages:

   ```css
   /* fileuploadapp/static/css/custom.css */

   body {
       background-color: #f0f2f5;  /* Light gray background for the entire page */
       font-family: 'Arial', sans-serif;  /* Arial font for a clean, modern look */
   }

   .custom-container {
       margin-top: 50px;  /* Space at the top */
       padding: 30px;  /* Space inside the container */
       background-color: #ffffff;  /* White background */
       box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);  /* Soft shadow around the container */
       border-radius: 10px;  /* Rounded corners */
   }

   .custom-button {
       background-color: #007bff;  /* Bootstrap's primary blue color */
       color: #ffffff;  /* White text color */
       border: none;  /* No border */
       padding: 10px 20px;  /* Space inside the button */
       border-radius: 5px;  /* Rounded corners for the button */
       cursor: pointer;  /* Cursor changes to a pointer on hover */
   }

   .custom-button:hover {
       background-color: #0056b3;  /* Darker blue on hover */
   }

   .list-group-item {
       background-color: #e9ecef;  /* Light gray background for list items */
       border: none;  /* No border */
       border-bottom: 1px solid #ddd;  /* Soft border at the bottom of each item */
   }
   ```

   - **Explanation**:
     - This file contains custom CSS styles to enhance the visual appearance of the web pages.

3. **Configure Static Files in `settings.py`** 🛠️:

   Add the following configurations to `settings.py` to serve static files:

   ```python
   # file_upload_project/settings.py

   STATIC_URL = '/static/'  # URL to access static files
   STATICFILES_DIRS = [os.path.join(BASE_DIR, 'fileuploadapp/static')]  # Directories to look for static files
   ```

   - **`STATIC_URL`**: The URL prefix to use when referring to static files.
   - **`STATICFILES_DIRS`**: Directories where Django will look for additional static files. Here, we specify the `static` folder inside our app.

## 📂 Step 3: Create Models for File Upload

1. **Create the `Document` Model in `fileuploadapp/models.py`** 📝:

   ```python
   # fileuploadapp/models.py

   from django.db import models

   class Document(models.Model):
       title = models.CharField(max_length=100)  # CharField to store the document title
       uploaded_file = models.FileField(upload_to='documents/')  # FileField for uploading files
       uploaded_at = models.DateTimeField(auto_now_add=True)  # DateTimeField to track when the file was uploaded

       def __str__(self):
           return self.title  # Return the document title as the string representation
   ```

   - **`title`**: A `CharField` that stores the title of the document with a maximum length of 100 characters.
   - **`uploaded_file`**: A `FileField` for handling file uploads. The `upload_to='documents/'` parameter specifies that uploaded files will be stored in the `documents/` directory within the `MEDIA_ROOT`.
   - **`uploaded_at`**: A `DateTimeField` that stores the timestamp when a document is uploaded. The `auto_now_add=True` option automatically sets this field to the current timestamp when a new document is created.
   - **`__str__()` Method**: Returns the `title` as the string representation of the object.

2. **Run Migrations to Apply the Model Changes** 🚀:

   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

   - **`makemigrations`**: Creates migration files based on the changes made to the `models.py` file.
   - **`migrate`**: Applies the migration files to the database, creating or updating tables to match the model definitions.

3. **Add Media Settings in `settings.py`** 🖼️:

   Update `settings.py` to configure media files:

   ```python
   # file_upload_project/settings.py

   MEDIA_URL = '/media/'  # Base URL for serving media files
   MEDIA_ROOT = os.path.join(BASE_DIR, 'media')  # Directory to save uploaded media files
   ```

   - **`MEDIA_URL`**: Defines the base URL for serving media files.
   - **`MEDIA_ROOT`**: Specifies the directory on the filesystem where uploaded files will be stored.

## 📋 Step 4: Create Views Using Class-Based Views (CBVs)

1. **Create Views in `fileuploadapp/views.py`** 👁️‍🗨️:

   ```python
   # fileuploadapp/views.py

   from django.urls import reverse_lazy
   from django.views.generic.edit import CreateView, ListView, DeleteView
   from .models import Document

   class DocumentCreateView(CreateView):
       model = Document  # Specifies the model this view is associated with
       fields = ['title', 'uploaded_file']  # Fields to include in the form
       template_name = 'upload_form.html'  # Template that will render this view
       success_url = reverse_lazy('document_list')  # URL to redirect to after a successful form submission

       def form_valid(self, form):
           uploaded_file = form.cleaned_data.get('uploaded_file')  # Get the uploaded file from the form

           valid_extensions = ['pdf', 'docx', 'jpg', 'jpeg', 'png']  # Allowed file extensions
           extension = uploaded_file.name.split('.')[-1].lower()  # Extract the file extension

           if extension not in valid_extensions:  # Check if the file extension is valid
               form.add_error('uploaded_file', 'Invalid file type! Please upload a PDF, DOCX, or image file (JPG, JPEG, PNG).')
               return self.form_invalid(form)  # Return an invalid form response if the file type is not allowed

           return super().form_valid(form)  # Call the parent class's form_valid() method to save the form

   class DocumentListView(ListView):
       model = Document  # Specifies the model this view is associated with
       template_name = 'document_list.html'  # Template that will render this view
       context_object_name = 'documents'  # Name of the context variable to access the list of objects in the template

   class DocumentDeleteView(DeleteView):
       model = Document  # Specifies the model this view is associated with
       template_name = 'document_confirm_delete.html'  # Template for confirmation before deleting
       success_url = reverse_lazy('document_list')  # Redirect to the list view after deletion
   ```

   - **`DocumentCreateView`**:
     - A **Class-Based View (CBV)** that handles the creation of `Document` objects.
     - **`model`**: Specifies the model associated with the view (`Document`).
     - **`fields`**: Defines which fields from the model will be included in the form.
     - **`template_name`**: Points to the HTML template (`upload_form.html`) that renders the view.
     - **`success_url`**: URL to redirect to after successfully submitting the form, pointing to `document_list`.
     - **`form_valid()` Method**: Overridden method to validate the form. It checks if the uploaded file's extension is among the allowed types (PDF, DOCX, JPG, JPEG, PNG).

   - **`DocumentListView`**:
     - A **Class-Based View (CBV)** that lists all `Document` objects.
     - **`model`**: Specifies the model associated with the view (`Document`).
     - **`template_name`**: Points to the HTML template (`document_list.html`) that renders the view.
     - **`context_object_name`**: Provides a name for the context variable used to access the list of documents in the template.

   - **`DocumentDeleteView`**:
     - A **Class-Based View (CBV)** that handles the deletion of `Document` objects.
     - **`model`**: Specifies the model associated with the view (`Document`).
     - **`template_name`**: Points to the HTML template (`document_confirm_delete.html`) that renders the confirmation dialog before deletion.
     - **`success_url`**: Specifies the URL to redirect to after the document has been successfully deleted.

## 🔗 Step 5: Set Up URLs

1. **Create `urls.py` in `fileuploadapp`** 🌐:

   ```python
   # fileuploadapp/urls.py

   from django.urls import path
   from .views import DocumentCreateView, DocumentListView, DocumentDeleteView

   urlpatterns = [
       path('', DocumentCreateView.as_view(), name='upload_file'),  # Default homepage for uploading files
       path('documents/', DocumentListView.as_view(), name='document_list'),  # URL to list uploaded documents
       path('documents/delete/<int:pk>/', DocumentDeleteView.as_view(), name='document_delete'),  # URL to delete a document
   ]
   ```

   - **Explanation**:
     - **`path('', DocumentCreateView.as_view(), name='upload_file')`**: Sets the root URL (`/`) to use the `DocumentCreateView`. When someone visits the root of the website, the file upload form is displayed.
     - **`path('documents/', DocumentListView.as_view(), name='document_list')`**: Sets the URL `/documents/` to display a list of uploaded documents.
     - **`path('documents/delete/<int:pk>/', DocumentDeleteView.as_view(), name='document_delete')`**:
       - Sets up a URL pattern for deleting documents.
       - **`<int:pk>`**: Captures the primary key (`pk`) of the document to be deleted. This is passed to the view to identify which document to delete.

2. **Include `fileuploadapp` URLs in `file_upload_project/urls.py`** 🌍:

   ```python
   # file_upload_project/urls.py

   from django.contrib import admin
   from django.urls import path, include
   from django.conf import settings
   from django.conf.urls.static import static

   urlpatterns = [
       path('admin/', admin.site.urls),  # Admin site
       path('', include('fileuploadapp.urls')),  # Include URLs from the fileuploadapp with root URL
   ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)  # Serve media files during development
   ```

   - **Explanation**:
     - **`path('', include('fileuploadapp.urls'))`**: Includes the `fileuploadapp` URLs for the root URL (`/`). The homepage will serve the `DocumentCreateView`.
     - **`static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)`**: Configures Django to serve media files during development using the URL defined in `MEDIA_URL`.

## 📑 Step 6: Create Templates for Forms, Document List, and Delete Confirmation

1. **Create `upload_form.html` for the file upload form** 📝:

   ```html
   <!-- fileuploadapp/templates/upload_form.html -->

   <!DOCTYPE html>
   <html lang="en">
   <head>
       {% load static %}
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Upload File</title>
       <!-- Bootstrap CSS CDN -->
       <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
       <!-- Custom CSS -->
       <link href="{% static 'css/custom.css' %}" rel="stylesheet">
   </head>
   <body>
       <div class="container custom-container">
           <h2 class="mb-4">Upload a File 📁</h2>
           
           <!-- Display form errors using Bootstrap alerts -->
           {% if form.errors %}
           <div class="alert alert-danger" role="alert">
               {% for field, errors in form.errors.items %}
                   {% for error in errors %}
                       {{ error }}  <!-- Display error directly without list bullet or extra characters -->
                   {% endfor %}
               {% endfor %}
           </div>
           {% endif %}
           
           <form method="post" enctype="multipart/form-data">
               {% csrf_token %}
               <div class="form-group">  <!-- Bootstrap form-group for spacing -->
                   <label for="id_title">Title:</label>
                   <input type="text" name="title" id="id_title" class="form-control" required>
               </div>
               <div class="form-group">  <!-- Bootstrap form-group for spacing -->
                   <label for="id_uploaded_file">Uploaded file:</label>
                   <input type="file" name="uploaded_file" id="id_uploaded_file" class="form-control-file" required>
               </div>
               <button type="submit" class="btn btn-primary custom-button">Upload</button>
           </form>
       </div>

       <!-- Optionally, add Bootstrap JS and jQuery for advanced components -->
       <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
       <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   </body>
   </html>
   ```

   - **Explanation**:
     - **`{% load static %}`**: Loads the `static` template tag to handle static files.
     - **Error Display Section**: Uses a Bootstrap `alert` component to display error messages without any additional formatting or bullet points.
     - **Bootstrap Classes**: Bootstrap classes such as `form-control`, `form-control-file`, `btn`, and others are used for styling the form.

2. **Create `document_list.html` to display uploaded files with delete functionality** 📄:

   ```html
   <!-- fileuploadapp/templates/document_list.html -->

   <!DOCTYPE html>
   <html lang="en">
   <head>
       {% load static %}
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Uploaded Documents</title>
       <!-- Bootstrap CSS CDN -->
       <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
       <!-- Custom CSS -->
       <link href="{% static 'css/custom.css' %}" rel="stylesheet">
   </head>
   <body>
       <div class="container custom-container">
           <h2 class="mb-4">Uploaded Documents 📄</h2>
           {% if documents %}
           <ul class="list-group">
               {% for document in documents %}
                   <li class="list-group-item d-flex justify-content-between align-items-center">
                       <div>
                           <strong>{{ document.title }}</strong> <!-- Document Title -->
                           <span class="text-muted">Uploaded on: {{ document.uploaded_at|date:"F d, Y" }}</span> <!-- Upload Date -->
                       </div>
                       <div>
                           <a href="{{ document.uploaded_file.url }}" class="btn btn-outline-primary mr-2">Download</a> <!-- Download Button -->
                           <a href="{% url 'document_delete' document.pk %}" class="btn btn-outline-danger">Delete</a> <!-- Delete Button -->
                       </div>
                   </li>
               {% endfor %}
           </ul>
           {% else %}
           <p class="text-center text-muted">No documents have been uploaded yet.</p>
           {% endif %}
       </div>

       <!-- Bootstrap JS and jQuery for optional components -->
       <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
       <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   </body>
   </html>
   ```

   - **Explanation**:
     - Added a **Delete** button next to each **Download** button using the following line:
       ```html
       <a href="{% url 'document_delete' document.pk %}" class="btn btn-outline-danger">Delete</a>
       ```
     - **`{% url 'document_delete' document.pk %}`**: Generates a URL to the delete view for the specific document using its primary key (`pk`).

3. **Create `document_confirm_delete.html` for delete confirmation** 🗑️:

   ```html
   <!-- fileuploadapp/templates/document_confirm_delete.html -->

   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Confirm Delete</title>
       <!-- Bootstrap CSS CDN -->
       <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
   </head>
   <body>
       <div class="container custom-container mt-5">
           <h3 class="mb-4">Are you sure you want to delete this document? ❓</h3>
           <p><strong>{{ object.title }}</strong> (Uploaded on: {{ object.uploaded_at|date:"F d, Y" }})</p>
           <form method="post">
               {% csrf_token %}
               <button type="submit" class="btn btn-danger">Delete</button>
               <a href="{% url 'document_list' %}" class="btn btn-secondary">Cancel</a>
           </form>
       </div>
   </body>
   </html>
   ```

   - **Explanation**:
     - This template provides a simple confirmation dialog asking the user if they want to delete the selected document.
     - It displays the document's title and upload date for clarity.
     - The **Delete** button submits the form to delete the document, and the **Cancel** button redirects back to the document list.

## 🚀 Step 7: Run the Server and Test

1. **Run the Django Development Server** 🏃:

   ```bash
   python manage.py runserver
   ```

2. **Visit the Following URLs** 🌐:

   - **File Upload Form (Homepage):** [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
   - **View Uploaded Files:** [http://127.0.0.1:8000/documents/](http://127.0.0.1:8000/documents/)
   - **Delete Confirmation Page:** Triggered by clicking the **Delete** button on the documents page.

### 🎉 Conclusion

By following these steps, you've set up a Django project that supports file uploads, uses Bootstrap for styling, handles clean error messages, and includes delete functionality for uploaded files—all with a beautiful and user-friendly interface enhanced with emojis! 😊