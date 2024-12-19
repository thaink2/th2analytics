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
from th2analytics.forecasting import ForecastingAPI
import numpy as np
import pandas as pd

api_token = "************" # get your token here: https:\\opensource.thaink2.com\app\th2token


# Initialize the API wrapper
api = ForecastingAPI(
    base_url = "https://apis-dev.thaink2.fr/",
    api_token = api_token
)

np.random.seed(42)
dates = pd.date_range(start='2022-01-01', periods=100, freq='D')
values = np.random.randn(100).cumsum()
# Create a DataFrame from the generated data
input_data = pd.DataFrame({'date': dates, 'value': values})
# Generate the forecast
forecast = api.th2forecast_api(
    actuals = input_data,
    fcast_horizon = 30,
    group_target = None,
    target_var = "value",
    date_var = "date",
    models_list = ["xgboost"]
)
# Print the forecast
print("Forecast Results:", forecast)
```

#### Using R

First install the following package

[th2analytics](https://github.com/thaink2/th2analytics) using the command

```r
remotes::install_github("thaink2/th2analytics")
```

Prepare your data and call the forecasting API, as illustrated below:

```r
api_token <- "*****" # get your token here: https://opensource.thaink2.com/app/th2token

historical_data <- ggplot2::economics_long

th2fcast <-  th2analytics::th2forecast_api(
  input_data = historical_data,
  api_token = api_token,
  fcast_horizon = 30,
  target_var = "value",
  date_var = "date",
  group_target = "variable",
  models_list = c("xgboost")) # xgboost, random_forest, arima
```



