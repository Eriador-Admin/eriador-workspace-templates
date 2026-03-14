"""
WSGI config for {{APP_NAME}} project.
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{{APP_NAME}}.settings")

application = get_wsgi_application()
