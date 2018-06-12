
(* fork with an already setup pipe *)
let fork_out to_ignore to_write f =
  match Unix.fork () with
  | 0 -> (* child *)
    begin
      Unix.close to_ignore;
      let out_chan = Unix.out_channel_of_descr to_write in
      let res = f () in
      Marshal.(to_channel out_chan res [No_sharing]);
      close_out out_chan;
      exit 0
    end
  | -1 -> failwith "Parpair: fork_out: fork failed"
  | pid -> pid (* father *)

(* like parmap, but probably lighter and for only two elements *)
let mapf ncores f x y =
  if ncores <= 1 then
    (f x, f y)
  else
    let to_read, to_ignore = Unix.pipe () in
    let _pid = fork_out to_read to_ignore (fun () -> f x) in
    Unix.close to_ignore;
    let in_chan = Unix.in_channel_of_descr to_read in
    let y' = f y in
    let x' = Marshal.from_channel in_chan in
    close_in in_chan;
    (x', y')

(* like parmap, but probably lighter and for only two elements *)
let mapfg ncores f g x y =
  if ncores <= 1 then
    (f x, g y)
  else
    let to_read, to_ignore = Unix.pipe () in
    let _pid = fork_out to_read to_ignore (fun () -> f x) in
    Unix.close to_ignore;
    let in_chan = Unix.in_channel_of_descr to_read in
    let y' = g y in
    let x' = Marshal.from_channel in_chan in
    close_in in_chan;
    (x', y')
