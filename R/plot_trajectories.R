
#' Plot individual trajectories

#'
#' @param data Dataset in wide format
#' @param id_var String of id variable
#' @param var_list List of variables to be plotted
#' @param line_colour Colour of lines
#' @param point_colour Colour of points
#' @param line_alpha Alpha of lines
#' @param point_alpha Alpha of points
#' @param smooth Logical, add line of average
#' @param smooth_method Method for calculating average
#' @param smooth_se Locical, add standard error of average line
#' @param xlab String for x-Axis label
#' @param ylab String for y-Axis label
#'
#' @return ggplot2 object
#' @export
#'
#' @examples TODO
plot_trajectories <- function(data, id_var, var_list, line_colour = "blue", point_colour = "black", line_alpha = .2, point_alpha = .2, smooth = FALSE, smooth_method = "loess", smooth_se = FALSE, xlab = "X", ylab = "Y"){
  
  data_plot <- data %>% 
    select(id_var, var_list) %>%
    gather(variable, value, -id_var) %>% 
    mutate(variable = factor(variable, var_list))
  
  plot <- data_plot %>%
    ggplot(aes(variable, value)) +
    geom_line(aes(group = id), colour = line_colour, alpha = line_alpha) +
    geom_point(colour = point_colour, alpha = point_alpha, size = 1) +
    scale_x_discrete(labels = 1:length(var_list)) +
    labs(x = xlab, y = ylab) +
    theme_classic() +
    theme(text = element_text(size = 12))

  if (smooth == TRUE) {
  plot + geom_smooth(aes(group = 1), size = 1, method = smooth_method, se = smooth_se)
  } else {
    plot
  }
}
