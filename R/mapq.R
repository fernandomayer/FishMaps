mapq <- function(year, quarter, lat, lon, cfu, breaks, type = c("LL","BB"), ident = TRUE,
    ident.type = c("num","let"), ident.cex = 1, xlim = NULL, ylim = NULL, majortick = NULL,
    minortick = NULL, mapgrid = TRUE, legend = TRUE, leg.pos = "bottomright", leg.cex = 1,
    leg.title = NULL, fig = FALSE, fig.type = c("png","pdf"), fig.w, fig.h, fig.name,
    fig.par = NULL, ...)
{
    # checks and error messages
    if(!is.numeric(year) & !is.factor(year)) stop("Argument 'year' must be numeric or factor")
    if(!is.numeric(quarter) & !is.factor(quarter)) stop("Argument 'quarter' must be numeric,
        or factor")
    if(!is.numeric(lat)) stop("Argument 'lat' must be numeric or integer")
    if(!is.numeric(lon)) stop("Argument 'lon' must be numeric or integer")
    if(!is.numeric(cfu)) stop("Argument 'cfu' must be numeric or integer")
    if(ident == FALSE & !missing(ident.type)) stop("Argument 'ident.type' must be used only when
        'ident = TRUE'")
    if(ident == FALSE & !missing(ident.cex)) stop("Argument 'ident.cex' must be used only when
        'ident = TRUE'")
    if(!is.null(xlim) & !is.null(ylim) & !missing(type)) stop("Argument 'type' is not valid when
        'xlim' and 'ylim' are specified")
    if(!missing(xlim) & missing(ylim) | missing(xlim) & !missing(ylim)) stop("When one of
        'xlim/ylim' is specified, the other 'xlim/ylim' must also be specified")
    if(!missing(xlim) & !missing(ylim))
    {
        if(is.null(majortick) | is.null(minortick)) stop("When 'xlim/ylim' are specified,
            'majortick' and 'minortick' must also be specified")
    }
    if(!is.null(mapgrid) & !is.logical(mapgrid)) stop("Argument 'mapgrid' must be logical")
    if(!is.null(majortick) & !is.numeric(majortick)) stop("Argument 'majortick' must be numeric")
    if(!is.null(minortick) & !is.numeric(minortick)) stop("Argument 'minortick' must be numeric")
    if(legend == FALSE)
    {
        if(!missing(leg.pos) | !missing(leg.cex) | !missing(leg.title)) stop("When
            legend = FALSE, arguments 'leg.pos', 'leg.cex' or 'leg.title' can't be specified")
    }
    if(!is.character(leg.pos)) stop("Argument 'leg.pos' must be character and one of 'bottomright',
        'bottom', 'bottomleft', 'left', 'topleft', 'top', 'topright', 'right', 'center'")
    if(!is.null(leg.title) & !is.character(leg.title)) stop("Argument 'leg.title' must be
        character")
    if(fig == TRUE)
    {
        if(!is.numeric(fig.w) | !is.numeric(fig.h)) stop("Arguments 'fig.w' and/or 'fig.h' must be
            numeric")
        if(!is.character(fig.name)) stop("Argument 'fig.name' must be character")
    }
    if(!is.null(fig.par) & !is.list(fig.par)) stop("Argument 'fig.par' must be a list")
    # find the breaks and 'cut' the data.
    if(any(cfu == 0))
    {
    # points.idx must have the same length as cfu, otherwise the points are not plotted in the
    # function points() below.
        points.idx <- rep(0,length(cfu))
        points.idx[cfu!=0] <- cut(cfu[cfu!=0],breaks,include.lowest=TRUE,labels=FALSE)
        legend.text <- levels(cut(cfu[cfu!=0],breaks,include.lowest=TRUE))
    }
    else
    {
        points.idx <- cut(cfu,breaks,include.lowest=TRUE,labels=FALSE)
        legend.text <- levels(cut(cfu,breaks,include.lowest=TRUE))
    }
    # extract the levels (uniques) of the years and quarters
    if(is.factor(year) | is.factor(quarter))
    {
        lev.year <- as.numeric(levels(year))
        lev.quarter <- as.numeric(levels(quarter))
    }
    else
    {
        lev.year <- sort(unique(year))
        lev.quarter <- sort(unique(quarter))
    }
    # pre-defined maps
    if(is.null(xlim) & is.null(ylim))
    {
        type <- match.arg(type)
        switch(type,
            LL = {
               	if(fig == FALSE)
               	{
               	    par(ask=TRUE)
               	}
               	for(i in lev.year)
            	{
        		    for (j in lev.quarter)
        		    {
            		    if(fig == TRUE)
        		        {
            		        fig.type <- match.arg(fig.type)
                            switch(fig.type,
                                png = {png(filename=paste("map_",fig.name,"_",i,"_",j,".png",sep=""),
                                    width=fig.w, height=fig.h)},
                                pdf = {pdf(file=paste("map_",fig.name,"_",i,"_",j,".pdf",sep=""),
                                    width=fig.w, height=fig.h)}
                            )
                            par(fig.par)
                        }
            		    # uses the pre-defined map, with its arguments
            		    mapLL(...)
            		    # map identification
            		    if(ident == TRUE)
            		    {
            		        ident.type <- match.arg(ident.type)
            		        switch(ident.type,
            		            num = {text(par("usr")[1],par("usr")[4],paste(i,j,sep="/"), font=2,
            		                adj=c(-0.4,1.5), cex=ident.cex)},
            		            let = {text(par("usr")[1],par("usr")[4],LETTERS[which(lev.year==i)],
            		                font=2, adj=c(-1,1.5), cex=ident.cex)}
            		        )
            		    }
            		    # add points and legend when cfu has zeros
            		    if(any(cfu == 0))
            		    {
            		        points(lon[year==i & quarter==j & cfu==0],
            		            lat[year==i & quarter==j & cfu==0], pch=3, cex=1)
            		        points(lon[year==i & quarter==j & cfu!=0],
            		            lat[year==i & quarter==j & cfu!=0], pch=19,
            		            cex=points.idx[year==i & quarter==j & cfu!=0])
            		        # legend
            		        if(legend == TRUE)
            		        {
                		        ifelse(length(breaks) > 1,
                		            num.class <- length(breaks), # it should be -1, but has the 0 class
                		            num.class <- breaks+1) # +1 because of the 0 class
                		        text.width <- max(strwidth(legend.text))
                		        temp <- legend(leg.pos, legend=rep(" ",num.class),
                		            text.width=text.width, bg="white",
                		            y.intersp=(num.class-1)/2.5, # 2.5 is a random number
                		            pch=c(3,rep(19,(num.class-1))),
                		            pt.cex=c(1,1:(num.class-1)),
                		            cex=leg.cex)
                		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
                		            labels=c("0",legend.text), cex=leg.cex)
                		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
                		            cex=leg.cex, pos=3)
                		    }
            		    }
            		    # add points and legend when cfu has NO zeros
            		    else
            		    {
            		        points(lon[year==i & quarter==j], lat[year==i & quarter==j], pch=19,
            		            cex=points.idx[year==i & quarter==j])
            		        # legend
            		        if(legend == TRUE)
            		        {
                		        ifelse(length(breaks) > 1,
                		            num.class <- length(breaks)-1,
                		            num.class <- breaks)
                		        text.width <- max(strwidth(legend.text))
                		        temp <- legend(leg.pos, legend=rep(" ",num.class),
                		            text.width=text.width, bg="white",
                		            pch=19, pt.cex=1:num.class, cex=leg.cex,
                		            y.intersp=num.class/2.5)
                		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
                		            labels=legend.text, cex=leg.cex)
                		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
                		            cex=leg.cex, pos=3)
                		    }
            		    }
            		    if(fig == TRUE)
            		    {
            		        dev.off()
            		    }
            		}
        		}
        		if(fig == FALSE)
        		{
        		    par(ask=FALSE)
        		}
        	},
            BB = {
                if(fig == FALSE)
                {
                    par(ask=TRUE)
                }
                for(i in lev.year)
            	{
            	    for(j in lev.quarter)
            	    {
            		    if(fig == TRUE)
        		        {
            		        fig.type <- match.arg(fig.type)
                            switch(fig.type,
                                png = {png(filename=paste("map_",fig.name,"_",i,"_",j,".png",sep=""),
                                    width=fig.w, height=fig.h)},
                                pdf = {pdf(file=paste("map_",fig.name,"_",i,"_",j,".pdf",sep=""),
                                    width=fig.w, height=fig.h)}
                            )
                            par(fig.par)
                        }
            		    # uses the pre-defined map, with its arguments
            		    mapBB(...)
            		    # map identification
            		    if(ident == TRUE)
            		    {
            		        ident.type <- match.arg(ident.type)
            		        switch(ident.type,
            		            num = {text(par("usr")[1],par("usr")[4],paste(i,j,sep="/"), font=2,
            		                adj=c(-0.4,1.5), cex=ident.cex)},
            		            let = {text(par("usr")[1],par("usr")[4],LETTERS[which(lev.year==i)],
            		                font=2, adj=c(-1,1.5), cex=ident.cex)}
            		        )
            		    }
            		    # add points and legend when cfu has zeros
            		    if(any(cfu == 0))
            		    {
            		        points(lon[year==i & quarter==j & cfu==0],
            		            lat[year==i & quarter==j & cfu==0], pch=3, cex=1)
            		        points(lon[year==i & quarter==j & cfu!=0],
            		            lat[year==i & quarter==j & cfu!=0], pch=19,
            		            cex=points.idx[year==i & quarter==j & cfu!=0])
            		        # legend
            		        if(legend == TRUE)
            		        {
                		        ifelse(length(breaks) > 1,
                		            num.class <- length(breaks), # it should be -1, but has the 0 class
                		            num.class <- breaks+1) # +1 because of the 0 class
                		        text.width <- max(strwidth(legend.text))
                		        temp <- legend(leg.pos, legend=rep(" ",num.class),
                		            text.width=text.width, bg="white",
                		            y.intersp=(num.class-1)/2.5,
                		            pch=c(3,rep(19,(num.class-1))),
                		            pt.cex=c(1,1:(num.class-1)),
                		            cex=leg.cex)
                		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
                		            labels=c("0",legend.text), cex=leg.cex)
                		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
                		            cex=leg.cex, pos=3)
                		    }
            		    }
            		    # add points and legend when cfu has NO zeros
            		    else
            		    {
            		        points(lon[year==i & quarter==j], lat[year==i & quarter==j], pch=19,
            		            cex=points.idx[year==i & quarter==j])
            		        # legend
            		        if(legend == TRUE)
            		        {
                		        ifelse(length(breaks) > 1,
                		            num.class <- length(breaks)-1,
                		            num.class <- breaks)
                		        text.width <- max(strwidth(legend.text))
                		        temp <- legend(leg.pos, legend=rep(" ",num.class),
                		            text.width=text.width, bg="white",
                		            pch=19, pt.cex=1:num.class, cex=leg.cex,
                		            y.intersp=num.class/2.5)
                		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
                		            labels=legend.text, cex=leg.cex)
                		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
                		            cex=leg.cex, pos=3)
                		    }
            		    }
            		    if(fig == TRUE)
            		    {
            		        dev.off()
            		    }
            		}
        		}
        		if(fig == FALSE)
        		{
        		    par(ask=FALSE)
        		}
        	})
    }
    # user-defined maps
    else
    {
        if(fig == FALSE)
        {
            par(ask=TRUE)
        }
        for(i in lev.year)
    	{
    	    for(j in lev.quarter)
    	    {
    		    if(fig == TRUE)
		        {
    		        fig.type <- match.arg(fig.type)
                    switch(fig.type,
                        png = {png(filename=paste("map_",fig.name,"_",i,"_",j,".png",sep=""),
                            width=fig.w, height=fig.h)},
                        pdf = {pdf(file=paste("map_",fig.name,"_",i,"_",j,".pdf",sep=""),
                            width=fig.w, height=fig.h)}
                    )
                    par(fig.par)
                }
    		    map(xlim=xlim,ylim=ylim,plot=TRUE,add=FALSE,fill=TRUE,col="lightgrey",...)
    		    par(las=1)
            	degAxis(1,seq(xlim[1],xlim[2],majortick))
            	degAxis(2,seq(ylim[1],ylim[2],majortick))
            	axis(1,seq(xlim[1],xlim[2],minortick),labels=FALSE)
            	axis(2,seq(ylim[1],ylim[2],minortick),labels=FALSE)
                par(las=0)
            	if(mapgrid == TRUE)
            	{
            		abline(v=seq(xlim[1],xlim[2],minortick),h=seq(ylim[1],ylim[2],minortick),
            		    lty="dotted",lwd=1)
            	}
            	map(xlim=xlim,ylim=ylim,plot=TRUE,add=TRUE,fill=TRUE,col="lightgrey",...)
                box()
    		    if(ident == TRUE)
    		    {
    		        ident.type <- match.arg(ident.type)
    		        switch(ident.type,
    		            num = {text(par("usr")[1],par("usr")[4], paste(i,j,sep="/"), font=2,
    		                adj=c(-0.4,1.5), cex=ident.cex)},
    		            let = {
    		                text(par("usr")[1],par("usr")[4], LETTERS[which(lev.year==i)],
    		                font=2, adj=c(-1,1.5), cex=ident.cex)}
    		        )
    		    }
                # add points and legend when cfu has zeros
    		    if(any(cfu == 0))
    		    {
    		        points(lon[year==i & quarter==j & cfu==0], lat[year==i & quarter==j & cfu==0],
    		            pch=3, cex=1)
    		        points(lon[year==i & quarter==j & cfu!=0], lat[year==i & quarter==j & cfu!=0],
    		            pch=19, cex=points.idx[year==i & quarter==j & cfu!=0])
    		        # legend
    		        if(legend == TRUE)
    		        {
        		        ifelse(length(breaks) > 1,
        		            num.class <- length(breaks), # it should be -1, but has the 0 class
        		            num.class <- breaks+1) # +1 because of the 0 class
        		        text.width <- max(strwidth(legend.text))
        		        temp <- legend(leg.pos, legend=rep(" ",num.class),
        		            text.width=text.width, bg="white",
        		            y.intersp=(num.class-1)/2.5,
        		            pch=c(3,rep(19,(num.class-1))),
        		            pt.cex=c(1,1:(num.class-1)),
        		            cex=leg.cex)
        		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
        		            labels=c("0",legend.text), cex=leg.cex)
        		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
        		            cex=leg.cex, pos=3)
        		    }
    		    }
    		    # add points and legend when cfu has NO zeros
    		    else
    		    {
    		        points(lon[year==i & quarter==j], lat[year==i & quarter==j], pch=19,
    		            cex=points.idx[year==i & quarter==j])
    		        # legend
    		        if(legend == TRUE)
    		        {
        		        ifelse(length(breaks) > 1,
        		            num.class <- length(breaks)-1,
        		            num.class <- breaks)
        		        text.width <- max(strwidth(legend.text))
        		        temp <- legend(leg.pos, legend=rep(" ",num.class),
        		            text.width=text.width, bg="white",
        		            pch=19, pt.cex=1:num.class, cex=leg.cex,
        		            y.intersp=num.class/2.5)
        		        text(temp$rect$left + temp$rect$w, temp$text$y, pos=2,
        		            labels=legend.text, cex=leg.cex)
        		        text(temp$rect$left+temp$rect$w/2, temp$rect$top, labels=leg.title,
        		            cex=leg.cex, pos=3)
        		    }
    		    }
    		    if(fig == TRUE)
    		    {
    		        dev.off()
    		    }
    		}
		}
		if(fig == FALSE)
		{
		    par(ask=FALSE)
		}
    }
}
