from django.urls import path
from .views import IndexView, CreateView, RequestCreditCardView

urlpatterns = [
    path('users/', IndexView.as_view(), name='user-index'),
    path('users/create/', CreateView.as_view(), name='user-create'),
    path('users/request-credit-card/', RequestCreditCardView.as_view(), name='user-request-credit-card'),

    path('services/', IndexView.as_view(), name='service-index'),
    path('services/create/', CreateView.as_view(), name='service-create'),

    path('customers/', IndexView.as_view(), name='customer-index'),
    path('customers/create/', CreateView.as_view(), name='customer-create'),

    path('appointments/', IndexView.as_view(), name='appointment-index'),
    path('appointments/create/', CreateView.as_view(), name='appointment-create'),

]