# altered from https://github.com/edgararuiz/dbplot/blob/master/R/histogram.R
# changed: 
# geom_col(aes(x, count)) 
# to
# geom_col(aes(x, count), orientation="x", width = binwidth)
dbplot_histogram <- function(data, x, bins = 30, binwidth = NULL) {
  x <- enexpr(x)
  
  df <- db_compute_bins(
    data = data,
    x = !!x,
    bins = bins,
    binwidth = binwidth
  )
  
  if(is.null(binwidth)) {
    range <- expr(max(df$x) - min(df$x))
    binwidth <- expr((!!range / !!bins))
    }
  
  df <- mutate(
    df,
    x = !!x
  )
  
  ggplot(df) +
    geom_col(aes(x, count), orientation="x", width = binwidth) +
    labs(
      x = quo_name(x),
      y = "count"
    )
}
