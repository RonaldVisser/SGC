# create data.frame of all p values of the Gleichläufichkeit using output of GLK.R
# author: Ronald Visser


GPL_p <- function(glk_list)
  {
  # check if input is list of 2
  if ((is.list(glk_list)) && (length(glk_list) == 2))
    {
    glk_df <- as.data.frame(glk_list[1])
    overlap_df <- as.data.frame(glk_list[2])
    s_df <- 1 /(2*sqrt(overlap_df))
    z_df <- (glk_df-0.5)/s_df
    z_normcdf <- apply(z_df, 2, function(x) pnorm(x, mean=0, sd=1))
    GPL_p <- 2*(1-z_normcdf) 
    } 
  else 
    {
    stop("Incorrect input. Please use the output of GLK.R as input")
    }
}