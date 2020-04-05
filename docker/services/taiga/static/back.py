SECRET_KEY = 'owo'

ALLOWED_HOSTS = [
    '127.0.0.1',
    'localhost',
    'proxy',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'taiga',
        'USER': 'taiga',
        'PASSWORD': 'owo',
        'HOST': 'database',
        'PORT': '5432',
    }
}