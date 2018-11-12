
#' Plot individual trajectories

#'
#' @param data Dataset in wide format
#' @param id_var String of id variable
#' @param var_list List of variables to be plotted
#' @param line_colour Colour of lines
#' @param point_colour Colour of points
#' @param line_alpha Alpha of lines
#' @param point_alpha Alpha of points
#' @param smooth Logical, add line of average using method = \code{smooth_method}
#' @param smooth_method Method for calculating average
#' @param smooth_se Locical, add standard error of average line
#' @param xlab String for x-Axis label
#' @param ylab String for y-Axis label
#' @param scale_x_num Logical, if \code{TRUE} print sequential numbers starting from one as x axis labels, if \code{FALSE} use variable names.
#' @param scale_x_num_start Numeric, if \code{scale_x_num == TRUE} this is the starting value of the x axis
#' @param random_sample_frac The fraction of rows to select (from wide dataset), default is to use 100 percent of the sample.
#'
#' @return ggplot2 object
#' @export
#'
#' @examples TODO
plot_trajectories <- function(data, id_var, var_list, line_colour = "blue", point_colour = "black", line_alpha = .2, point_alpha = .2, smooth = FALSE, smooth_method = "loess", smooth_se = FALSE, xlab = "X", ylab = "Y", scale_x_num = FALSE, scale_x_num_start = 1, random_sample_frac = 1, title_n = FALSE){
  
  data <- sample_frac(tbl = data, size = random_sample_frac)
  
  if (nrow(data) < 200) {
    line_alpha <- .4
    point_alpha <- .4
  }
  
  data_plot <- data %>% 
    select(id_var, var_list) %>%
    gather(variable, value, -id_var) %>% 
    mutate(variable = factor(variable, var_list))
  
  plot <- data_plot %>%
    ggplot(aes(variable, value)) +
    geom_line(aes(group = id), colour = line_colour, alpha = line_alpha) +
    geom_point(colour = point_colour, alpha = point_alpha, size = 1) +
    labs(x = xlab, y = ylab) +
    theme_classic() +
    theme(text = element_text(size = 12))
  
  if (title_n == TRUE){
    plot <- plot + ggtitle(paste("N = ", nrow(data), " (", round(random_sample_frac * 100, 2), "% of the sample)", sep = ""))
  }
  
  if (scale_x_num == FALSE) {
  plot_x_scale <- plot + scale_x_discrete(labels = var_list)
  } else {
  plot_x_scale <- plot + scale_x_discrete(labels = scale_x_num_start:(length(var_list) + scale_x_num_start - 1))
  }
      
  if (smooth == TRUE) {
  plot_x_scale + geom_smooth(aes(group = 1), size = 1, method = smooth_method, se = smooth_se)
  } else {
  plot_x_scale
  }
}

