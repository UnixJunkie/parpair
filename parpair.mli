
(** [mapf ncores f x y = (f x, f y)]. If [ncores] > 1,
    then [f x] is executed by a child process whose
    result is marshalled back to the parent process.
    If [ncores] <= 1, parallelization is disabled. *)
val mapf: int -> ('a -> 'b) -> 'a -> 'a -> 'b * 'b

(** [mapfg ncores f g x y = (f x, g y)]. If [ncores] > 1,
    then [f x] is executed by a child process whose
    result is marshalled back to the parent process.
    If [ncores] <= 1, parallelization is disabled. *)
val mapfg: int -> ('a -> 'b) -> ('c -> 'd) -> 'a -> 'c -> 'b * 'd
