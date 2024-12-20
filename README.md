
## About

**thaink²**  is a startup specializing in AI-driven time series forecasting and data solutions, empowering businesses to transform raw data into actionable insights effortlessly.

It puts at the disposal of technical community  and SDK, where they can unlock the full potential of advanced predictive analytics to make data-driven decisions with confidence ( Machine learning, time series forecasting)


## Authentication 

You will need an API key in order to be able to request the API, the key can be generated using the following link: 

* [https://opensource.thaink2.com/app/th2token](https://opensource.thaink2.com/app/th2token)

## Forecasting as a service 

As a part of the time series forecasting, pre-processing plays a major role on the output quality. 

### Pre-processing
  - Anomaly detection & correction
  - Missing values interpolation 
  - Level shift detection & correction


### Modeling:

  - Multiple choices of models
  - Ensembling
  - Automatic or manual model tuning

![forecasting](https://github.com/thaink2/th2analytics/blob/main/images/forecasting_demo.gif)


### The API: example


First install the following package

[https://github.com/thaink2/th2analytics](https://github.com/thaink2/th2analytics) using the command

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



