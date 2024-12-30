from django.test import TestCase

from authentication.models import CustomUser
from .models import Shipment

class ShipmentModelTest(TestCase):
    def setUp(self):
        self.user = CustomUser.objects.create_user(
            username='mo',
            password='P@ss01815',
            role='Shipment_Tracker'
        )
        self.shipment = Shipment.objects.create(
            tracking_number='123456789',
            date='2024-12-22',
            status='In Transit',
            details='Test shipment details'
        )

    def test_shipment_creation(self):
        self.assertEqual(self.shipment.tracking_number, '123456789')
