
library(ggplot2)
library(gtable)

load("adra.RData")

# Calculate correlation between the two variables
cor <- cor(adra$q19, adra$q20)

# Main scatterplot (with correlation insert)
p1 <- ggplot(adra, aes(q19, q20)) + 
   geom_jitter(pch = 20, size = 1, colour = "red",
      position = position_jitter(width = 0.1, height = 0.1)) +
   scale_x_continuous("Extent to which classroom practices have changed", 
      breaks = 0:10, expand = c(0, 0)) +
   scale_y_continuous("Extent to which you shared what you learned with others", 
      breaks = 0:10, expand = c(0, 0)) +
   geom_text(x = (0.4 + 2.1)/2, y = (9.1 + 9.9)/2,
      label = paste("r = ", round(cor, 2), sep = ""), size = 4) +
   geom_rect(xmin = .4, xmax = 2.1, ymin = 9.1, ymax = 9.9, colour = "black", fill = NA) +
   expand_limits(x = c(-0.75, 10.75), y = c(-0.75, 10.75))  +
   theme_bw() +
   theme(panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_rect(colour = "black"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold", angle = 90),
    plot.margin= unit(c(.1, .1, .5, .5), "lines"))

# Horizontal marginal boxplot - to appear at the top of the chart
p2 <- ggplot(adra, aes(x = factor(1), y = q19)) + 
    geom_boxplot(width = .8, fill = "skyblue", outlier.colour = NA) + 
    geom_jitter(pch = 20, size = 1, colour = "red", alpha = .3,
    position = position_jitter(width = 0.15, height = 0.15)) +
    scale_y_continuous(breaks = 0:10, expand = c(0, 0)) +
    expand_limits(y = c(-0.75, 10.75))  +
    coord_flip() + 
    theme_bw() + 
    theme(panel.grid.minor = element_blank(),
     panel.grid.major = element_blank(),
     axis.text = element_blank(),
     axis.title = element_blank(),
     axis.ticks =  element_blank(),
     panel.border = element_rect(colour = NA),
     plot.margin= unit(c(1, .1, -1, 0.5), "lines"))

# Vertical marginal boxplot - to appear at the right of the chart
p3 <- ggplot(adra, aes(x = factor(1), y = q20)) + 
     geom_boxplot(width = .8, fill = "skyblue", outlier.colour = NA) +
     geom_jitter(pch = 20, size = 1, colour = "red", alpha = .3,
     position = position_jitter(width = 0.15, height = 0.15)) +
     scale_y_continuous(breaks = 0:10, expand = c(0, 0)) +
     expand_limits(y = c(-0.75, 10.75))  +
     theme_bw() + 
     theme(panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      axis.ticks =  element_blank(),
      panel.border = element_rect(colour = NA),
      plot.margin= unit(c(.1, 1, 0.5, -1), "lines"))


gt1 <- ggplot_gtable(ggplot_build(p1))
gt2 <- ggplot_gtable(ggplot_build(p2))
gt3 <- ggplot_gtable(ggplot_build(p3))

# Get maximum widths and heights for x-axis and y-axis title and text
maxWidth = unit.pmax(gt1$widths[2:3], gt2$widths[2:3])
maxHheight = unit.pmax(gt1$heights[4:5], gt3$heights[4:5])

# Set the maximums in the gtables for gt1, gt2 and gt3
gt1$widths[2:3] <- as.list(maxWidth)
gt2$widths[2:3] <- as.list(maxWidth)

gt1$heights[4:5] <- as.list(maxWidth)
gt3$heights[4:5] <- as.list(maxWidth)

# Combine the scatterplot with the two marginal boxplots
# Create a new gtable
gt <- gtable(widths = unit(c(7, 1), "null"), height = unit(c(1, 7), "null"))

# Instert gt1, gt2 and gt3 into the new gtable
gt <- gtable_add_grob(gt, gt1, 2, 1)
gt <- gtable_add_grob(gt, gt2, 1, 1)
gt <- gtable_add_grob(gt, gt3, 2, 2)

# And render the plot
grid.newpage()
grid.draw(gt)

grid.rect(x = 0.5, y = 0.5, height = .995, width = .995, default.units = "npc",
      gp = gpar(col="black", fill = NA, lwd = 1)) 
