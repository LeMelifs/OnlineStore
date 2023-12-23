from django.contrib.auth.base_user import BaseUserManager, AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.db import models
from phonenumber_field.modelfields import PhoneNumberField


class UserManager(BaseUserManager):
    def _create_user(self, username, password, email, is_active, is_superuser, is_staff, **extra_fields):
        if not username:
            raise ValueError("User must have a username!")
        email = self.normalize_email(email)
        user = self.model(username=username, email=email, is_active=is_active, is_staff=is_staff,
                          is_superuser=is_superuser, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, username, email, password, **extra_fields):
        return self._create_user(username, password, email, is_active=True, is_superuser=False,
                                is_staff=False, **extra_fields)

    def create_superuser(self, username, email, password, **extra_fields):
        user = self._create_user(username, password, email, is_active=True, is_superuser=True,
                                 is_staff=True, **extra_fields)
        user.save(using=self._db)
        return user


class CustomUser(AbstractBaseUser, PermissionsMixin):
    GENDERS = (
        ('м', 'Мужчина'),
        ('ж', 'Женщина')
    )
    email = models.EmailField('Почта', max_length=255, unique=True)
    username = models.CharField('Имя на сайте', max_length=255, unique=True)
    first_name = models.CharField('Имя', max_length=255, blank=True)
    phone = PhoneNumberField('Номер телефона', blank=True)
    gender = models.CharField('Пол', max_length=1, choices=GENDERS, default='', blank=True)
    photo = models.ImageField('Фотография', blank=True)
    password = models.CharField('Пароль', max_length=128)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    objects = UserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']
