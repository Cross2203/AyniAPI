# Generated by Django 3.2.25 on 2024-07-15 04:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('records', '0013_paciente_image_url'),
    ]

    operations = [
        migrations.AlterField(
            model_name='paciente',
            name='email',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
