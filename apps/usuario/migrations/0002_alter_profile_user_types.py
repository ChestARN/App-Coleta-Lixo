# Generated by Django 4.2.1 on 2023-11-03 01:03

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='user_types',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.CharField(choices=[('produtor', 'Produtor'), ('coletor', 'Coletor'), ('sucataria', 'Sucataria')], max_length=20), size=None),
        ),
    ]
