import secrets

secret_key = secrets.token_urlsafe(50)

print(f"Tu nueva Django SECRET_KEY es:")
print(secret_key)