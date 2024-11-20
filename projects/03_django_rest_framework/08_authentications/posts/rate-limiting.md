# 🚀 Rate Limiting

## 📋 Table of Contents
- [🚀 Rate Limiting](#-rate-limiting)
  - [📋 Table of Contents](#-table-of-contents)
  - [🛠 1. Custom Throttling Class (`throttling.py`)](#-1-custom-throttling-class-throttlingpy)
    - [Code:](#code)
    - [Detailed Explanation:](#detailed-explanation)
  - [🛑 2. Custom Exception Handler (`exceptions.py`)](#-2-custom-exception-handler-exceptionspy)
    - [Code:](#code-1)
    - [Detailed Explanation:](#detailed-explanation-1)
  - [⚙️ 3. Configuring Throttling in Settings (`settings.py`)](#️-3-configuring-throttling-in-settings-settingspy)
    - [Code:](#code-2)
    - [Detailed Explanation:](#detailed-explanation-2)
  - [📑 4. Applying Throttling to Views (`views.py`)](#-4-applying-throttling-to-views-viewspy)
    - [Code:](#code-3)
    - [Detailed Explanation:](#detailed-explanation-3)
  - [🎉 Conclusion](#-conclusion)

---

## 🛠 1. Custom Throttling Class (`throttling.py`)

### Code:
```python
from rest_framework.throttling import SimpleRateThrottle
from django.core.exceptions import ImproperlyConfigured

class FivePerFiveMinuteThrottle(SimpleRateThrottle):
    scope = 'five_per_five_minute'

    def parse_rate(self, rate):
        """
        Override the parse_rate method to handle custom rates like '5/5m'.
        """
        try:
            num, period = rate.split('/')
            num = int(num)

            # Extract the numeric part and the unit from the period
            duration_number = int(period[:-1])
            duration_unit = period[-1]

            # Map the unit to seconds
            duration_mapping = {
                's': 1,       # seconds
                'm': 60,      # minutes
                'h': 3600,    # hours
                'd': 86400    # days
            }

            if duration_unit not in duration_mapping:
                raise ValueError(f"Invalid duration unit: {duration_unit}")

            duration = duration_mapping[duration_unit] * duration_number
            return (num, duration)
        except (ValueError, KeyError) as e:
            raise ImproperlyConfigured(
                f"Invalid throttle rate '{rate}'. Expected format '<number>/<duration>', e.g., '5/5m'. Error: {e}"
            )

    def get_cache_key(self, request, view):
        """
        Generate a unique cache key based on the user's unique identifier.
        """
        if not request.user.is_authenticated:
            return None  # Only throttle authenticated users

        ident = self.get_ident(request)
        return self.cache_format % {
            'scope': self.scope,
            'ident': ident
        }
```

### Detailed Explanation:

1. **Imports**:
   ```python
   from rest_framework.throttling import SimpleRateThrottle
   from django.core.exceptions import ImproperlyConfigured
   ```
   - `SimpleRateThrottle`: A built-in class in Django REST Framework used for implementing simple request rate-limiting.
   - `ImproperlyConfigured`: This is raised if there’s an issue with configuration, such as an invalid rate format.

2. **Class Definition**:
   ```python
   class FivePerFiveMinuteThrottle(SimpleRateThrottle):
       scope = 'five_per_five_minute'
   ```
   - The class `FivePerFiveMinuteThrottle` inherits from `SimpleRateThrottle`.
   - The `scope` attribute is used in `settings.py` to define the rate limit.

3. **`parse_rate()` Method**:
   ```python
   def parse_rate(self, rate):
   ```
   - This method parses the rate defined in `settings.py` (e.g., `'5/5m'`).

   **Step-by-step Explanation**:
   - **Splitting the Rate**:
     ```python
     num, period = rate.split('/')
     num = int(num)
     ```
     - The `rate` string is split into two parts:
       - `num`: Number of requests allowed (e.g., `5`).
       - `period`: Time duration (e.g., `'5m'` for 5 minutes).

   - **Extracting Numeric Value and Unit**:
     ```python
     duration_number = int(period[:-1])
     duration_unit = period[-1]
     ```
     - `duration_number` extracts the numeric value (like `5` from `'5m'`).
     - `duration_unit` extracts the last character (like `'m'`).

   - **Mapping Units to Seconds**:
     ```python
     duration_mapping = {
         's': 1,        # seconds
         'm': 60,       # minutes
         'h': 3600,     # hours
         'd': 86400     # days
     }
     ```
     - Converts units (`s`, `m`, `h`, `d`) to seconds.

   - **Error Handling**:
     ```python
     if duration_unit not in duration_mapping:
         raise ValueError(f"Invalid duration unit: {duration_unit}")
     ```
     - If the unit is invalid, it raises a `ValueError`.

   - **Returning the Rate**:
     ```python
     duration = duration_mapping[duration_unit] * duration_number
     return (num, duration)
     ```
     - Calculates the total duration in seconds and returns a tuple `(num, duration)`.

4. **`get_cache_key()` Method**:
   ```python
   def get_cache_key(self, request, view):
   ```
   - This method generates a unique cache key for throttling.

   **Step-by-step Explanation**:
   - **Throttle Only Authenticated Users**:
     ```python
     if not request.user.is_authenticated:
         return None
     ```
   - **Generate Cache Key**:
     ```python
     ident = self.get_ident(request)
     return self.cache_format % {'scope': self.scope, 'ident': ident}
     ```
     - Uses the user's IP or identifier to create a unique cache key.

---

## 🛑 2. Custom Exception Handler (`exceptions.py`)

### Code:
```python
from rest_framework.views import exception_handler
from rest_framework.exceptions import Throttled

def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)

    if isinstance(exc, Throttled):
        wait_seconds = exc.wait
        wait_minutes = wait_seconds // 60
        wait_seconds = wait_seconds % 60
        wait_time = ""
        if wait_minutes > 0:
            wait_time += f"{wait_minutes} minute(s) "
        wait_time += f"{wait_seconds} second(s)"
        
        response.data = {
            "detail": f"🚫 Too many requests. Please try again in {wait_time}."
        }

    return response
```

### Detailed Explanation:
1. **Handles Throttled Exception**:
   - Checks if the exception is of type `Throttled`.
   - Calculates wait time in minutes and seconds.
   - Returns a user-friendly error message.

---

## ⚙️ 3. Configuring Throttling in Settings (`settings.py`)

### Code:
```python
REST_FRAMEWORK = {
    "DEFAULT_PERMISSION_CLASSES": ["rest_framework.permissions.IsAuthenticated"],
    "DEFAULT_THROTTLE_CLASSES": [
        "rest_framework.throttling.AnonRateThrottle",
        "rest_framework.throttling.UserRateThrottle",
        "posts.throttling.FivePerFiveMinuteThrottle",
    ],
    "DEFAULT_THROTTLE_RATES": {
        "anon": "2/day",
        "user": "5/day",
        "five_per_five_minute": "5/5m",
    },
    "EXCEPTION_HANDLER": "posts.exceptions.custom_exception_handler",
}
```

### Detailed Explanation:
- **Throttle Classes**:
  - `AnonRateThrottle`: Limits requests for anonymous users.
  - `UserRateThrottle`: Limits requests for authenticated users.
  - `FivePerFiveMinuteThrottle`: Our custom throttle for 5 requests per 5 minutes.
- **Custom Exception Handler**: Uses `custom_exception_handler` for friendly error messages.

---

## 📑 4. Applying Throttling to Views (`views.py`)

### Code:
```python
from rest_framework import generics
from .models import Post
from .permissions import IsAuthorOrReadOnly
from .serializers import PostSerializer
from .throttling import FivePerFiveMinuteThrottle

class PostList(generics.ListCreateAPIView):
    permission_classes = (IsAuthorOrReadOnly,)
    throttle_classes = (FivePerFiveMinuteThrottle,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthorOrReadOnly,)
    throttle_classes = (FivePerFiveMinuteThrottle,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer
```

### Detailed Explanation:
- **`PostList` View**:
  - Limits the creation and listing of posts.
  - Applies the custom throttle to restrict requests.
- **`PostDetail` View**:
  - Limits the detail, update, and delete actions for posts.

---

## 🎉 Conclusion

By implementing a custom throttling mechanism, we can efficiently control the flow of requests to our API. This ensures that our application remains performant while providing clear feedback to users when limits are reached. 🚀