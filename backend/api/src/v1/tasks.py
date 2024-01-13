import os
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from src.worker import celery
from PIL import Image
from config import EMAIL_BASE, EMAIL_DOMAIN, EMAIL_PASS
from fastapi import HTTPException


@celery.task
def send_email(text: str, target_email: str, subject: str):
    try:
        custom_email = f"support@{EMAIL_DOMAIN}"
        email_reciever = target_email
        icloud_email = EMAIL_BASE
        app_specific_password = EMAIL_PASS

        msg = MIMEMultipart()
        msg["From"] = custom_email
        msg["To"] = email_reciever
        msg["Subject"] = subject
        message = text

        msg.attach(MIMEText(message))

        mailserver = smtplib.SMTP("smtp.mail.me.com", 587)
        mailserver.ehlo()
        mailserver.starttls()
        mailserver.ehlo()
        mailserver.login(icloud_email, app_specific_password)

        mailserver.sendmail(custom_email, email_reciever, msg.as_string())

        mailserver.quit()

        return {"detail": "successfully sent"}

    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="email not send. server error")


def photo_maker(path: str):
    try:
        os.stat(path)
    except:
        raise HTTPException(status_code=400, detail="Изображение не найдено")

    src = Image.open(path)

    scale_percent = 95

    try:
        width = int(src.width * scale_percent / 100)
        height = int(src.height * scale_percent / 100)

        while width > 1800 and height > 1800:
            scale_percent -= 5

            width = int(src.width * scale_percent / 100)
            height = int(src.height * scale_percent / 100)

        dsize = (width, height)

        output = src.resize(dsize)

        output.save(path)

        image = Image.open(path)

        data = list(image.getdata())
        image_without_exif = Image.new(image.mode, image.size)
        image_without_exif.putdata(data)

        image_without_exif.save(path)

        image_without_exif.close()

        return "positive"

    except:
        raise HTTPException(status_code=400, detail="Некорректное изображение")
