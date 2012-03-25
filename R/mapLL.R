mapLL <- function(grid = TRUE, names = FALSE, map.data = c("world","worldHires"),...)
{
    map.data <- match.arg(map.data)
	map(map.data,xlim=c(-65,-20),ylim=c(-55,-10),border=0,fill=TRUE, col="lightgrey", plot=TRUE,
	    add=FALSE,...)
	par(las=1)
	degAxis(1,seq(-60,-20,10))
	degAxis(2,seq(-50,-10,10))
	axis(1,seq(-60,-20,5),labels=FALSE)
	axis(2,seq(-50,-10,5),labels=FALSE)
    par(las=0)
	if(grid==TRUE)
	{
		abline(v=seq(-65,-20,5),h=seq(-55,-10,5),lty="dotted",lwd=1)
	}
	map(map.data,xlim=c(-65,-20),ylim=c(-55,-10),border=0,fill=TRUE, col="lightgrey", plot=TRUE,
	    add=TRUE,...)
    box()
	if(names==TRUE)
	{
		text(-47.2,-17.5,"BRAZIL",cex=par("cex.axis"))
		text(-56,-33,"URU",cex=par("cex.axis"))
		text(-62.5,-36.5,"ARG",cex=par("cex.axis"))
	}
}
