mapBB<-function(grid = TRUE, names = FALSE, map.data = c("world","worldHires"),...)
{
    map.data <- match.arg(map.data)
	map(map.data,xlim=c(-55,-40),ylim=c(-35,-20),border=0,fill=TRUE, col="lightgrey", plot=TRUE,
	    add=FALSE,...)
	par(las=1)
	degAxis(1,seq(-54,-40,2))
	degAxis(2,seq(-34,-20,2))
	axis(1,seq(-54,-40,1),labels=FALSE)
	axis(2,seq(-34,-20,1),labels=FALSE)
    par(las=0)
	if(grid==TRUE)
	{
		abline(v=seq(-54,-40,1),h=seq(-34,-20,1),lty="dotted",lwd=1)
	}
	map(map.data,xlim=c(-55,-40),ylim=c(-35,-20),border=0,fill=TRUE, col="lightgrey", plot=TRUE,
	    add=TRUE,...)
    box()
	if(names==TRUE)
	{
        text(-48.8,-21.5,"BRAZIL",cex=par("cex.axis"))
	}
}
