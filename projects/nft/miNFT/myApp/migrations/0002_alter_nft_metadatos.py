# Generated by Django 4.2.16 on 2024-11-17 20:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myApp', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='nft',
            name='metadatos',
            field=models.CharField(max_length=500),
        ),
    ]
