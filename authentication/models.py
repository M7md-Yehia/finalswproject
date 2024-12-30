from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    ROLE_CHOICES = [
    ('Delivery_Person', 'Delivery Person'),
    ('Shipment_Tracker', 'Shipment_Tracker'),
]
  
    role = models.CharField(max_length=50, choices=ROLE_CHOICES, default='shipment_tracking')

    def __str__(self):
        return self.username
    
class Shipment(models.Model):
    tracking_number = models.CharField(max_length=50, unique=True)
    date = models.DateField()
    status = models.CharField(max_length=50)
    details = models.TextField()

    def __str__(self):
        return self.tracking_number
    


class DeviceToken(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    token = models.CharField(max_length=255, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)