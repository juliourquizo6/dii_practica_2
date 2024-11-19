from django.db import models

# Create your models here.
class NFT(models.Model):
    nombre = models.CharField(max_length=50)
    simbolo = models.CharField(max_length=50)
    metadatos = models.CharField(max_length=500)
