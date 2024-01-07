import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from src.worker import celery

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
