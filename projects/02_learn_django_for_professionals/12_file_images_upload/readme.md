# 📚 Section: File / Image Uploads

In this section, we'll cover how to handle user-uploaded files, such as book covers, in a Django project. While we have already configured static assets like images in Section 6, user-uploaded files differ from static assets. Static assets are files included with the application, while user-uploaded files are considered "media." This distinction is crucial as it affects how Django handles these files.

User-uploaded files require additional processing and security considerations. For example, when uploading images, we need the Python image processing library `Pillow`, which provides basic validation features.

## 🛠️ Installing Required Libraries

To handle image uploads, we'll install the `Pillow` library. Follow the steps below to add it to your project:

### 1. Update `requirements.txt`

Add `Pillow` to your `requirements.txt` file:

```text
# requirements.txt
asgiref==3.8.1
certifi==2024.7.4
charset-normalizer==3.3.2
crispy-bootstrap5==0.6
Django==5.1
django-allauth==64.1.0
django-crispy-forms==1.14.0
idna==3.8
psycopg2-binary==2.9.9
requests==2.32.3
sqlparse==0.5.1
starkbank-ecdsa==2.2.0
tzdata==2024.1
urllib3==2.2.2
environs[django]==9.5.0
PyJWT==2.7.0
cryptography==41.0.3
pillow==9.0.1  # 🆕 New addition
django-cleanup==6.0.1  # 🆕 Automatically deletes old files when a new file is uploaded
django-storages==1.13.1  # 🆕 To handle media files with Amazon S3
python-magic==0.4.27  # 🆕 For advanced file type detection
```

Explanation:
- **`requirements.txt`**: This file contains all the Python package dependencies for your project. Adding `pillow==9.0.1` ensures that the image processing library `Pillow` is installed in your environment.

### 2. Update Dockerfile

To properly support image processing with `Pillow`, we need to update the Dockerfile to install additional system libraries that `Pillow` and other packages depend on for handling various image formats and font rendering. Below is the updated Dockerfile:

```dockerfile
# Dockerfile
FROM python:3.12-slim-bullseye
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code
RUN apt update && apt install -y \
    zlib1g-dev libjpeg-dev libpng-dev libfreetype6-dev liblcms2-dev libtiff5-dev libwebp-dev \
    libharfbuzz-dev libfribidi-dev tk-dev libxcb1-dev \  # 🆕 Install libraries for image and font processing
    && apt clean && rm -rf /var/lib/apt/lists/*
COPY ./requirements.txt .
RUN pip install -r requirements.txt
COPY . .
```

#### Explanation:

- **`FROM python:3.12-slim-bullseye`**: This line specifies the base image for our Docker container, which is a slim version of Python 3.12 based on the Debian Bullseye distribution.
- **`ENV PIP_DISABLE_PIP_VERSION_CHECK=1`**: Disables pip version check to speed up installation.
- **`ENV PYTHONDONTWRITEBYTECODE=1`**: Prevents Python from writing `.pyc` files, which can save disk space.
- **`ENV PYTHONUNBUFFERED=1`**: Ensures Python output is not buffered, which makes log messages immediately visible.
- **`WORKDIR /code`**: Sets the working directory inside the Docker container to `/code`.
- **`RUN apt update && apt install -y ... && apt clean && rm -rf /var/lib/apt/lists/*`**: Updates the package lists, installs required dependencies for image and font processing libraries, and then cleans up to reduce image size. Below are the dependencies:
  - **`zlib1g-dev`**: Required for handling PNG image compression.
  - **`libjpeg-dev`**: Needed for handling JPEG image files.
  - **`libpng-dev`**: Needed for handling PNG image files.
  - **`libfreetype6-dev`**: A font rendering library, necessary for rendering fonts in images.
  - **`liblcms2-dev`**: For color management in images.
  - **`libtiff5-dev`**: To handle TIFF image files.
  - **`libwebp-dev`**: Required for handling WebP image format.
  - **`libharfbuzz-dev`**: For advanced text shaping.
  - **`libfribidi-dev`**: Provides support for bi-directional text rendering.
  - **`tk-dev`**: For GUI support, required by some image libraries.
  - **`libxcb1-dev`**: Low-level access to the X Window System, used by image rendering libraries.
