# books/forms.py
from django import forms  # Import Django forms module
from .models import Review, Book  # Import the Review model
from crispy_forms.helper import FormHelper  # Import Crispy Forms helper for better form rendering
from crispy_forms.layout import Submit  # Import Crispy Forms layout for adding a submit button

# 🖊️ Form for submitting reviews
class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review  # Model associated with this form
        fields = ['review']  # Only include the review text in the form

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 🧰 Initialize Crispy Form Helper
        self.helper = FormHelper()
        self.helper.form_method = 'post'  # Set form method to POST
        self.helper.add_input(Submit('submit', 'Submit Review'))  # Add a submit button to the form

class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'price', 'cover']
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.add_input(Submit('submit', 'Save Book'))

