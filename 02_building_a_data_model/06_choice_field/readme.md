# Choice Fields

## Adding a Membership Field to the Customer Model

Sometimes we need to limit the list of values that can be stored in a field. For example, in our `Customer` class, let's define a field called `membership` and set it to `models.CharField` with a max length of 1.

**Define the `membership` field**:
   - Add a new field called `membership` to the `Customer` class:
     ```python
     class Customer(models.Model):
         MEMBERSHIP_BRONZE = 'B'
         MEMBERSHIP_SILVER = 'S'
         MEMBERSHIP_GOLD = 'G'

         MEMBERSHIP_CHOICES = [
             (MEMBERSHIP_BRONZE, 'Bronze'),
             (MEMBERSHIP_SILVER, 'Silver'),
             (MEMBERSHIP_GOLD, 'Gold'),
         ]

         first_name = models.CharField(max_length=255)
         last_name = models.CharField(max_length=255)
         email = models.EmailField(max_length=255, unique=True)
         phone = models.CharField(max_length=20)
         birth_date = models.DateField(null=True)
         membership = models.CharField(max_length=1, choices=MEMBERSHIP_CHOICES, default=MEMBERSHIP_BRONZE)
     ```
