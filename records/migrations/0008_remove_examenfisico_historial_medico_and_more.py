# Generated by Django 5.0.6 on 2024-06-10 21:15

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('records', '0007_alter_historialmedico_consulta_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examenfisico',
            name='historial_medico',
        ),
        migrations.RemoveField(
            model_name='revisionorganossistemas',
            name='historial_medico',
        ),
        migrations.AddField(
            model_name='examenfisico',
            name='fecha_examen',
            field=models.DateTimeField(auto_now_add=True, default='2011-01-01 12:00:00'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='examenfisico',
            name='paciente',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='records.paciente'),
        ),
        migrations.AddField(
            model_name='revisionorganossistemas',
            name='fecha_revision',
            field=models.DateTimeField(auto_now_add=True, default='2011-01-01 12:00:00'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='revisionorganossistemas',
            name='paciente',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='records.paciente'),
        ),
    ]
