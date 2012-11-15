#ScatterBoxPlot

####Using ggplot2 to draw a scatterplot and the two marginal boxplots

This repository contains [`R`](http://www.cran.r-project.org/) code for a scatterplot and the two marginal boxplots. The separate graphs (a scatterplot and two boxplots) are drawn using the [`ggplot2`](http://cran.r-project.org/web/packages/ggplot2/) package. The three graphs are combined into one chart using functions from the [`grid`](http://stat.ethz.ch/R-manual/R-patched/library/grid/html/00Index.html)

It needs some work, but for now, it is working. If I get time, I'll come back to it. 

The data are taken from a survey that was part of a three-year study investigating the use of action research for building and sustaining professional learning communities for primary school teachers in remote areas of Papua New Guinea. The project was conducted between 2010 and 2012. It was funded by the Australian Development Research Awards (ADRA) and is entitled, *Identifying strategies to sustain professional learning communities for teachers in remote primary schools in Papua New Guinea*. The project was conducted by researchers from the National Research Institute in Port Moresby (Patricia Paraide and Medi Reta), The University of Queensland in Brisbane (Eileen Honan and Sandy Muspratt), and Deakin University in Geelong (Terry Evans).

The data used here are contained in the `adra.RData` file. Before running the code, make sure the data file is in your working directory.

The data are teachers' responses to two questions concerned with the effects of professional learning activities: "To what extent have your classroom practices changed?"; and "To what extent have you shared with others what you learned?". Teachers responded on eleven-point scales. For the first question, the end points of the scale were labelled: 0 = "None" and 10 = "Significantly". For the second question, the end points were labelled: 0 = "Shared nothing" and 10 = "Shared everything".  

[![ScatterBoxPlot](https://dl.dropbox.com/u/16954433/ScatterBox.png)](https://dl.dropbox.com/u/16954433/ScatterBox.png)


