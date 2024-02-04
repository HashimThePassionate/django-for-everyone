from django import forms
from django.core.exceptions import ValidationError
from django.core.validators import MinLengthValidator, MaxLengthValidator
from store.models import User

def validate_name(value):

    if not value[0].isupper():
        raise ValidationError('First name must start with a capital letter.')

    if not value.isalpha():
        raise ValidationError('First name must only contain letters.')


def validate_custom_email(value):
    if '@' not in value or '.' not in value.split('@')[1]:
        raise ValidationError(
            'Email must contain "@" and at least one "." in the domain.')

#-----------------------Form API------------------------------------
class CustomerForm(forms.Form):
    first_name = forms.CharField(label='First Name', error_messages={
        'required': 'Please Enter Your First Name'
    }, label_suffix='!', widget=forms.TextInput(attrs={
        'placeholder': 'First Name',
        'class': 'form-control'
    }), validators=[validate_name,
                    MinLengthValidator(limit_value=4),
                    MaxLengthValidator(limit_value=20)])
    last_name = forms.CharField(label='Last Name', error_messages={
        'required': 'Please Enter Your Last Name'
    }, label_suffix='!', widget=forms.TextInput(attrs={
        'placeholder': 'Last Name',
        'class': 'form-control'
    }), validators=[validate_name,
                    MinLengthValidator(limit_value=4),
                    MaxLengthValidator(limit_value=20)
                    ])
    email = forms.EmailField(
        label='Email', error_messages={
            'required': 'Please Enter Your Email'
        }, widget=forms.TextInput(attrs={
            'placeholder': 'xyz@gmail.com',
            'class': 'form-control'
        }), validators=[validate_custom_email,
                        MinLengthValidator(limit_value=10),
                        MaxLengthValidator(limit_value=30)]
    )
    phone_no = forms.CharField(label='Phone No', error_messages={
        'required': 'Please Enter Your Phone No'
    }, label_suffix='!', widget=forms.TextInput(attrs={
        'placeholder': '+923075239903',
        'class': 'form-control'
    }), validators=[
        MinLengthValidator(limit_value=11),
        MaxLengthValidator(limit_value=15)
    ])
    membership = forms.MultipleChoiceField(
        label='Please Choose Membership',  # Corrected label
        widget=forms.Select(attrs={
            'class': 'form-select',  # Added comma
        }),
        choices=[
            ('S', 'SILVER'),
            ('G', 'GOLD'),
            ('D', 'DIAMOND'),
        ]
    )
    
#-------------------Model Form--------------------------
class userform(forms.ModelForm):
    class Meta:
        model = User
        fields = ("username", "first_name", "last_name", "email", "membership")

    username = forms.CharField(
        label='Username',
        error_messages={'required': 'Please Enter Your Username'},
        widget=forms.TextInput(attrs={
            'placeholder': 'Type Username',
            'class': 'form-control'
        }),
        validators=[validate_name, MinLengthValidator(
            limit_value=4), MaxLengthValidator(limit_value=20)]
    )
    first_name = forms.CharField(
        label='First Name',
        error_messages={'required': 'Please Enter Your First Name'},
        widget=forms.TextInput(attrs={
            'placeholder': 'First Name',
            'class': 'form-control'
        }),
        validators=[validate_name, MinLengthValidator(
            limit_value=4), MaxLengthValidator(limit_value=20)]
    )
    last_name = forms.CharField(
        label='Last Name',
        error_messages={'required': 'Please Enter Your Last Name'},
        widget=forms.TextInput(attrs={
            'placeholder': 'Last Name',
            'class': 'form-control'
        }),
        validators=[validate_name, MinLengthValidator(
            limit_value=4), MaxLengthValidator(limit_value=20)]
    )
    email = forms.EmailField(
        label='Email',
        error_messages={'required': 'Please Enter Your Email'},
        widget=forms.TextInput(attrs={
            'placeholder': 'xyz@gmail.com',
            'class': 'form-control'
        }),
        validators=[validate_custom_email, MinLengthValidator(
            limit_value=10), MaxLengthValidator(limit_value=30)]
    )
    membership = forms.ChoiceField(
        label='Please Choose Membership',
        widget=forms.Select(attrs={
            'class': 'form-select', }), choices=User.MEMBERSHIP_CHOICES)
