import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from config import EMAIL_BASE, EMAIL_PASS


def send_email(text: str, target_email: str, subject: str):
    custom_email = "support@poslam.ru"
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

    return "successfully sent"
