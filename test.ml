
let () =
  let a, b = Parpair.mapf 2 (fun x -> 2 * x) 1 2 in
  let c, d = Parpair.mapf 1 (fun x -> 2 * x) 1 2 in
  assert(a = 2 && b = 4);
  assert(c = 2 && d = 4);
  let e, f = Parpair.mapfg 2 (fun x -> 2 * x) (fun y -> 3 * y) 1 2 in
  let g, h = Parpair.mapfg 1 (fun x -> 2 * x) (fun y -> 3 * y) 1 2 in
  assert(e = 2 && f = 6);
  assert(g = 2 && h = 6)
