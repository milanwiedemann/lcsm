
#' Plot individual trajectories

#'
#' @param data Dataset in wide format.
#' @param id_var String, specifying id variable.
#' @param var_list Vector, specifying variable names to be plotted in sequential order.
#' @param line_colour String, specifying colour of lines.
#' @param point_colour String, specifying, colour of points.
#' @param line_alpha Numeric, specifying alpha of lines.
#' @param point_alpha Numeric, specifying alpha of points.
#' @param smooth Logical, add line of average using method = \code{smooth_method}.
#' @param smooth_method String, specifying method to be used for calculating average line, see  \code{ggplot2}.
#' @param smooth_se Locical, specifying whether to add standard error of average line or not.
#' @param xlab String for x axis label.
#' @param ylab String for y axis label.
#' @param scale_x_num Logical, if \code{TRUE} print sequential numbers starting from 1 as x axis labels, if \code{FALSE} use variable names.
#' @param scale_x_num_start Numeric, if \code{scale_x_num == TRUE} this is the starting value of the x axis.
#' @param random_sample_frac The fraction of rows to select (from wide dataset), default is set to 1 (100 percent) of the sample.
#' @param connect_missing Logical, speciying whether to connect points by \code{id_var} across missing values.
#' @param title_n Logical, speciying whether to print title with number and percentage of cases used for the plot.
#' 
#' @return ggplot2 object
#' @export

plot_trajectories <- function(data, id_var, var_list, line_colour = "blue", point_colour = "black", line_alpha = .2, point_alpha = .2, smooth = FALSE, smooth_method = "loess", smooth_se = FALSE, xlab = "X", ylab = "Y", scale_x_num = FALSE, scale_x_num_start = 1, random_sample_frac = 1, title_n = FALSE, connect_missing = TRUE){
  
  data <- dplyr::sample_frac(tbl = data, size = random_sample_frac)
  
  data_plot <- data %>% 
    dplyr::select(id_var, var_list) %>%
    tidyr::gather(variable, value, -id_var) %>% 
    dplyr::mutate(variable = factor(variable, var_list))
  
  plot <- data_plot %>%
    ggplot2::ggplot(ggplot2::aes(variable, value)) +
    ggplot2::geom_point(colour = point_colour, alpha = point_alpha, size = 1) +
    ggplot2::labs(x = xlab, y = ylab) +
    ggplot2::theme_classic() +
    ggplot2::theme(text = ggplot2::element_text(size = 12))
  
  if (connect_missing == TRUE) {
    plot <- plot + ggplot2::geom_line(data = data_plot[!is.na(data_plot$value), ], ggplot2::aes(group = !!rlang::sym(id_var)), colour = line_colour, alpha = line_alpha)
    } else if (connect_missing == FALSE) {
      plot <- plot + ggplot2::geom_line(data = data_plot, ggplot2::aes(group = !!rlang::sym(id_var)), colour = line_colour, alpha = line_alpha)
      }
  
  if (title_n == TRUE){
    plot <- plot + ggplot2::ggtitle(paste("N = ", nrow(data), " (", round(random_sample_frac * 100, 2), "% of the sample)", sep = ""))
  }
  
  if (scale_x_num == FALSE) {
  plot_x_scale <- plot + ggplot2::scale_x_discrete(labels = var_list)
  } else {
  plot_x_scale <- plot + ggplot2::scale_x_discrete(labels = scale_x_num_start:(length(var_list) + scale_x_num_start - 1))
  }
      
  if (smooth == TRUE) {
  plot_x_scale + ggplot2::geom_smooth(ggplot2::aes(group = 1), size = 1, method = smooth_method, se = smooth_se)
  } else {
  plot_x_scale
  }
}

