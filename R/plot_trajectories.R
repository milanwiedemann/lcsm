#' Plot individual trajectories
#' @description Plot individual trajectories
#' @param data Dataset in wide format.
#' @param id_var String, specifying id variable.
#' @param var_list Vector, specifying variable names to be plotted in sequential order.
#' @param line_colour String, specifying colour of lines.
#' @param group_var String, specifying variable name of group, each group will get individual colour lines. This overwrites the line_colour argument. 
#' Also consider other options to look at trajectories like \link[ggplot2]{facet_wrap} which may be more appropriate.
#' @param point_colour String, specifying, colour of points.
#' @param line_alpha Numeric, specifying alpha of lines.
#' @param point_alpha Numeric, specifying alpha of points.
#' @param point_size Numeric, size of  point
#' @param smooth Logical, add moothed conditional means using \link[ggplot2]{geom_smooth}.
#' @param smooth_method String, specifying method to be used for calculating average line, see \link[ggplot2]{geom_smooth}.
#' @param smooth_se Locical, specifying whether to add standard error of average line or not.
#' @param xlab String for x axis label.
#' @param ylab String for y axis label.
#' @param scale_x_num Logical, if \code{TRUE} print sequential numbers starting from 1 as x axis labels, if \code{FALSE} use variable names.
#' @param scale_x_num_start Numeric, if \code{scale_x_num = TRUE} this is the starting value of the x axis.
#' @param random_sample_frac The fraction of rows to select (from wide dataset), default is set to 1 (100 percent) of the sample.
#' @param connect_missing Logical, speciying whether to connect points by \code{id_var} across missing values.
#' @param title_n Logical, speciying whether to print title with number and percentage of cases used for the plot.
#' @examples 
#' # Create plot for construct x
#' plot_trajectories(data = data_bi_lcsm,
#'                   id_var = "id", 
#'                   var_list = c("x1", "x2", "x3", "x4", "x5", 
#'                                "x6", "x7", "x8", "x9", "x10"))
#' 
#' # Create plot for construct y specifying some ather arguments
#' plot_trajectories(data = data_bi_lcsm,
#'                   id_var = "id", 
#'                   var_list = c("y1", "y2", "y3", "y4", "y5", 
#'                                "y6", "y7", "y8", "y9", "y10"),
#'                   xlab = "Time", ylab = "Y Score",
#'                   connect_missing = FALSE, random_sample_frac = 0.5)
#' 
#' @return ggplot2 object
#' @export

plot_trajectories <- function(data, id_var, var_list, line_colour = "blue", group_var = NULL, point_colour = "black", line_alpha = .2, point_alpha = .2, point_size = 1, smooth = FALSE, smooth_method = "loess", smooth_se = FALSE, xlab = "X", ylab = "Y", scale_x_num = FALSE, scale_x_num_start = 1, random_sample_frac = 1, title_n = FALSE, connect_missing = TRUE){
  
  data <- dplyr::sample_frac(tbl = data, size = random_sample_frac)
  
  var_names <- names(data)
  var_names_wide <- var_names[!var_names %in% var_list]
  
  data_plot <- data %>% 
    # dplyr::select(id_var, var_list) %>%
    tidyr::gather(variable, value, -var_names_wide) %>% 
    dplyr::mutate(variable = factor(variable, var_list))
  

  
  if (is.null(group_var) == TRUE) {
    plot <- data_plot %>%
      ggplot2::ggplot(ggplot2::aes(x = variable, y = value, group = !!rlang::sym(id_var))) +
      ggplot2::labs(x = xlab, y = ylab) +
      ggplot2::theme_classic() +
      ggplot2::theme(text = ggplot2::element_text(size = 12))
    
    if (connect_missing == TRUE) {
      plot <- plot + ggplot2::geom_line(data = data_plot[!is.na(data_plot$value), ], 
                                        colour = line_colour, 
                                        alpha = line_alpha)
    } else if (connect_missing == FALSE) {
      plot <- plot + ggplot2::geom_line(data = data_plot, 
                                        colour = line_colour, 
                                        alpha = line_alpha)
    }
  } else if (is.null(group_var) == FALSE)
  plot <- data_plot %>%
    ggplot2::ggplot(ggplot2::aes(x = variable, y = value, group = !!rlang::sym(id_var), colour = factor(!!rlang::sym(group_var)))) +
    ggplot2::labs(x = xlab, y = ylab) +
    ggplot2::theme_classic() +
    ggplot2::theme(text = ggplot2::element_text(size = 12)) +
    ggplot2::scale_colour_viridis_d()

  if (connect_missing == TRUE) {
    plot <- plot + ggplot2::geom_line(data = data_plot[!is.na(data_plot$value), ], alpha = line_alpha)
  } else if (connect_missing == FALSE) {
    plot <- plot + ggplot2::geom_line(data = data_plot, alpha = line_alpha)
  }


  plot <- plot + ggplot2::geom_point(colour = point_colour, alpha = point_alpha, size = point_size)

  if (title_n == TRUE){
    plot <- plot + ggplot2::ggtitle(paste0("N = ", nrow(data), " (", round(random_sample_frac * 100, 2), "% of the sample)"))
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
