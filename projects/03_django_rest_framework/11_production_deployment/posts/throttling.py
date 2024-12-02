# posts/throttling.py
from rest_framework.throttling import SimpleRateThrottle
from django.core.exceptions import ImproperlyConfigured

class FivePerFiveMinuteThrottle(SimpleRateThrottle):
    scope = 'five_per_five_minute'

    def parse_rate(self, rate):
        """
        Override the parse_rate method to handle rates like '5/5m'.
        """
        try:
            num, period = rate.split('/')
            num = int(num)

            # Extract the numeric part and the unit from the period
            duration_number = int(period[:-1])
            duration_unit = period[-1]

            # Map the unit to seconds
            duration_mapping = {
                's': 1,
                'm': 60,
                'h': 3600,
                'd': 86400,
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

        ident = self.get_ident(request)  # Typically the user's ID or IP
        return self.cache_format % {
            'scope': self.scope,
            'ident': ident
        }
