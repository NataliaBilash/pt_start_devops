import psycopg2
import os
from dotenv import load_dotenv
load_dotenv()

DB_USER     = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_HOST     = os.getenv('DB_HOST')
DB_PORT     = int(os.getenv('DB_PORT', 5432))
DB_DATABASE = os.getenv('DB_DATABASE')


def connect_db():
    return psycopg2.connect(
        dbname=DB_DATABASE,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
    )


def fetch_emails():
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("SELECT Email FROM emails;")
        emails = cursor.fetchall()
    conn.close()
    return emails


def fetch_phone_numbers():
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("SELECT Phone_num FROM phone_num;")
        phone_numbers = cursor.fetchall()
    conn.close()
    return phone_numbers


def insert_email(email):
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("INSERT INTO emails (Email) VALUES (%s);", (email,))
    conn.commit()
    conn.close()


def insert_phone_number(phone_number):
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("INSERT INTO phone_num (Phone_num) VALUES (%s);", (phone_number,))
    conn.commit()
    conn.close()