#' Plot latent change score model path diagram
#'
#' @param object lavaan object.
#' @param layout Matrix specifying location of manifest and latent variables. 
#' @param what See \code{semPlot}.
#' @param whatLabels see \code{semPlot}.
#' @param edge.width see \code{semPlot}.
#' @param node.width  see \code{semPlot}.
#' @param border.width  see \code{semPlot}.
#' @param fixedStyle  see \code{semPlot}.
#' @param freeStyle  see \code{semPlot}.
#' @param residuals  see \code{semPlot}.
#' @param label.scale  see \code{semPlot}.
#' @param sizeMan  see \code{semPlot}.
#' @param sizeLat  see \code{semPlot}.
#' @param intercepts  see \code{semPlot}.
#' @param fade  see \code{semPlot}.
#' @param nCharNodes  see \code{semPlot}.
#' @param nCharEdges  see \code{semPlot}.
#' @param ... Other functions passed on to \code{semPlot}.  
#'
#' @return Plot
#' @export 
#'
#' @examples TODO
plot_lcsm <- function(object,
                      layout,
                      curve_covar = .5,
                      what = "col",
                      whatLabels = "est",
                      edge.width = 1,
                      node.width = 1,
                      border.width = 1,
                      fixedStyle = 1,
                      freeStyle = 1,
                      residuals = FALSE,
                      label.scale = FALSE,
                      sizeMan = 3,
                      sizeLat = 5,
                      intercepts = FALSE,
                      fade = FALSE,
                      nCharNodes = 0,
                      nCharEdges = 0,
                      edge.label.cex = 0.5,
                      DoNotPlot = TRUE,
                      ...) {
  
  graph <- semPlot::semPaths(
           object = object,
           layout = layout,
           what = what,
           whatLabels = whatLabels,
           edge.width = edge.width,
           node.width = node.width,
           border.width = border.width,
           fixedStyle = fixedStyle,
           freeStyle = freeStyle,
           residuals = residuals,
           label.scale = label.scale,
           sizeMan = sizeMan,
           sizeLat = sizeLat,
           intercepts = intercepts,
           fade = fade,
           nCharNodes = 0,
           nCharEdges = 0,
           DoNotPlot = DoNotPlot,
           ...)
  
  graph$graphAttributes$Edges$curve <- ifelse(graph$Edgelist$bidir, curve_covar, 0)
  
  plot(graph)
}

