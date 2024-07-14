time_to_strat.phylo = function(obj, x, ...){
  
  #' 
  #' @export
  #' @import ape
  #' 
  #' @title transfrom phylo object
  #' 
  #' @description
  #' transfrom phylo object from the time domain to the stratigraphic domain
  #' 
  #' 
  #' @param obj the phylo object to be transformed
  #' @param x age-depth model
  #' @param ... other parameters, currently ignored
  #' 
  #' @returns a phylo object, representation of the tree in the strat domain
  #' 
  #' @seealso [get_height()] for the underlying procedure, [time_to_strat()] for the higher level function, and [strat_to_time.phylo()] for the transformantion of phylo objects from strat domain to the time domain. See [time_to_strat.list()] and [time_to_strat.numeric()] for the transformation of lists and numeric vectors 
  
  tree = obj
  adm = x
  
  times = get_all_node_vals(tree)
  
  height = get_height(adm, times, destructive = FALSE, out_dom_val_h = "strat_limits")
  
  new_tree = update_branch_lengths(tree,height)
  
  return(new_tree)
  
}



find_precursor_node=function(x, node){
  
  #'
  #' @title find precursor noode of node in phylo object
  #' 
  #' @param x a phylo object
  #' @param node the node for which the precursor is supposed to be determined
  #' 
  #' @returns integer, id of precursor node
  #' 
  #' @noRd
  #' @keywords internal
  #' 
  
  precursor_node=x$edge[,1][x$edge[,2]==node]
  return(precursor_node)
}

#### find root ####
find_root_node = function(x, start_node_id=1){
  
  #'
  #' @title find index of root node in phylo object
  #' 
  #' @param x phylo object
  #' @param start_node integer, node where to start search
  #' 
  #' @returns integer, index of root node
  #' 
  #' @noRd
  #' @keywords internal
  #' 
  current_node = start_node_id
  repeat{
    precursor_node=find_precursor_node(x, current_node)
    if(length(precursor_node)==0) break
    current_node=precursor_node
  }
  return(current_node)
}


get_node_vals=function(x, node){
  
  #'
  #' @title get absolute times/pos of nodes
  #' 
  #' @param x phylo object
  #' @param node integer, index of node
  #' 
  #' @returns numeric, absolute location in time/height of node
  #' 
  #' @noRd
  #' @keywords internal
  #' 
  
  root=find_root_node(x)
  
  if(node==root){
    if ("root.time" %in% names(x)){
      return(x$root.time)
    } else {
      return(0)
    }
  } else {
    precursor_node=find_precursor_node(x,node)
    edge_length=x$edge.length[x$edge[,2]==node]
    node_val=get_node_vals(x,precursor_node)+ edge_length
    return(node_val)
  }
}

#### get all node ages ####

get_all_node_vals=function(x){
  
  #' 
  #' @title get time/strat vals of all nodes
  #' 
  #' @param x a phylo object
  #' 
  #' @returns vector with one entry per node, timing/strat for nodes
  #' 
  #' @noRd
  #' @keywords internal
  
  noofnodes=length(x$tip.label)+x$Nnode
  vals=rep(0,noofnodes)
  
  for (i in seq_len(noofnodes)){
    vals[i]=get_node_vals(x,i)
  }
  return(vals)
}

#### update branch lengths ####
update_branch_lengths=function(x,node_vals, root_val = 0){
  
  #'
  #' @title updates branch lengths
  #' 
  #' @param x a phylo object
  #' @param node_vals values of the node
  #' @param roow_val position of root 
  #' 
  #' @returns a phylo object
  #' 
  #' @noRd
  #' @keywords internal
  #' 
  for (i in 1:length(x$edge.length)){
    start=x$edge[i,1]
    end=x$edge[i,2]
    x$edge.length[i]=node_vals[end]-node_vals[start]
  }
  x[["root.time"]] = root_val
  return(x)
}

