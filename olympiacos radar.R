library(fmsb)
library(colormap)
library(gt)

Euroleague <- c(52.85, 50.14, 18.85, 101, 111.7, 1.34, 12.1, 5.1)
Eurocup <- c(50.7, 47.57, 18.53, 96.2, 107.4, 1.27, 12.89, 5.63)
p1 <- c(65.8, 66.7, 21.2, 121, 94.1, 6.5, 22.7, 11.7) # Hassan Martin
p2 <- c(57.7, 54.4, 20.9, 108.8, 114.2, 3.3, 13.7, 8.3) # Livio Jean-Charles
p3 <- c(43.3, 37.8, 12.6, 91.1, 107, 1.1, 11.5, 2.1) # Charles Jenkins
p4 <- c(60.2, 53.7, 23.8, 115.5, 111.7, 1.1, 5.6, 2) # Aaron Harrison
dat <- data.frame(rbind(Euroleague,Eurocup,p3,p2,p1,p4))
rownames(dat)<- c("Euroleague Average","Eurocup Average","Charles Jenkins", "Livio Jean-Charles", 
                  "Hassan Martin", "Aaron Harrison")
colnames(dat)<- c("TS%","eFG%","USG%","ORtg","DRtg","BLK%","DREB%","OREB%")
dat<-rbind(rep(121,8) , rep(0,8) , dat)


ci<-c(colormap(colormap=colormaps$winter, nshades=4, alpha=0.3))
cb<-c(colormap(colormap=colormaps$winter, nshades=4, alpha=1))
par(mar=rep(0.65,4))
png("radar.png", units="in", width=12, height=8, res=600)
par(mfrow=c(2,2))
for (i in 5:8){
radarchart(dat[c(1,2,i),],plwd=2,plty=1,pcol=cb[i-4],pfcol=ci[i-4],title=rownames(dat)[i],
           cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8, seg=4)
points(0,33,col="orange")
}
dev.off()

gt_el <- gt(data= cbind(colnames(dat),t(dat[c(5,6,3),])),rowname_col = "V1")
gt_el <- gt_el %>%
  tab_header(
    title = md("**Olympiacos' new players**"),
    subtitle = "Advanced stats Table, 2019-20 season"
  )
gt_el <- gt_el %>% 
  tab_source_note(
    source_note = "Source: @acbbstatscy"
  )
gt_el %>%
  gtsave(
    "gt_el.png", expand = 10,
    path = getwd()
  )

gt_ec <- gt(data= cbind(colnames(dat),t(dat[c(7,8,4),])),rowname_col = "V1")
gt_ec <- gt_ec %>%
  tab_header(
    title = md("**Olympiacos' new players**"),
    subtitle = "Advanced stats Table, 2019-20 season"
  )
gt_ec <- gt_ec %>% 
  tab_source_note(
    source_note = "Source: @acbbstatscy"
  )
gt_ec %>%
  gtsave(
    "gt_ec.png", expand = 10,
    path = getwd()
  )

