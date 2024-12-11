from flask import Flask, request, render_template, jsonify
import sqlite3
from datetime import datetime
from ml_model import PredictionModel

app = Flask(__name__)

# Initialize ML models and train if necessary
model = PredictionModel()
model.train_models()  # Train models using Excel files in the `data/` folder

# Database setup: Create tables dynamically based on date and batch number
def create_table(date, batch_number):
    formatted_date = date.replace('-', '_')
    table_name = f"batch_{formatted_date}_batch_{batch_number}"

    conn = sqlite3.connect("predictions.db")
    cursor = conn.cursor()
    cursor.execute(f"""
        CREATE TABLE IF NOT EXISTS {table_name} (
            id INTEGER PRIMARY KEY,
            name TEXT,
            id_number TEXT,
            ggbs TEXT,
            parameter1 REAL,
            parameter2 REAL,
            parameter3 REAL,
            parameter4 REAL,
            parameter5 REAL,
            parameter6 REAL,
            predicted_value REAL
        )
    """)
    conn.commit()
    conn.close()
    return table_name

@app.route('/')
def index():
    return render_template('index.html')  # Displays the form

@app.route('/submit', methods=['POST'])
def submit():
    data = request.json
    name = data.get('personName')
    id_number = data.get('idNumber')
    date = data.get('date')
    batch_number = data.get('batchNumber')
    ggbs = data.get('ggbs')

    # Fetch parameters
    parameters = [data.get(f'parameter{i+1}') for i in range(6)]
    actual_value = data.get('actualValue')

    # Create or identify the correct table name
    table_name = create_table(date, batch_number)

    # Perform prediction using the updated predict method in PredictionModel
    prediction = model.predict(ggbs, parameters)

    # Insert data into the database
    conn = sqlite3.connect("predictions.db")
    cursor = conn.cursor()
    cursor.execute(f"""
        INSERT INTO {table_name} (name, id_number, ggbs, parameter1, parameter2, parameter3, parameter4, parameter5, parameter6, predicted_value)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (name, id_number, ggbs, *parameters, prediction))
    conn.commit()
    conn.close()

    # Calculate differences for display
    difference = actual_value - prediction
    percent_difference = (difference / actual_value) * 100 if actual_value else None

    return jsonify({
        'predicted_value': prediction,
        'difference_value': difference,
        'percent_difference': percent_difference
    })

if __name__ == '__main__':
    app.run(debug=True)
