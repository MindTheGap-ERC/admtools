strat_to_time.phylo = function(obj, x, ...){
  
  #' 
  #' @export
  #' 
  #' @title transform phylo object
  #' 
  #' @description
    #' transform phylo object from the stratigraphic domain to the time domain
    #' 
  #' 
  #' @param obj the phylo object to be transformed
  #' @param x age-depth model
  #' @param ... parameters passed to get_time
  #' 
  #' @returns a phylo object, representation of the tree in the time domain
  #' 
  #' @seealso [get_time()] for the underlying procedure, [strat_to_time()] for the higher level function, and [time_to_strat.phylo()] for the transformation of phylo objects from the time to the strat domain.
  
  tree = obj
  adm = x
  
  heights = get_all_node_vals(tree)
  
  times = get_time(adm, heights, hiat_mode = "start", out_dom_val_t = "time_limits", bdry_pts_hiat = "consistent")
  
  new_tree = update_branch_lengths(tree, times)
  
  return(new_tree)
}