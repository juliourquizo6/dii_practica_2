from django.urls import path
from . import views

urlpatterns = [
    path('buscador', views.index, name='index'),
    path("<str:contract_address>/<int:token_id>", views.get_nft, name='get_nft')
]