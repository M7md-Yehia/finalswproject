# D:\django\shipment_tracking\authentication\serializers.py
from authentication.models import CustomUser
  
from rest_framework import serializers
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from rest_framework import serializers

from authentication.models import Shipment

class UserSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField(write_only=True)  
    role = serializers.ChoiceField(choices=CustomUser.ROLE_CHOICES, write_only=True)


    class Meta:
        model = CustomUser  
        fields = ['id', 'username', 'email', 'password', 'confirm_password','role']  
        extra_kwargs = {'password': {'write_only': True}}

    def validate(self, data):   
        
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError({"password": "Passwords do not match."})
        valid_roles = dict(CustomUser.ROLE_CHOICES)  
        if data['role'] not in valid_roles:
            raise serializers.ValidationError({
                "role": f"Invalid role: {data['role']}. Valid roles are: {', '.join(valid_roles.keys())}"
            })
        return data

    def create(self, validated_data):
        print("DEBUG: Calling create_user")
        print("Validated Data:", validated_data)

        validated_data.pop('confirm_password')
        try:
            validate_password(validated_data['password'])
        except ValidationError as e:
            raise serializers.ValidationError({"password": e.messages})
        
        user = CustomUser.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email'),
            password=validated_data['password'],
            role=validated_data['role'],
        )
        print("DEBUG: User created with username:", user.username)
        return user


class ShipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shipment
        fields = ['id', 'tracking_number', 'status', 'created_at']



