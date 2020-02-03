#' @author Chenxi Yang <chenxxiyang@@gmail.com>
#'
#' @description
#' Get restaurant reviews
#'
#' @param api_key your API key
#' @param res_id id of restaurant whose details are requested
#'
#' @return
#' rating (double) rating of the restaurant
#' review_text (character) review text of the restaurant
#' id (integer) id of the review provider
#' rating_color (character) rating_color of the review
#' review_time_friendly (character) time that the review is given
#' rating_text (character) rating_text about the review
#' timestamp (integer) timestamp of the review
#' likes (integer) likes of the review
#' comments_count (integer) number of comments of the review
#' user.name (character) user name of the review provider
#' user.foodie_level (character) user foodie_level of the review provider
#' user.foodie_level_num (integer) user foodie_level_num of the review provider
#' user.foodie_color (character) user foodie_color of the review provider
#' user.profile_url (character) url of the profile of the review provider
#' user.profile_image (character) image of the profile of the review provider
#' user.profile_deeplink (character) deeplink of the profile of the review provider
#' user.zomato_handle (character) zomato_handle about the user
#'
#' @name
#' get_reviews
#'
#' @title
#' Get restaurant reviews
#'
#' @export
#' @examples
#' get_reviews(api_key="xxxxxx", res_id="xxxxxx")

# Function of getting reviews about the restaurant

get_reviews <- function(api_key=NULL, res_id=NULL) {

  # Check the validation of api key
  apikey_check(api_key)

  # Check whether res_id is given
  if (is.null(res_id)){
    stop("Please enter the restaurant ID.")
  }

  URL <- 'https://developers.zomato.com'
  params <- list(res_id = res_id)

  # Sending request
  resp <- httr::GET(
    url = URL,
    path = paste0("/api/v2.1/", "reviews"),
    config = httr::add_headers("user-key" = api_key),
    query = params,
    httr::user_agent("httr")
  )

  # Check whether the connection is successful
  apikey_connectioncheck(resp)

  # Convert json into dataframe
  redata <- jsonlite::fromJSON(httr::content(resp, as = 'text', encoding = 'UTF-8'), flatten = TRUE)

  return(redata$user_reviews)
}