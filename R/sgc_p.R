# create data.frame of all p values of the SGC (Synchronous Growth Changes) using output of SGC.R
# author: Ronald Visser
# Published as: Visser, R.M., 2020: On the similarity of tree‐ring patterns: Assessing the influence of semi‐synchronous growth changes on the Gleichläufigkeitskoeffizient for big tree‐ring data sets, Archaeometry 2020.
# DOI: https://doi.org/10.1111/arcm.12600


sgc_p <- function(sgc_list)
  {
  # check if input is list of 2
  if ((is.list(sgc_list)) && (length(sgc_list) == 2))
    {
    sgc_df <- as.data.frame(sgc_list[1])
    # mirror matrix to get full SGC-matrix
    sgc_df[lower.tri(sgc_df)] <- sgc_df[upper.tri(sgc_df)]
    overlap_df <- as.data.frame(sgc_list[2])
    s_df <- 1 /(2*sqrt(overlap_df))
    z_df <- (sgc_df-0.5)/s_df
    z_normcdf <- apply(z_df, 2, function(x) pnorm(x, mean=0, sd=1))
    SGC_p <- 2*(1-z_normcdf) 
    } 
  else 
    {
    stop("Incorrect input. Please use the output of SGC.R as input")
    }
}