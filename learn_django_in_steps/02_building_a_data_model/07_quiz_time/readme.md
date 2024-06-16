# Exercise: Create an `Order` Model

Follow these steps to create an `Order` model with the fields `placed_at` and `payment_status`.

### Steps
1. **Define the `Order` model class**:
   - Add a new class definition for `Order` in the `models.py` file.

2. **Add the `placed_at` field**:
   - Define a `DateTimeField` that is automatically populated with the current date and time when an order is created.

3. **Define the possible values for `payment_status`**:
   - Create constants for each possible value.
   - Create a list of tuples for the `choices` attribute.

4. **Add the `payment_status` field**:
   - Define a `CharField` with a maximum length of 1.
   - Set the `choices` attribute to the list of tuples created in the previous step.
   - Set the default value to one of the constants.

5. **Save the `models.py` file**.
