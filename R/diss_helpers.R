mean_abs_linear = function(e0, e1){
  # mean of |e| over a segment on which e is linear, from e0 to e1. Exact,
  # including sign changes within the segment. Not exported.
  res = (abs(e0) + abs(e1)) / 2
  flip = e0 * e1 < 0
  res[flip] = (e0[flip]^2 + e1[flip]^2) / (2 * (abs(e0[flip]) + abs(e1[flip])))
  return(res)
}