- **`COPY ./requirements.txt .`**: Copies `requirements.txt` from the host to the Docker container.
- **`RUN pip install -r requirements.txt`**: Installs all Python dependencies specified in `requirements.txt`.
- **`COPY . .`**: Copies the entire codebase to the `/code` directory in the Docker container.

### 3. Rebuild Docker Container

After updating the Dockerfile, stop your container, rebuild the image, and start the container again to include `Pillow` and the necessary libraries.

```bash
docker-compose down
docker-compose up -d --build
```

Explanation:
- **`docker-compose down`**: Stops and removes the running containers.
- **`docker-compose up -d --build`**: Builds the updated Docker image and starts the container in detached mode (`-d`).

> 📌 For more details on `Pillow`, visit [Pillow's official website](https://python-pillow.org/).

## 🗃️ Media Files

The main difference between static and media files is trustworthiness. Static files, such as JavaScript or CSS files, are controlled by the developer and can be trusted. However, user-uploaded media files are potentially unsafe and must be validated to avoid security threats.

### 📁 Configuring `MEDIA_ROOT` and `MEDIA_URL`

To manage media files in Django, we need to add two configurations in the `django_project/settings.py` file:

```python
# django_project/settings.py

MEDIA_URL = "/media/"  # 🆕 New setting
MEDIA_ROOT = BASE_DIR / "media"  # 🆕 New setting
```

Explanation:
1. **`MEDIA_ROOT`**: This setting defines the absolute file system path where user-uploaded files will be stored on the server. It is crucial to set this path correctly to ensure that all uploaded files are saved in a centralized and organized location. For example, if `MEDIA_ROOT` is set to `BASE_DIR / "media"`, all user-uploaded files will be saved in the `media` folder at the root of your project.
2. **`MEDIA_URL`**: This setting provides the URL that will be used in templates to access these media files. When a user uploads a file, Django will save it in the location specified by `MEDIA_ROOT`. To display the file on a web page, we need a URL to serve it. `MEDIA_URL` should always end with a trailing slash (`/`) to form valid URLs. If `MEDIA_URL` is set to `"/media/"`, all media files can be accessed via URLs that start with `/media/`.
### 🔄 Creating the Media Directory

Create a new directory for media files:

```bash
mkdir media
mkdir media/covers
```

Explanation:
- **`mkdir media`**: Creates a `media` directory to store user-uploaded files.
- **`mkdir media/covers`**: Creates a subdirectory `covers` within `media` to store cover images.

### 🖥️ Serving Media Files During Development

To display media files locally during development, update the `django_project/urls.py` file:

```python
# django_project/urls.py

from django.conf import settings  # 🆕 Import settings
from django.conf.urls.static import static  # 🆕 Import static
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Django admin
    path("admin/", admin.site.urls),
    # User management
    path("accounts/", include("allauth.urls")),
    # Local apps
    path("", include("pages.urls")),
    path("books/", include("books.urls")),
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)  # 🆕 New addition
```
#### Explanation:
- **`from django.conf import settings`**: Imports the Django settings module to access project settings.
- **`from django.conf.urls.static import static`**: Imports a helper function to serve static and media files during development.
- **`static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)`**: This line is crucial for serving media files during development. When `DEBUG` is set to `True` in Django's settings (which is usually the case in development), this function helps Django serve files from the `MEDIA_ROOT` directory at the URL specified by `MEDIA_URL`. 
  - **`settings.MEDIA_URL`**: The URL prefix where media files will be served.
  - **`document_root=settings.MEDIA_ROOT`**: Specifies the directory where the files are stored on the server.
  - In production, a different setup (such as using a CDN) is typically required for serving media files, but this line ensures quick and easy serving of media files during development without needing additional servers or configurations.


## 📑 Models

With the media configuration in place, let's update our models to support image uploads. We'll use Django's `ImageField`, which provides basic validation and processing for image files.

### Example Model

```python
# books/models.py

class Book(models.Model):
    id = models.UUIDField(primary_key=True,default=uuid.uuid4,editable=False)
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=6, decimal_places=2)
    cover = models.ImageField(upload_to="covers/")  # 🆕 New field

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("book_detail", args=[str(self.id)])
...
```

Explanation:
- **`ImageField(upload_to="covers/")`**: This field is specifically for images. The `upload_to` parameter specifies the subdirectory within `MEDIA_ROOT` where

 uploaded files will be stored.
- **`get_absolute_url` method**: Returns the URL for the detail view of a specific book.

### 🛠️ Making Migrations

Since we've added a new field (`cover`) to the model, we need to create a new migration:

```bash
docker-compose exec web python manage.py makemigrations books
```

Explanation:
- **`makemigrations books`**: Creates a migration file for the changes made to the `books` app models.

If you encounter the following error:

```
You are trying to add a non-nullable field 'cover_image' to book
without a default; we can't do that (the database needs something to populate existing rows).
```

Choose **option 2** to quit, and then modify the `cover` field to set `blank=True` to allow existing rows without a cover image:

```python
# books/models.py

cover = models.ImageField(upload_to="covers/", blank=True)  # 🆕 Updated field
```

Explanation:
- **`blank=True`**: Allows the field to be optional, meaning existing records in the database do not need a value for `cover`.

Now, create the migration again without errors:

```bash
docker-compose exec web python manage.py makemigrations books
```

Apply the migration to update the database:

```bash
docker-compose exec web python manage.py migrate
```

Explanation:
- **`migrate`**: Applies all pending migrations to the database.

## ⚙️ Admin Interface

In the Django Admin interface, you can now add a cover image for any book entry. For example, use the `static/images/projects/fluentpython.png` file for the book "Fluent Python".

## 🌐 Template Update

To display the uploaded cover image on the book detail page, update the `book_detail.html` template:

### Updated Template

```html
<!-- templates/books/book_detail.html -->
{% extends "_base.html" %} {% load crispy_forms_tags %} {% block title %}{{
book.title }}{% endblock title %} {% block content %}
<div class="book-detail">
  {% if book.cover %}
  <img class="bookcover" src="{{ book.cover.url }}" alt="{{ book.title }}" />
  {% endif %}
  <h2><a href="{{ book.get_absolute_url }}">{{ book.title }}</a></h2>
  <p>Author: {{ book.author }}</p>
  <p>Price: {{ book.price }}</p>
  <div>
    <h3>Reviews</h3>
    <ul>
      {% for review in book.reviews.all %}
      <li>{{ review.review }} ({{ review.author }})</li>
      {% empty %}
      <li>No reviews yet. Be the first to review this book!</li>
      {% endfor %}
    </ul>
  </div>

  <!-- 📝 Review Form -->
  <div>
    <h3>Leave a Review</h3>
    <form method="post" action="{% url 'review_create' book.pk %}">
      {% csrf_token %} {{ form|crispy }}
      <!-- Render the form with Crispy Forms for styling -->
      <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
  </div>
</div>
{% endblock content %}
```

Explanation:
- This template extends a base template and displays book details such as cover image, title, author, price, and reviews. A form is included to allow users to submit reviews.
- 
- **`{% if book.cover %}`**: Checks if a cover image is present before displaying it to avoid errors if the image is not available.

## 🚀 django-storages

For production environments, consider using `django-storages` to store media files on a CDN like Amazon S3 instead of the local server. This approach ensures that user-uploaded files are secure and managed effectively.

## 🔄 Next Steps

Further steps could include adding extra validation for the image-uploading form to ensure only safe images are uploaded, creating dedicated forms for creating/editing/deleting books and cover images, and writing tests to focus on form validation.

The third-party package `django-cleanup` can be handy for automatically deleting old files.


## 📝 Git Commit

Remember to commit all the changes made in this section:

```bash
git status
git add .
git commit -m 'Upload Images'
```

Explanation:
- **`git status`**: Checks the current status of the repository.
- **`git add .`**: Stages all the changes.
- **`git commit -m 'Upload Images'`**: Commits the changes with a descriptive message.

## 🎯 Conclusion

This section demonstrates how to add user-uploaded files to a Django project, covering the additional layers of security and configuration necessary to handle such files. In the next section, we will explore adding permissions to the site to enhance security further.
