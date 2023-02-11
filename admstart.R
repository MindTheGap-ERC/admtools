as.ADM=function(...,omission="destructive",silent=TRUE){
  {
    iList=list(...)
    #### 1. Check Inputs ####
    # need numeric inputs
    if(!all(sapply(iList, function(x) is.numeric(x)))){
      stop("need numeric inputs for ...")
    }
    # all inputs need to be vectors
    if(!all(sapply(iList, function(x) is.vector(x)))){
      stop("need vectors as inputs for ...")
    }
    # need two inputs
    if(length(iList)!=2){
      stop("expecting two input variables for ...")
    }
    # all input values need to be finite
    if(!all(sapply(iList, function(x) all(is.finite(x))))){
      stop("need finite values in inputs for ...")
    }
    
    #### 2. Make sense of inputs ####
    # remove capitalization
    iNames=tolower(names(iList))
    
    sRateInput=iNames %in% c("s","sed","srate","sedrate","sedimentation","sedimentationrate","sedimentation_rate","sedimentation rate")
    condInput=iNames %in% c("c","cond","condensation")
    timeInput=iNames %in% c("t","time")
    ageInput=iNames %in% c("a","age")
    heightInput=iNames %in% c("h","height","strat","strat height","stratheight","strat_height")
    depthInput=iNames %in% c("d","depth")
    
    # if one input type appears twice: stop
    duplInputs=sapply(list(sRateInput,condInput,timeInput,ageInput,heightInput,depthInput), function(x) sum(x)==2)
    if(any(duplInputs)){
      stop("input types duplicatd")
    }
    
    #### 3. Input data treatment ####
    if(any(timeInput) & any(heightInput)){
      TMode="time"
      LMode="height"
      t=unname(unlist(iList[timeInput]))
      h=unname(unlist(iList[heightInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from tiepoints in time and height, but found duplicated time values")
      }
      if(length(t)<2 | length(h)<2){
        stop("Tried to build age-depth model from tiepoints in time and height, but need at least two time points and height points")
        
      }
      if(length(t)!=length(h)){
        stop("Tried to build age-depth model from tiepoints in time and height, but number of time points does not match number of height points")
      }
      tsort=sort(t,decreasing = FALSE,index.return=TRUE)
      t=tsort$x
      h=h[tsort$ix]
      mode="age depth model"
      xdep=t
      ydep=h
      report="Age-depth-model generated from tie points in time and stratigraphic height."
      
    } else if(any(timeInput) & any(depthInput)){
      TMode="time"
      LMode="depth"
      t=unname(unlist(iList[timeInput]))
      h=-unname(unlist(iList[depthInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from tiepoints in time and depth, but found duplicated time values")
      }
      if(length(t)<2 | length(h)<2){
        stop("Tried to build age-depth model from tiepoints in time and depth, but need at least two time points and depth points")
        
      }
      if(length(t)!=length(h)){
        stop("Tried to build age-depth model from tiepoints in time and depth, but number of time points does not match number of depth points")
      }
      tsort=sort(t,decreasing = FALSE,index.return=TRUE)
      t=tsort$x
      h=h[tsort$ix]
      mode="age depth model"
      xdep=t
      ydep=h
      report="Age-depth-model generated from tie points in time and depth."
      
    } else if(any(ageInput) & any(heightInput)){
      TMode="age"
      LMode="height"
      t=-unname(unlist(iList[ageInput]))
      h=unname(unlist(iList[heightInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from tiepoints in age and height, but found duplicated age values")
      }
      if(length(t)<2 | length(h)<2){
        stop("Tried to build age-depth model from tiepoints in age and height, but need at least two age points and height points")
        
      }
      if(length(t)!=length(h)){
        stop("Tried to build age-depth model from tiepoints in age and height, but number of age points does not match number of height points")
      }
      tsort=sort(-a,decreasing = FALSE,index.return=TRUE)
      t=tsort$x
      h=h[tsort$ix]
      mode="age depth model"
      xdep=t
      ydep=h
      report="Age-depth-model generated from tie points in age and stratigraphic height."
      
    } else if(any(ageInput) & any(depthInput)){
      TMode="age"
      LMode="depth"
      t=-unname(unlist(iList[ageInput]))
      h=-unname(unlist(iList[depthInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from tiepoints in age and depth, but found duplicated age values")
      }
      if(length(t)<2 | length(h)<2){
        stop("Tried to build age-depth model from tiepoints in age and depth, but need at least two age points and depth points")
        
      }
      if(length(t)!=length(h)){
        stop("Tried to build age-depth model from tiepoints in age and depth, but number of age points does not match number of depth points")
      }
      tsort=sort(t,decreasing = FALSE,index.return=TRUE)
      t=tsort$x
      h=h[tsort$ix]
      mode="age depth model"
      xdep=t
      ydep=h
      report="Age-depth-model generated from tie points in age and depth."
      
    } else if(any(sRateInput) & any(timeInput)){
      TMode="time"
      LMode="height"
      t=unname(unlist(iList[timeInput]))
      s=unname(unlist(iList[sRateInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from sedimentation rate, but found duplicated time values")
      }
      if(length(t)<2 ){
        stop("Tried to build age-depth model from sedimentation rate in time, but need at least two time points ")
      }
      if(length(t)==length(s)){
        tsort=sort(t,decreasing = FALSE,index.return=TRUE)
        t=tsort$x
        s=s[tsort$ix]
        xdep=t
        ydep=s
        mode="piecewise linear sedimentation in time"
        report="Age-depth-model generated from piecewise linear sedimentation rate in time"
        
      } else if (length(s)==(length(t)-1)){
        if(is.unsorted(t) & is.unsorted(rev(t))){
          stop("Tried to build age-depth model from piecewise constant sedimentation rate in time, but time points are not ordered")
        }
        if(is.unsorted(t)){
          t=rev(t)
          s=rev(s)
        }
        xdep=t
        ydep=s
        mode="piecewise constant sedimentation in time"
        report="Age-depth-model generated from piecewise constant sedimentation rate in time"
      } else {
        stop("Tried to build age-depth model from sedimentation rate, but no of sedimentation rate does not match time inputs. No of sed rate entries needs to be identical or one lower than entries of time.")
      }
      
      
    } else if(any(sRateInput) & any(ageInput)){
      TMode="age"
      LMode="height"
      
      t=-unname(unlist(iList[ageInput]))
      s=unname(unlist(iList[sRateInput]))
      if(any(duplicated(t))){
        stop("Tried to build age-depth model from sedimentation rate, but found duplicated age values")
      }
      if(length(t)<2 ){
        stop("Tried to build age-depth model from sedimentation rate with age, but need at least two age points ")
      }
      if(length(t)==length(s)){
        tsort=sort(t,decreasing = FALSE,index.return=TRUE)
        t=tsort$x
        s=s[tsort$ix]
        xdep=t
        ydep=s
        mode="piecewise linear sedimentation in time"
        report="Age-depth-model generated from piecewise linear sedimentation rate with"
        
      } else if (length(s)==(length(t)-1)){
        if(is.unsorted(t) & is.unsorted(rev(t))){
          stop("Tried to build age-depth model from piecewise constant sedimentation rate with, but age points are not ordered")
        }
        if(is.unsorted(t)){
          t=rev(t)
          s=rev(s)
        }
        xdep=t
        ydep=s
        mode="piecewise constant sedimentation in time"
        report="Age-depth-model generated from piecewise constant sedimentation rate with age"
      } else {
        stop("Tried to build age-depth model from sedimentation rate, but no of sedimentation rate does not match age inputs. No of sed rate entries needs to be identical or one lower than entries of age.")
      }
      
    } else if(any(sRateInput) & any(heightInput)){
      TMode="time"
      LMode="height"
      h=unname(unlist(iList[heightInput]))
      s=unname(unlist(iList[sRateInput]))
      if(any(duplicated(h))){
        stop("Tried to build age-depth model from sedimentation rate, but found duplicated height values")
      }
      if(length(h)<2 ){
        stop("Tried to build age-depth model from sedimentation rate in height, but need at least two height points ")
      }
      if (any(s<=0)){
        stop("tried to build age depth model from sedimentation rate in height, but sedimentation rate was negative. Use only positive sed rates")
      }
      if(length(h)==length(s)){
        hsort=sort(h,decreasing = FALSE,index.return=TRUE)
        h=hsort$x
        s=s[hsort$ix]
        xdep=h
        ydep=s
        mode=="piecewise linear sedimentation in stratigraphic height"
        report="Age-depth-model generated from piecewise linear sedimentation rate in height"
        
      } else if (length(s)==(length(h)-1)){
        if(is.unsorted(h) & is.unsorted(rev(h))){
          stop("Tried to build age-depth model from piecewise constant sedimentation rate in stratigraphic height, but heights are not ordered")
        }
        if(is.unsorted(h)){
          h=rev(h)
          s=rev(s)
        }
        xdep=h
        ydep=s
        mode="piecewise constant sedimentation in stratigraphic height"
        report="Age-depth-model generated from piecewise constant sedimentation rate in stratigraphic height"
      } else {
        stop("Tried to build age-depth model from sedimentation rate, but no of sedimentation rate points does not match height inputs. No of sed rate entries needs to be identical or one lower than entries of stratigraphic height.")
      }
      
    } else if(any(sRateInput) & any(depthInput)){
      TMode="time"
      LMode="depth"
      h=-unname(unlist(iList[depthInput]))
      s=unname(unlist(iList[sRateInput]))
      if(any(duplicated(h))){
        stop("Tried to build age-depth model from sedimentation rate, but found duplicated depth values")
      }
      if(length(h)<2 ){
        stop("Tried to build age-depth model from sedimentation rate with depth, but need at least two depth points ")
      }
      if (any(s<=0)){
        stop("tried to build age depth model from sedimentation rate in depth, but sedimentation rate was negative. Use only positive sed rates")
      }
      if(length(h)==length(s)){
        hsort=sort(h,decreasing = FALSE,index.return=TRUE)
        h=hsort$x
        s=s[hsort$ix]
        xdep=h
        ydep=s
        mode=="piecewise linear sedimentation in stratigraphic height"
        report="Age-depth-model generated from piecewise linear sedimentation rate in depth"
        
      } else if (length(s)==(length(h)-1)){
        if(is.unsorted(h) & is.unsorted(rev(h))){
          stop("Tried to build age-depth model from piecewise constant sedimentation rate in depth, but depths are not ordered")
        }
        if(is.unsorted(h)){
          h=rev(h)
          s=rev(s)
        }
        xdep=h
        ydep=s
        mode="piecewise constant sedimentation in depth"
        report="Age-depth-model generated from piecewise constant sedimentation rate in depth"
      } else {
        stop("Tried to build age-depth model from sedimentation rate, but no of sedimentation rate points does not match depth inputs. No of sed rate entries needs to be identical or one lower than entries for depths.")
      }
      
    } else if(any(condInput) & any(heightInput)){
      TMode="time"
      LMode="height"
      h=unname(unlist(iList[heightInput]))
      c=unname(unlist(iList[condInput]))
      if(any(duplicated(h))){
        stop("Tried to build age-depth model from condensation, but found duplicated height values")
      }
      if(length(h)<2 ){
        stop("Tried to build age-depth model from condensation, but need at least two height points ")
      }
      if (any(c<=0)){
        stop("tried to build age depth model from condensation, but condensation was negative. Use only strictly positive condensation values")
      }
      if(length(h)==length(c)){
        hsort=sort(h,decreasing = FALSE,index.return=TRUE)
        h=hsort$x
        c=c[hsort$ix]
        xdep=h
        ydep=c
        mode="piecewise linear condensation in stratigraphic height"
        report="Age-depth-model generated from piecewise linear condensation in height"
        
      } else if (length(c)==(length(h)-1)){
        if(is.unsorted(h) & is.unsorted(rev(h))){
          stop("Tried to build age-depth model from piecewise constant condensation in stratigraphic height, but heights are not ordered")
        }
        if(is.unsorted(h)){
          h=rev(h)
          c=rev(c)
        }
        xdep=h
        ydep=c
        mode="piecewise constant condensation in stratigraphic height"
        report="Age-depth-model generated from piecewise constant condensation in stratigraphic height"
      } else {
        stop("Tried to build age-depth model from condensation, but no of condensation points does not match height inputs. No of condensation entries needs to be identical or one lower than entries of stratigraphic height.")
      }
      
    } else if(any(condInput) & any(depthInput)){
      TMode="time"
      LMode="depth"
      h=-unname(unlist(iList[depthInput]))
      c=unname(unlist(iList[condInput]))
      if(any(duplicated(h))){
        stop("Tried to build age-depth model from condensation, but found duplicated depth values")
      }
      if(length(h)<2 ){
        stop("Tried to build age-depth model from condensation, but need at least two depth points ")
      }
      if (any(c<=0)){
        stop("tried to build age depth model from condensation, but condensation was negative. Use only strictly positive condensation values")
      }
      if(length(h)==length(c)){
        hsort=sort(h,decreasing = FALSE,index.return=TRUE)
        h=hsort$x
        c=c[hsort$ix]
        xdep=h
        ydep=c
        mode="piecewise linear condensation in stratigraphic height"
        report="Age-depth-model generated from piecewise linear condensation in depth"
        
      } else if (length(c)==(length(h)-1)){
        if(is.unsorted(h) & is.unsorted(rev(h))){
          stop("Tried to build age-depth model from piecewise constant condensation in depth, but depths are not ordered")
        }
        if(is.unsorted(h)){
          h=rev(h)
          c=rev(c)
        }
        xdep=h
        ydep=c
        mode="piecewise constant condensation in stratigraphic height"
        report="Age-depth-model generated from piecewise constant condensation in depth"
      } else {
        stop("Tried to build age-depth model from condensation, but no of condensation points does not match depth inputs. No of condensation entries needs to be identical or one lower than entries of depths.")
      }
      
      
    }  else{
      stop("variable names for ... not recognoized")
    }
  }
  
  #### 4 Generate Tie Points ####
  if(mode=="age depth model"){
    t=xdep
    h=ydep
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseLinear",
             interpolationInfo=NULL,
             TMode=TMode,
             LMode=LMode)
  }

  
  if(mode=="piecewise constant condensation in stratigraphic height"){
    h=xdep
    timePerInterval=diff(xdep)*ydep
    t=cumsum(c(0,timePerInterval))
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseLinear",
             interpolationInfo=NULL)
  }
  if(mode=="piecewise linear condensation in stratigraphic height"){
    stop("not implemented yet")
  }
  if(mode=="piecewise constant sedimentation in stratigraphic height"){
    h=xdep
    timePerInterval=diff(xdep)*(ydep^-1)
    t=cumsum(c(0,timePerInterval))
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseLinear",
             interpolationInfo=NULL)
  }
  
  if(mode=="piecewise linear sedimentation in stratigraphic height"){
    h=xdep
    accTime=rep(0,length(xdep)-1)
    for (i in 1:length(xdep)){
      if(ydep[i]==ydep[i=1]){
        accTime[i]=(xdep[i+1]-xdep[i])/ydep[i]
      } else  {
        a=(ydep[i+1]-ydep[i])/(xdep[i+1]-xdep[i])
        b=ydep[i]-a*xdep[i]
        accTime[i]=(a^-1)*log((a*xdep[i+1]+b)/(a*xdep[i]+b))
      }
    }
    t=cumsum(c(0,accTime))
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseLog",
             interpolationInfo=ydep)
  }
  if(mode=="piecewise linear sedimentation in stratigraphic height"){
    h=xdep
    timePerInterval=0.5*diff(xdep)*(ydep[1:(length(ydep)-1)]+ydep[2:length(ydep)])
    accumulatedTime=cumsum(c(0,timePerIncrement))
    ADM=list(t=accumulatedTime,
             h=h,
             interpolationMode="piecewiseRoot",
             interpolationInfo=ydep)
  }
  

  
  if(mode=="piecewise constant sedimentation in time"){
    t=xdep
    heightPerInterval=diff(xdep)*ydep
    h=cumsum(c(0,heightPerInterval))
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseLinear",
             interpolationInfo=NULL)
  }
  
  if(mode=="piecewise linear sedimentation in time"){
    i=1
    while(i<length(xdep)){
      if((ydep[i]<0&ydep[i+1]>0)|(ydep[i]>0&ydep[i+1]<0)){
        tnew=xdep[i]-ydep[i]*((xdep[i+1]-xdep[i])/(ydep[i+1]-ydep[i]))
        xdep=c(xdep[1:i],tnew,xdep[(i+1):length(xdep)])
        ydep=c(ydep[1:i],0,ydep[(i+1):length(ydep)])
      }
      i=i+1
    }
    t=xdep
    heightPerInterval=diff(xdep)*0.5*(ydep[1:(length(ydep)-1)]+ydep[2:(length(ydep))])
    h=cumsum(c(0,heightPerInterval))
    ADM=list(t=t,
             h=h,
             interpolationMode="piecewiseCubic",
             interpolationInfo=ydep)
  }
  
  #### Insert Hiatus Breakpoints ####
  if(length(ADM$h)>2 & any(diff(ADM$h)<0)){
      print("insert hiatus breakpoints!")
      i=length(ADM$h)
      while(i>1){ # i = tie point no
        sedRemovalBeforei=ADM$h[i-1]>ADM$h[i]
        sedStagOrAccAfteri=ADM$h[i]<=ADM$h[min(c(i+1,length(ADM$h)))]
        isSedDecEnd=sedRemovalBeforei & sedStagOrAccAfteri # is a transition from sed decrease to stagnation or accumulation
        if(isSedDecEnd){
          hSedDecEnd=ADM$h[i]
          print(hSedDecEnd)
          print(i)
          upCrossing=(ADM$h[1:(i-2)]<hSedDecEnd)&(ADM$h[2:(i-1)]>hSedDecEnd)
          hasTrueTransition=any(upCrossing) # is there an interval where the value of h is truly intersected?
          if(hasTrueTransition){
            transitionInterval=max(which(upCrossing))
            print(transitionInterval)
            hitsTiePoint=(ADM$h[1:(i-2)]==hSedDecEnd)|(ADM$h[2:(i-1)]==hSedDecEnd)
            print(hitsTiePoint)
            print(ADM)
            if(any(hitsTiePoint)){
                print(which(hitsTiePoint))
                determineUpcrossingTime=max(which(hitsTiePoint))<transitionInterval
            } else {
              determineUpcrossingTime=TRUE
            }
            if(determineUpcrossingTime){
              # interpolate A(?)=ADM$h[i]
              if(ADM$interpolationMode=="piecewiseLinear"){
                tIntersect=(hSedDecEnd-ADM$h[transitionInterval])*((ADM$t[transitionInterval+1]-ADM$t[transitionInterval])/(ADM$h[transitionInterval+1]-ADM$h[transitionInterval]))+ADM$t[transitionInterval]
                # insert values in ADM
                ADM$h=c(ADM$h[1:(transitionInterval)],hSedDecEnd,ADM$h[(transitionInterval+1):length(ADM$h)])
                ADM$t=c(ADM$t[1:(transitionInterval)],tIntersect,ADM$t[(transitionInterval+1):length(ADM$t)])
                
              } else if(ADM$interpolationMode=="piecewiseCubic"){
                stop("piecewise cubic not implemented yet")
              } else if(ADM$interpolationMode=="piecewiseRoot"){
                stop("piecewise root not implemented yet")
              } else if(ADM$interpolationMode=="piecewiseExp"){
                stop("piecewise exponential not implemented yet")
              } else {
                stop("wrong mode")
              }
             
            } else {
              i=i-1
            }
          } else {
            i=i-1
          }
        } else {
          i=i-1
        }  #
      }
  }

  #### Determine destructive intervals ####
  ADM$destructive=IDDestrInt(ADM$h,omission = omission)
  
  if(silent==FALSE){
    message(report)
  }
  return(ADM)
}

IDDestrInt=function(hTemp,omission="destructive"){
  # determines which intervals are destructive
  n=length(hTemp)
  totalAccHeight=hTemp[n]-hTemp[1] #net sediment budget (total thickness of accumulated sediment)
  
  if(totalAccHeight>0){
  # 1. if net sed. budget is strictly positive, but there is some omission and erosion
    diffInHeight=sapply(1:n,function(i) hTemp[i]>min(hTemp[i:n]))
    hasDiffInHeight=diffInHeight[1:(n-1)]|diffInHeight[2:n]
    if(omission=="conservative"){
      isDestructive=hasDiffInHeight
      return(isDestructive)
    } else if(omission=="destructive"){
      isDestructive=hasDiffInHeight | (diff(hTemp)==0)
      return(isDestructive)
    }
  } else if(totalAccHeight<0 ){
    # 2. if net sed budget is truly negative: everything is destroyed
    isDestructive=rep(TRUE,n-1)
    return(isDestructive)
  } else if(totalAccHeight==0 & omission=="destructive") {
    # 3. if net sed budget is zero and omission is destructive: everything is destroyed
    isDestructive=rep(TRUE,n-1)
    return(isDestructive)
  } else if(totalAccHeight==0 & omission=="conservative"){
    # 4. if net sed budget is zero, and omission is conswrvative\
    # only omission surfaces that are at initial (and final) strat height not destructive
    isDestructive=(hTemp[1:(n-1)]!=hTemp[1]) | (hTemp[2:n]!=hTemp[1])
    return(isDestructive)
  }
  stop("something went wrong")
}

# IDDestrInt(c(1,1,2,1))
# IDDestrInt(c(1,1,2,1),"conservative")

ADM=as.ADM(t=1:3,h=1:3,omission="destructive",silent=FALSE)
plot(ADM$t,ADM$h)
ADM

ADM=genADM(1:4,c(1,1,2,1),mode="age depth model",omission = "conservative")
plot(ADM$t,ADM$h)
ADM

ADM=genADM(1:5,c(1,1,2,1.5,3),mode="age depth model",omission = "conservative")
plot(ADM$t,ADM$h)
ADM


ADM=genADM(1:7,c(1,1,2,1.5,3,2,2),mode="age depth model",omission = "conservative")
plot(ADM$t,ADM$h)
ADM

ADM=genADM(xdep=1:6,ydep=c(1.5,1,1,2,1.5,3),mode="age depth model")
plot(ADM$t,ADM$h)
ADM


plotadm=function(ADM){
  plot(NULL,xlim=range(ADM$t),ylim=range(ADM$h),type="l")
  for (i in 1:length(ADM$destructive)){
    if(ADM$destructive[i]){
      rect(xleft = ADM$t[i],xright = ADM$t[i+1],ybottom = min(ADM$h),ytop = max(ADM$h),border = NA,col=grey(0.5))
    }
  }
  lines(ADM$t,ADM$h)
}
plotadm(ADM = ADM)

