strat_to_time.phylo = function(obj, x, ...){
  
  #' 
  #' @export
  #' 
  
  tree = obj
  adm = x
  
  heights = get_all_node_vals(tree)
  
  times = get_time(adm, heights, hiat_mode = "start", out_dom_val_t = "time_limits", bdry_pts_hiat = "consistent")
  
  new_tree = update_branch_lengths(tree, times)
  
  return(new_tree)
}