# posts/exceptions.py
from rest_framework.views import exception_handler
from rest_framework.exceptions import Throttled


def custom_exception_handler(exc, context):
    # Call DRF's default exception handler first
    response = exception_handler(exc, context)

    # If the exception is a Throttled exception, customize the response
    if isinstance(exc, Throttled):
        wait_seconds = exc.wait
        wait_minutes = wait_seconds // 60
        wait_seconds = wait_seconds % 60
        wait_time = ""
        if wait_minutes > 0:
            wait_time += f"{wait_minutes} minute(s) "
        wait_time += f"{wait_seconds} second(s)"

        # Update the response data with a friendly message
        response.data = {
            "detail": f"🚫 Too many requests. Please try again in {wait_time}."
        }

    return response
