(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "my_dynload"
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include
  "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)

#define
NDX_fname "./DATA/NDX-2018-06-23.csv"

(* ****** ****** *)

val
NDX_dframe =
$extfcall
( R34dframe(double)
, "read.csv"
, NDX_fname, $extval(optarg,"header=TRUE")
)

(* ****** ****** *)
//
val
NDX_dframe_names = names(NDX_dframe)
//
val () =
$extfcall(void, "message", NDX_dframe_names)
//
(* ****** ****** *)
//
val () = println!
("|NDX_dframe_names| = ", length(NDX_dframe_names))
//
(* ****** ****** *)

(*
val () =
assertloc(length(NDX_dframe_names) >= 7)
val () =
println!("NDX_dframe_names[1] = ", NDX_dframe_names[1])
val () =
println!("NDX_dframe_names[2] = ", NDX_dframe_names[2])
val () =
println!("NDX_dframe_names[3] = ", NDX_dframe_names[3])
val () =
println!("NDX_dframe_names[4] = ", NDX_dframe_names[4])
val () =
println!("NDX_dframe_names[5] = ", NDX_dframe_names[5])
val () =
println!("NDX_dframe_names[6] = ", NDX_dframe_names[6])
val () =
println!("NDX_dframe_names[7] = ", NDX_dframe_names[7])
val () = // HX: this one is out-of-bounds
println!("NDX_dframe_names[8] = ", NDX_dframe_names[8])
*)

(* ****** ****** *)
//
val
Adj_Close_pos =
match("Adj.Close", NDX_dframe_names)
val ((*void*)) =
println! ("Adj_Close_pos = ", Adj_Close_pos)
val ((*void*)) = assertloc(Adj_Close_pos > 0)
//
(* ****** ****** *)
//
val
Adj_Close_data =
getcol_by(NDX_dframe, "Adj.Close")
//
(*
val
Adj_Close_data =
getcol_at(NDX_dframe, Adj_Close_pos)
*)
//
val () = println!
("|Adj_Close_data| = ", length(Adj_Close_data))
//
(* ****** ****** *)
//
val n0 =
  length(Adj_Close_data)
//
val () = assertloc(n0 >= 2)
//
(* ****** ****** *)
//
val
Daily_price_changes =
(
R34vector_tabulate_cloref{double}
( n0-1
, lam(i) =>
  fopr(Adj_Close_data[i+1], Adj_Close_data[i+2]))
) where
{
  fn fopr(x: double, y: double): double = (y/x-1.0)
}
//
(* ****** ****** *)
//
val
volat =
sqrt(252*variance(Daily_price_changes))
//
val ((*void*)) =
$extfcall(void, "message", "Volatility = ", volat)
//
(* ****** ****** *)

%{^
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
my_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [cs320-2017-fall-assign04.dats] *)
