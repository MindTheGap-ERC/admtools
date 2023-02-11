#### Load Packages ####
#install.packages("ape")
#install.packages("DAIME")
#install.packages("phytools")
require(ape)
require(DAIME)
require(phytools)
require(FossilSim)

#### Auxiliary Functions ####
{
  ## finds precursor node in tree
  find_precursor=function(tree,nodeID){
    precursor=tree$edge[,1][tree$edge[,2]==nodeID]
    return(precursor)
  }
  
  ## finds root of tree
  find_root=function(tree,start_node=1){
    repeat{
      precursor=find_precursor(tree,start_node)
      if(length(precursor)==0) break
      start_node=precursor
    }
    return(start_node)
  }
  
  ## determines absolute age of a node, assuming their branch lengths is time
  get_node_age=function(tree,node){
    root=find_root(tree)
    if(node==root) return(0)
    else{
      precursor=find_precursor(tree,node)
      edge_length=tree$edge.length[tree$edge[,2]==node]
      node_age=get_node_age(tree,precursor)+ edge_length
      return(node_age)
    }
  }
  
  ## determines ages of all nodes
  get_all_node_ages=function(tree){
    noofnodes=length(tree$edge[,1])+1
    ages=rep(0,noofnodes)
    for (i in 1:noofnodes){
      ages[i]=get_node_age(tree,i)
    }
    return(ages)
  }
  
  ## updates branch lengths in a tree
  update_branch_lengths=function(tree,ages){
    for (i in 1:length(tree$edge.length)){
      start=tree$edge[i,1]
      end=tree$edge[i,2]
      tree$edge.length[i]=ages[end]-ages[start]
    }
    return(tree)
  }
  
  ## transforms a tree using an age model am
  transform.tree=function(tree,am){
    times=get_all_node_ages(tree)
    heights=approx(x=am$time,y=am$height,xout=times,yleft = 0,yright = hmax)$y
    tree.transformed=update_branch_lengths(tree,heights)
    return(tree.transformed)
  }
  
  ## transforms fossil occurrences using an age model am
  transform.foss.occ=function(foss.occ,am){
    remove.me=is.na(pointtransform(points=tmax-foss.occ$hmin,xdep=am$time,ydep=am$height,depositionmodel = "age model")$height)
    print(remove.me)
    foss.occ.height=hmax-approx(x=am$time,y=am$height,xout=tmax-foss.occ$hmin)$y
    foss.occ.transformed=update_fossil_ages(foss.occ.height,foss.occ)
    foss.occ.transformed=foss.occ.transformed[!remove.me,]
    return(foss.occ.transformed)
  }
  
  ## changes fossil ages in fossil object
  update_fossil_ages=function(foss_heights,fossils){
    fossils$hmin=foss_heights
    fossils$hmax=foss_heights
    return(fossils)
  }
}

#### Parameters ####
tmax=1
hmax=2
birth.rate=5
death.rate=1
sampling.rate=5
n.of.taxa=20

#### age models ####
agemodel.list=list()
## Age model 1
lam1=0.7
lam2=0.1
am1=list()
am1$time=c(0, lam1*tmax,tmax)
am1$height=c(0,lam2*hmax,hmax)
agemodel.list[['am1']]=am1
## age model 2
lam1=0.1
lam2=0.75
am2=list()
am2$time=c(0, lam1*tmax,tmax)
am2$height=c(0,lam2*hmax,hmax)
agemodel.list[["am2"]]=am2
## age model 3 ##
lam1=0.6
lam2=0.8 # lam1 <lam2
lam3=0.6
am3=list()
am3$time=c(0,lam1*tmax,lam2*tmax,tmax)
am3$height=c(0,lam3*hmax,lam3*hmax,hmax)
agemodel.list[["am3"]]=am3

#### generate original tree and fossil occurrences (in time) ####
set.seed(1)
tree.original=pbtree(b=birth.rate,d=death.rate,n=n.of.taxa,scale = tmax)
fossils.original= sim.fossils.poisson(rate = sampling.rate, tree = tree.original,root.edge = FALSE)
plot(fossils.original, tree = tree.original)

