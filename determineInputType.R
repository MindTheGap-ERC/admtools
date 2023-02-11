determineInputType=function(...){
  iList=list(...)
  # need numeric inputs
  if(!all(sapply(iList, function(x) is.numeric(x)))){
    stop("need numeric inputs")
  }
  # need two inputs
  if(length(iList)!=2){
    stop("expecting two input variables for ...")
  }
  # remove capitalization
  iNames=tolower(names(iList))
  
  sRateInput=iNames %in% c("s","sed","srate","sedrate","sedimentation","sedimentationrate","sedimentation_rate","sedimentation rate")
  condInput=iNames %in% c("c","cond","condensation")
  timeInput=iNames %in% c("t","time")
  ageInput=iNames %in% c("a","age")
  heightInput=iNames %in% c("h","height","strat","strat height","stratheight","strat_height")
  depthInput=iNames %in% c("d","depth")
  
  duplInputs=sapply(list(sRateInput,condInput,timeInput,ageInput,heightInput,depthInput), function(x) sum(x)==2)
  if(any(duplInputs)){
    stop("input types duplicatd")
  }
  
  if(any(sRateInput) & any(timeInput)){
    TMode="time"
    LMode="height"
    
  } else if(any(sRateInput) & any(ageInput)){
    TMode="age"
    LMode="height"
    
  } else if(any(sRateInput) & any(heightInput)){
    TMode="time"
    LMode="height"
    
  } else if(any(sRateInput) & any(depthInput)){
    TMode="time"
    LMode="depth"
    
  } else if(any(condInput) & any(heightInput)){
    TMode="time"
    LMode="height"
    
  } else if(any(condInput) & any(depthInput)){
    TMode="time"
    LMode="depth"
    
  } else if(any(timeInput) & any(heightInput)){
    TMode="time"
    LMode="height"
    
  } else if(any(timeInput) & any(depthInput)){
    TMode="time"
    LMode="depth"
    
  } else if(any(ageInput) & any(heightInput)){
    TMode="age"
    LMode="height"
    
  } else if(any(ageInput) & any(depthInput)){
    TMode="age"
    LMode="depth"
    
  } else{
    stop("input variable names not recognoized")
  }
  
  return(c(TMode,LMode))
  
  #valid pairs: srateInput & timeInput |ageInput |heightInput |depthInput
  #valid pairs: condInput & heightInput |depthInput
  #valid pairs:  timeInput & heightInput |depthInput
  #valid pairs:  ageInput & heightInput |depthInput
}

determineInputType(h=0,age=2)
