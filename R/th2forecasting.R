#' th2forecast_forecast_api
#' @export
th2forecast_forecast_api <- function(input_data,group_target = NULL, base_url = "https://apis-dev.thaink2.fr/" ,api_token ,fcast_horizon = 30, target_var,date_var , models_list = NULL){
  end_point <- "thaink2/forecasting"
  req_body <- list(
    "actuals"= input_data,
    "fcast_horizon" = fcast_horizon,
    "group_target"= group_target,
    "target_var" = target_var,
    "date_var" = date_var,
    "models_list" = models_list
  )
  req_url <- paste0(base_url,end_point)
  forecast_req <- httr2::request(base_url = req_url)%>%
    httr2::req_auth_bearer_token(token = api_token)%>%
    httr2::req_body_json(req_body)%>%
    httr2::req_method("POST")
  forecast_resp <- forecast_req%>%
    httr2::req_perform(verbosity = 0)
  forecast_result <- forecast_resp%>%
    httr2::resp_body_json()%>%
    do.call(dplyr::bind_rows, . )
  forecast_result2 <<- forecast_result

  forecast_result<- forecast_result%>%
    dplyr::mutate(.index = lubridate::as_datetime(.index))
  return(forecast_result)
}
