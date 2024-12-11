import pandas as pd
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
import pickle
import os

class PredictionModel:
    def __init__(self):
        # Initialize models and scalers
        self.model1 = None
        self.model2 = None
        self.model3 = None
        self.scaler1 = StandardScaler()
        self.scaler2 = StandardScaler()
        self.scaler3 = StandardScaler()

        self.models_loaded = False

        # Ensure the models directory exists
        os.makedirs('models', exist_ok=True)

    def train_models(self):
        # Load data from Excel files
        df1 = pd.read_excel('data/file1.xlsx')  # Model 1 data
        df2 = pd.read_excel('data/file2.xlsx')  # Model 2 data
        df3 = pd.read_excel('data/file3.xlsx')  # Model 3 data with GGBS

        # Model 1: Train with the first 5 features
        X1 = df1.iloc[:, :5]
        y1 = df1.iloc[:, -2]
        X1_train, X1_test, y1_train, y1_test = train_test_split(X1, y1, test_size=0.2, random_state=42)
        X1_train_scaled = self.scaler1.fit_transform(X1_train)
        
        grid_search1 = GridSearchCV(LinearRegression(), {'fit_intercept': [True, False]}, cv=5)
        grid_search1.fit(X1_train_scaled, y1_train)
        self.model1 = grid_search1.best_estimator_

        # Model 2: Train with the first 5 features
        X2 = df2.iloc[:, :5]
        y2 = df2.iloc[:, -2]
        X2_train, X2_test, y2_train, y2_test = train_test_split(X2, y2, test_size=0.2, random_state=42)
        X2_train_scaled = self.scaler2.fit_transform(X2_train)
        self.model2 = LinearRegression().fit(X2_train_scaled, y2_train)

        # Model 3: Train with all 6 features (without polynomial transformation for consistency)
        X3 = df3.iloc[:, :6]
        y3 = df3.iloc[:, -1]
        X3_train, X3_test, y3_train, y3_test = train_test_split(X3, y3, test_size=0.2, random_state=42)
        X3_train_scaled = self.scaler3.fit_transform(X3_train)
        
        grid_search3 = GridSearchCV(LinearRegression(), {'fit_intercept': [True, False]}, cv=5)
        grid_search3.fit(X3_train_scaled, y3_train)
        self.model3 = grid_search3.best_estimator_

        # Save models and preprocessing objects
        with open('models/model1.pkl', 'wb') as f:
            pickle.dump((self.model1, self.scaler1), f)
        with open('models/model2.pkl', 'wb') as f:
            pickle.dump((self.model2, self.scaler2), f)
        with open('models/model3.pkl', 'wb') as f:
            pickle.dump((self.model3, self.scaler3), f)
        
        self.models_loaded = True
        print("Models trained and saved successfully.")

    def load_models(self):
        if os.path.exists('models/model1.pkl') and os.path.exists('models/model2.pkl') and os.path.exists('models/model3.pkl'):
            with open('models/model1.pkl', 'rb') as f:
                self.model1, self.scaler1 = pickle.load(f)
            with open('models/model2.pkl', 'rb') as f:
                self.model2, self.scaler2 = pickle.load(f)
            with open('models/model3.pkl', 'rb') as f:
                self.model3, self.scaler3 = pickle.load(f)
            self.models_loaded = True
            print("Models loaded successfully.")
        else:
            print("Model files not found. Please train the models first.")

    def predict(self, ggbs, parameters):
        """
        Predicts based on the provided `ggbs` value and parameters.
        - Uses Model 1 if `ggbs` is "no" and the 5th parameter is 0.
        - Uses Model 2 if `ggbs` is "no" and the 5th parameter is not 0.
        - Uses Model 3 if `ggbs` is "yes".
        """
        if not self.models_loaded:
            self.load_models()
        
        if ggbs.lower() == 'yes':
            # Use Model 3 with all 6 parameters
            parameters_scaled = self.scaler3.transform([parameters])
            return self.model3.predict(parameters_scaled)[0]
        else:
            # If `ggbs` is "no" use only the first 5 parameters
            parameters_trimmed = parameters[:5]
            if parameters_trimmed[4] == 0:
                # Use Model 1 if the 5th parameter is 0
                parameters_scaled = self.scaler1.transform([parameters_trimmed])
                return self.model1.predict(parameters_scaled)[0]
            else:
                # Use Model 2 if the 5th parameter is not 0
                parameters_scaled = self.scaler2.transform([parameters_trimmed])
                return self.model2.predict(parameters_scaled)[0]
