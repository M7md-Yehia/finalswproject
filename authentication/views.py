
from rest_framework.response import Response
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from .serializers import UserSerializer
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from django.contrib.auth import get_user_model
from rest_framework import serializers
from .models import Shipment
from .serializers import ShipmentSerializer
from django.contrib.auth.password_validation import validate_password

from rest_framework.permissions import IsAuthenticated

from django.core.exceptions import ValidationError


from .models import DeviceToken
from firebase_admin import messaging
import logging
logger = logging.getLogger(__name__)

# User details view
@api_view(['GET'])
def user(request):
    if request.user.is_authenticated:
        user = request.user
        return Response({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'role': user.role  # Include role
        })
    return Response({"message": "User not authenticated"}, status=401)
@api_view(['GET'])
def shipment_history(request):
    shipments = Shipment.objects.all()
    serializer = ShipmentSerializer(shipments, many=True)
    return Response(serializer.data)







@api_view(['POST'])
@permission_classes([IsAuthenticated])
def send_notification(request):
    """
    Send a notification using Firebase Cloud Messaging.
    """
    device_token = request.data.get('token')
    message_body = request.data.get('message')
    metadata = request.data.get('metadata', {})  # Optional metadata
    
    if not device_token or not message_body:
        return Response({"message": "Device token and message are required."}, status=status.HTTP_400_BAD_REQUEST)

    notification = messaging.Notification(
        title="New Notification",
        body=message_body,
    )

    firebase_message = messaging.Message(
        notification=notification,
        token=device_token,
        data=metadata,  
    )

    try:
        response = messaging.send(firebase_message)
        return Response({
            "message": "Notification sent successfully",
            "response": response,
            "metadata": metadata,
        }, status=status.HTTP_200_OK)
    except Exception as e:
        
        logger.error(f"Failed to send notification: {e}")
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
def change_password(request):
    print("DEBUG: Change password endpoint hit.")  
    
    username = request.data.get('username')
    old_password = request.data.get('old_password')
    new_password = request.data.get('new_password')

    print(f"DEBUG: Received data - Username: {username}, Old Password: {old_password}, New Password: {new_password}")

    if not username or not old_password or not new_password:
        print("DEBUG: Missing fields in the request.")
        return Response(
            {"error": "All fields are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    User = get_user_model()

    try:
        print(f"DEBUG: Fetching user with username: {username}")
        user = User.objects.get(username=username)
        print(f"DEBUG: User found: {user}")

        if not user.check_password(old_password):
            print(f"DEBUG: Incorrect old password for user: {username}")
            return Response({"error": "Old password is incorrect."}, status=status.HTTP_400_BAD_REQUEST)

        print(f"DEBUG: Validating new password for user: {username}")
        validate_password(new_password, user=user)

        print(f"DEBUG: Setting new password for user: {username}")
        user.set_password(new_password)
        user.save()

        print(f"DEBUG: Password changed successfully for user: {username}")
        return Response({"message": "Password changed successfully."}, status=status.HTTP_200_OK)

    except User.DoesNotExist:
        print(f"ERROR: User with username {username} not found.")
        return Response({"error": "User not found."}, status=status.HTTP_404_NOT_FOUND)
    except ValidationError as e:
        print(f"ERROR: Validation error for new password: {e.messages}")
        return Response({"errors": e.messages}, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        print(f"ERROR: Unexpected error: {e}")
        return Response({"error": "An unexpected error occurred."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)





@api_view(['POST'])
@permission_classes([AllowAny])
def register(request):
    print("DEBUG: Register endpoint hit.")
    print("DEBUG: Received data:", request.data)

    serializer = UserSerializer(data=request.data)

    if serializer.is_valid():
        print("DEBUG: Serializer is valid.")
        user = serializer.save()
        
        print("DEBUG: User saved:", user.username)
        return Response({"message": "User created successfully"}, status=status.HTTP_201_CREATED)

    print("DEBUG: Serializer errors:", serializer.errors)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# Login view
@api_view(['POST'])
def login(request):
    
    username = request.data.get("username")
    password = request.data.get("password")
    user = authenticate(username=username, password=password)
    
    if user:
        refresh = RefreshToken.for_user(user)
        return Response({
            'refresh': str(refresh),
            'access': str(refresh.access_token),
            'role': user.role
        }, status=200)
    return Response({"message": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def save_device_token(request):
    """
    Save the user's Firebase device token.
    """
    token = request.data.get('token')
    if not token:
        return Response({"message": "Token is required."}, status=status.HTTP_400_BAD_REQUEST)

    DeviceToken.objects.update_or_create(user=request.user, defaults={'token': token})
    return Response({"message": "Device token saved successfully."}, status=status.HTTP_200_OK)

