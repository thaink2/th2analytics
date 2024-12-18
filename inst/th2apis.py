import requests
import pandas as pd
import numpy as np

api_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzQ1MzkxMjEsInVzZXJfbWFpbCI6ImZhcmlkLmF6b3Vhb3VAdGhhaW5rMi5jb20iLCJ0YXJnZXRfc2VydmljZSI6ImZvcmVjYXN0aW5nIiwiYWRkaXRpb25faW5mbyI6InRlc3QifQ.SlzjcfMEvP4zu4MpY6p_d3nZVaYhIihQEor-yCu6A9M" # get your token here: https:\\opensource.thaink2.com\app\th2token
# Generate random time-series data

# API request preparation
np.random.seed(42)
dates = pd.date_range(start='2022-01-01', periods=100, freq='D')
values = np.random.randn(100).cumsum()
# Create a DataFrame from the generated data
input_data = pd.DataFrame({'date': dates, 'value': values})

# API request preparation
base_url = "https://apis-dev.thaink2.fr/"
# base_url = "http://127.0.0.1:3838/"
end_point = "thaink2/forecasting"
req_url = f"{base_url}{end_point}"
req_body = {
    "actuals": input_data.to_json(orient="records", date_format = "iso"),
    "fcast_horizon": 30,
 #   "group_target": group_target,
    "target_var": "value",
    "date_var": "date",
    "models_list": ["xgboost"]
}

# Make the API request
headers = {
    "Authorization": f"Bearer {api_token}",
    "Content-Type": "application/json"
}
response = requests.post(req_url, json=req_body, headers=headers)
# Process the response
if response.status_code == 200:
    forecast_resp = response.json()  # Assuming the response is JSON
    print("Response:", forecast_resp)
else:
    print(f"Error: {response.status_code} - {response.text}")