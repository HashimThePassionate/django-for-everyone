# fileuploadapp/views.py

from django.urls import reverse_lazy
from django.views.generic.edit import CreateView, DeleteView
from django.views.generic.list import ListView
from .models import Document


class DocumentCreateView(CreateView):
    model = Document  # Specifies the model this view is associated with
    fields = ['title', 'uploaded_file']  # Fields to include in the form
    template_name = 'upload_form.html'  # Template that will render this view
    # URL to redirect to after a successful form submission
    success_url = reverse_lazy('document_list')

    def form_valid(self, form):
        # Get the uploaded file from the form
        uploaded_file = form.cleaned_data.get('uploaded_file')

        valid_extensions = ['pdf', 'docx', 'jpg',
                            'jpeg', 'png']  # Allowed file extensions
        extension = uploaded_file.name.split(
            '.')[-1].lower()  # Extract the file extension
        print(f'File extension: {extension}')

        if extension not in valid_extensions:  # Check if the file extension is valid
            form.add_error(
                'uploaded_file', 'Invalid file type! Please upload a PDF, DOCX, or image file (JPG, JPEG, PNG).')
            # Return an invalid form response if the file type is not allowed
            return self.form_invalid(form)

        # Call the parent class's form_valid() method to save the form
        return super().form_valid(form)


class DocumentListView(ListView):
    model = Document  # Specifies the model this view is associated with
    template_name = 'document_list.html'  # Template that will render this view
    # Name of the context variable to access the list of objects in the template
    context_object_name = 'documents'

class DocumentDeleteView(DeleteView):
    model = Document  # Specifies the model this view is associated with
    template_name = 'document_confirm_delete.html'  # Template for confirmation before deleting
    success_url = reverse_lazy('document_list')  # Redirect to the list view after deletion