# 📌 Handling `loaddata` Duplicate Key Error in Django

## ❓ Problem Statement

When running the following Django command:

```bash
python manage.py loaddata mysite_data.json
```

you may encounter an error similar to:

```plaintext
psycopg2.errors.UniqueViolation: duplicate key value violates unique constraint "django_content_type_app_label_model_76bd3d3b_uniq"
DETAIL: Key (app_label, model)=(blog, post) already exists.
```

This error occurs when the **Django content types table (********`django_content_type`********\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*)** already contains an entry for the specified model (`blog.post`), causing a conflict when loading fixture data.

---

## 🔍 Root Causes

- \*\*Duplicate Entries in \*\***`mysite_data.json`** – The fixture contains existing records that conflict with the database.
- **Pre-existing Data in Database** – The database already has content type records for the specified models.
- **Migration Inconsistencies** – Old database migrations or schema issues.

---

## ✅ Solutions

### **1️⃣ Delete Existing Content Types** (Recommended)

Clear existing `contenttypes` records before loading the fixture:

```bash
python manage.py shell
```

Inside Django shell, run:

```python
from django.contrib.contenttypes.models import ContentType
ContentType.objects.all().delete()
```

Then, reload the fixture:

```bash
python manage.py loaddata mysite_data.json
```

### **2️⃣ Now Migrate**

```bash
python manage.py migrate
python manage.py loaddata mysite_data.json
```

