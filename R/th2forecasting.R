#' th2forecast_forecast_api
#'
#' Sends input data to the Thaink2 Forecasting API and retrieves the forecast results.
#'
#' @param input_data A data frame with actuals used for forecasting.
#' @param group_target A grouping variable for the forecast, optional.
#' @param base_url Base URL of the API (default: "https://apis-dev.thaink2.fr/").
#' @param api_token The bearer token for API authentication.
#' @param fcast_horizon Forecast horizon, specifying how many periods to forecast (default: 30).
#' @param target_var Name of the target variable in `input_data`.
#' @param date_var Name of the date variable in `input_data`.
#' @param models_list Optional list of models to use for forecasting.
#'
#' @return A data frame with forecast results.
#' @export
th2forecast_forecast_api <- function(
    input_data,
    group_target = NULL,
    base_url = "https://apis-dev.thaink2.fr/",
    api_token,
    fcast_horizon = 30,
    target_var,
    date_var,
    models_list = NULL
) {
  # Input validation
  if (missing(api_token)) stop("The `api_token` is required.")
  if (!all(c(target_var, date_var) %in% names(input_data))) {
    stop("`target_var` and `date_var` must be columns in `input_data`.")
  }

  # API request preparation

  end_point <- "thaink2/forecasting"
  req_body <- list(
    "actuals" = input_data,
    "fcast_horizon" = fcast_horizon,
    "group_target" = group_target,
    "target_var" = target_var,
    "date_var" = date_var,
    "models_list" = models_list
  )
  req_url <- paste0(base_url, end_point)

  # Make the API request
  forecast_req <- httr2::request(base_url = req_url) %>%
    httr2::req_auth_bearer_token(token = api_token) %>%
    httr2::req_body_json(req_body) %>%
    httr2::req_method("POST")

  forecast_resp <- forecast_req %>%
    httr2::req_perform()

  # Error handling
  httr2::resp_check_status(forecast_resp)

  # Parse the response
  forecast_result <- forecast_resp %>%
    httr2::resp_body_json() %>%
    do.call(dplyr::bind_rows, .)

  # Check and mutate .index column
  if (".index" %in% names(forecast_result)) {
    forecast_result <- forecast_result %>%
      dplyr::mutate(.index = lubridate::as_datetime(.index))
  }

  return(forecast_result)
}
