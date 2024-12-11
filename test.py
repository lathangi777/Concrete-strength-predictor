from flask import Flask, request, render_template, jsonify
import sqlite3
from datetime import datetime
from ml_model import PredictionModel
def delete_all_tables():
    conn = sqlite3.connect("predictions.db")
    cursor = conn.cursor()

    # Fetch all table names
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()

    for table in tables:
        table_name = table[0]
        cursor.execute(f"DROP TABLE IF EXISTS {table_name};")
        print(f"Table {table_name} deleted successfully.")

    conn.commit()
    conn.close()

delete_all_tables()