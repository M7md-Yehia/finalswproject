from django.urls import path
from rest_framework_simplejwt import views as jwt_views
from . import views  
from .views import shipment_history

urlpatterns = [
    path('api/token/', jwt_views.TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', jwt_views.TokenRefreshView.as_view(), name='token_refresh'),
    path('register/', views.register, name='register'), 
    path('user/', views.user, name='user'),  
    path('api/auth/register/', views.register, name='register'),
    path('login/', views.login, name='login'),  
   path('api/shipments/', shipment_history, name='shipment_history'),
  path('api/auth/login/', views.login, name='login'), 

path('api/send-notification/', views.send_notification, name='send_notification'),
    path('api/save-device-token/', views.save_device_token, name='save_device_token'),
    
path('api/auth/change-password-no-auth/', views.change_password, name='change_password_no_auth'),
    path('change-password-no-auth/', views.change_password, name='change_password_no_auth'),


]