#### transform trees and fossil occurrences ####
tree.list=list()
tree.list[["original"]]=tree.original
for (am in names(agemodel.list)){
  tree.list[[am]]=transform.tree(tree.list[["original"]],agemodel.list[[am]])
}

fossil.list=list()
fossil.list[["original"]]=fossils.original
for (am in names(agemodel.list)){
  fossil.list[[am]]=transform.foss.occ(fossil.list[["original"]],agemodel.list[[am]])
}



#### transform rates (sampling, birth, death) ####
rate.list=list()

original.list=list()

birth.rate.list=list()
birth.rate.list$x=c(0,tmax)
birth.rate.list$y=rep(birth.rate,2)
original.list$birth.rate=birth.rate.list

death.rate.list=list()
death.rate.list$x=c(0,tmax)
death.rate.list$y=rep(death.rate,2)
original.list$death.rate=death.rate.list

sampling.rate.list=list()
sampling.rate.list$x=c(0,tmax)
sampling.rate.list$y=rep(sampling.rate,2)
original.list$sampling.rate=sampling.rate.list

rate.list$original=original.list

for (am in names(agemodel.list)){
  am.list=list()
  am.list$birth.rate=patterntransform(xdep=agemodel.list[[am]]$time,
                                 ydep=agemodel.list[[am]]$height,
                                 xpat=rate.list[["original"]][["birth.rate"]]$x,
                                 ypat=rate.list[["original"]][["birth.rate"]]$y,
                                 depositionmodel = "age model",
                                 pos=seq(0,tmax,length.out=500))
  am.list$death.rate=patterntransform(xdep=agemodel.list[[am]]$time,
                                 ydep=agemodel.list[[am]]$height,
                                 xpat=rate.list[["original"]][["death.rate"]]$x,
                                 ypat=rate.list[["original"]][["death.rate"]]$y,
                                 depositionmodel = "age model",
                                 pos=seq(0,tmax,length.out=500))
  am.list$sampling.rate=patterntransform(xdep=agemodel.list[[am]]$time,
                                 ydep=agemodel.list[[am]]$height,
                                 xpat=rate.list[["original"]][["sampling.rate"]]$x,
                                 ypat=rate.list[["original"]][["sampling.rate"]]$y,
                                 depositionmodel = "age model",
                                 pos=seq(0,tmax,length.out=500))
  rate.list[[am]]=am.list
}



#### plot results ####
ratenames=c("birth.rate"         ,"death.rate"   ,      "sampling.rate")

## original
jpeg("original_tree.jpeg")
plot(fossil.list[["original"]], tree = tree.list[["original"]],show.axis = TRUE,main="original tree")
axis(1)
mtext("Time",side=1,line=2)
dev.off()

for (rname in ratenames){
  jpeg(paste("original_",rname,".jpeg"))
  plot(rate.list[["original"]][[rname]],type = "l",
       xlab="time",
       ylab=rname,
       ylim = c(0,1.2*max(rate.list[["original"]][[rname]]$y)),
       main= paste("original ",rname))
  dev.off()
}

## transformed by age models
for (am in names(agemodel.list)){
  
  jpeg(paste(am,"age model .jpeg"))
  plot(agemodel.list[[am]]$time,
       agemodel.list[[am]]$height,
       type="l",
       xlab="Time",
       ylab="Stratigraphic Height",
       main=paste("Age Model ", am))
  dev.off()
  
  jpeg(paste(am,"_tree.jpeg"))
  plot(fossil.list[[am]],
       tree = tree.list[[am]],
       show.axis = TRUE,
       main=paste("tree observed in the section generated by age model ", am))
  axis(1)
  mtext("Stratigraphic Height",side=1,line=2)
  dev.off()
  
  for (rname in ratenames){
    jpeg(paste(am,"_",rname,".jpeg"))
    plot(x=rate.list[[am]][[rname]]$height,
         y=rate.list[[am]][[rname]]$val,
         type = "l",
         xlab="Stratigraphic Height",
         ylab=rname,
         ylim = c(0,1.2*max(rate.list[[am]][[rname]]$val[is.finite(rate.list[[am]][[rname]]$val)])),
         main= paste(rname, "transformed by age model", am ))
    dev.off()
  }
  
}

