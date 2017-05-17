(* ****** ****** *)
(*
** For implementing a DSL
** that supports ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
abstype label_type
typedef label = label_type
//
(* ****** ****** *)
//
fun
label_make
  (x: string): label
//
(* ****** ****** *)
//
fun
fprint_label
  : fprint_type(label)
//
overload
fprint with fprint_label
//
(* ****** ****** *)
//
fun
eq_label_label(label, label): bool
fun
neq_label_label(label, label): bool
//
fun
compare_label_label
  (l1: label, l2: label): int(*sgn*)
//
overload = with eq_label_label
overload != with neq_label_label
overload compare with compare_label_label
//
(* ****** ****** *)

abstype scadenv_type
typedef scadenv = scadenv_type

(* ****** ****** *)

datatype
scadexp =
//
| SCADEXPnil of ()
//
| SCADEXPint of (int)
| SCADEXPbool of (bool)
| SCADEXPfloat of (double)
//
| SCADEXPvec of scadexplst
//
| SCADEXPextfcall of
    (string(*fun*), scadenv, scadarglst)
  // SCADEXPextfcall
//
(* end of [scadexp] *)

and scadarg =
//
| SCADARGexp of scadexp
| SCADARGlabexp of (label, scadexp)
//
where
scadexplst = List0(scadexp)
and
scadarglst = List0(scadarg)

(* ****** ****** *)
(*
//
datatype
scadvec(n:int) =
{n:int}
SCADVEC of list(scadexp, n)
//
typedef scadv2d = scadvec(2)
typedef scadv3d = scadvec(3)
typedef scadvec0 = [n:int | n >= 0] scadvec(n)
//
macdef
SCADV2D(x, y) =
SCADVEC($list{scadexp}(,(x), ,(y)))
macdef
SCADV3D(x, y, z) =
SCADVEC($list{scadexp}(,(x), ,(y), ,(z)))
//
*)
(* ****** ****** *)
//
datatype
scadobj =
//
| SCADOBJfopr of
  (string(*fopr*), scadenv, scadarglst)
//
| SCADOBJmopr of (string(*mopr*), scadobjlst)
//
| SCADOBJtfmapp of (scadtfm, scadobjlst)
//
// end of [scadobj]

and
scadtfm =
//
| SCADTFMident of ()
//
| SCADTFMcompose of (scadtfm, scadtfm)
//
| SCADTFMextmcall of
    (string(*module*), scadenv, scadarglst)
  // SCADTFMextmcall
//
where scadobjlst = List0(scadobj)
//
(* ****** ****** *)
//
fun
fprint_scadenv : fprint_type(scadenv)
//
fun
fprint_scadexp : fprint_type(scadexp)
fun
fprint_scadarg : fprint_type(scadarg)
//
(* ****** ****** *)

overload fprint with fprint_scadenv
overload fprint with fprint_scadexp
overload fprint with fprint_scadarg

(* ****** ****** *)
//
fun
scadenv_search
  (env: scadenv, k: label): Option_vt(scadexp)
fun
scadenv_insert_any
  (env: scadenv, k: label, x: scadexp): scadenv
//
(* ****** ****** *)
//
fun
scadexp_femit(FILEref, scadexp): void
fun
scadexplst_femit(FILEref, scadexplst): void
//
(* ****** ****** *)
//
fun
scadarg_femit(FILEref, scadarg): void
fun
scadarglst_femit(FILEref, scadarglst): void
fun
scadarglst_env_femit(FILEref, scadarglst, scadenv): void
//
(* ****** ****** *)

(* end of [OpenSCAD.sats] *)
