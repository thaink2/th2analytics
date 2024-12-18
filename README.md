thaink² put at the disposal of technical community  a useful package to explore and make use of analytics functionalities. 


## Authentication 

You will an API key

* [thaink2 API token](https://opensource.thaink2.com/app/th2token)

## Forecasting as a service 

As a part of the time series forecasting, pre-processing plays a major role on the output quality. 

* Pre-processing
  - Anomaly detection & correction
  - Missing values interpolation 
  - Level shift detection & correction


* Modeling:

  - Multiple choices of models
  - Ensembling
  - Automatic or manual model tuning

![forecasting](https://github.com/thaink2/th2analytics/blob/main/images/forecasting_demo.gif)

### The API

#### Using python


```python

import requests

api_token = "*****" # get your token here: https://opensource.thaink2.com/app/th2token


# API request preparation
base_url = "https://apis-dev.thaink2.fr/"
end_point = "thaink2/forecasting"
req_body = {
    "actuals": input_data,
    "fcast_horizon": fcast_horizon,
    "group_target": group_target,
    "target_var": target_var,
    "date_var": date_var,
    "models_list": models_list
}
req_url = f"{base_url}{end_point}"

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

```

#### Using R

1. first install the following package
[th2analytics](https://github.com/thaink2/th2analytics) using the command:

```r
remotes::install_github("thaink2/th2analytics")
```

Prepare your data and call the forecasting API, using a function provided by [thaink²](https://thaink2.com/) 

```r
api_token <- "*****" # get your token here: https://opensource.thaink2.com/app/th2token

historical_data <- ggplot2::economics_long

th2fcast <-  th2analytics::th2forecast_forecast_api(
  input_data = historical_data,
  api_token = api_token,
  fcast_horizon = 30,
  target_var = "value",
  date_var = "date",
  group_target = "variable",
  models_list = c("xgboost")) # xgboost, random_forest, arima
```



