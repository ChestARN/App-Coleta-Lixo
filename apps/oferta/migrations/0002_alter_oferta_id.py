# Generated by Django 4.2.1 on 2023-08-04 02:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('oferta', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='oferta',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]
