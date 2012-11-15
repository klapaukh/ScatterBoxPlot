
# Using ggplot2 to draw a scatterplot and two marginal boxplots

# setwd("~/ADRA") 

# Load required packages
library(ggplot2)     # to draw the plots
library(grid)        # to arrange the plots

# Load the data
load("adra.RData")
summary(adra)

# Calculate correlation between the two variables
cor <- cor(adra$q19, adra$q20)

# Main scatterplot (with correlation insert)
plot1 <- ggplot(data = adra, aes(x = q19, y = q20)) + 
   geom_jitter(pch = 20, size = 1, colour = "red", 
      position = position_jitter(width = 0.1, height = 0.1)) +
   scale_x_continuous("Extent to which classroom practices have changed", breaks = 0:10) +
   scale_y_continuous("Extent to which you shared what you learned with others", breaks = 0:10) +
   geom_text(x = (.4+2.1)/2, y = (9.1+9.9)/2, 
      label = paste("r = ", round(cor, 2), sep = ""), size = 4) +
   geom_rect(xmin = .4, xmax = 2.1, ymin = 9.1, ymax = 9.9, colour = "black", fill = NA) +
   coord_equal() + theme_bw() +
   theme(axis.title.x = element_text(face = "bold", size = 12, vjust = 0), 
   axis.title.y = element_text(face = "bold", size = 12, angle = 90, vjust = .5),
   axis.text.x = element_text(size = 12*.8),
   axis.text.y = element_text(size = 12*.8),
   panel.grid.minor = element_blank(),
   panel.grid.major = element_blank(),
   panel.border = element_rect(colour = "black"),
   plot.margin= unit(c(0, -.4, 0.5,0 ), "lines"))

# Theme for the two marginal boxplots
theme_invisible <- 
    theme(
    axis.line = element_blank(),
    axis.text.x = element_text(colour = NA),
    axis.text.y = element_text(colour = NA),
    axis.ticks =  element_line(colour = NA),
    axis.title.x = element_text(colour = NA),
    axis.title.y = element_text(colour = NA),
    panel.background = element_rect(colour = NA, fill = NA), 
    panel.border = element_rect(colour = NA), 
    panel.grid.major = element_line(colour = NA),
    panel.grid.minor = element_line(colour = NA),
    plot.background = element_rect(colour = NA, fill = NA))

# Horizontal marginal boxplot - to appear at the top of  the chart
plot2 <- ggplot(data = adra, aes(x = factor(1), y = q19)) +
   geom_boxplot(width = 1.1, fill = "skyblue", outlier.colour = NA) +
   geom_jitter(pch = 20, size = 1, colour = "salmon", alpha = .3,
      position = position_jitter(width = 0.25, height = 0.15)) +
   scale_y_continuous(breaks = 0:10) +
   theme_bw() + 
   theme_invisible +
   coord_flip() +
   theme(plot.margin= unit(c(1, -.2, 0, .5), "lines"))

# Vertical marginal boxplot - to appear at the right of the chart
plot3 <- ggplot(data = adra, aes(x = factor(1), y = q20)) +
   geom_boxplot(width = 1.2, fill = "skyblue") +
   geom_jitter(pch = 20, size = 1, colour = "salmon", alpha = .3, 
      position = position_jitter(width = 0.25, height = 0.15)) +
   scale_y_continuous(breaks = 0:10) +
   theme_bw() + theme_invisible +
   theme(plot.margin= unit(c(-.2, 1, 0, 0), "lines"))

# Combine the scatterplot with the two marginal boxplots
lo <- grid.layout(nrow = 2, ncol = 2,
        widths = unit(c(1,5), c("null", "line")),
        heights = unit(c(5,1), c("line", "null")))

vplayout <- function(y, x) {
   viewport(layout.pos.col = y, layout.pos.row = x) }

grid.newpage()
pushViewport(viewport(layout = lo))
pushViewport(vplayout(1, 2))
grid.draw(ggplotGrob(plot1))
popViewport()
pushViewport(vplayout(1, 1))
grid.draw(ggplotGrob(plot2))
popViewport()
pushViewport(vplayout(2, 2))
grid.draw(ggplotGrob(plot3))
popViewport(2)
grid.rect(x = 0.5, y = 0.5, height = .995, width = .995, default.units = "npc", 
      gp = gpar(col="black", fill = NA, lwd = 1))
