(*
//
// [patsopt] for typechecking
//
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
#define
ATS_EXTERN_PREFIX "atslangweb_"
#define
ATS_STATIC_PREFIX "_atslangweb_patsopt_tcats_"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
#staload
"{$LIBATSCC2JS}/SATS/HTTP/Ajax/Ajax.sats"
//
(* ****** ****** *)

#staload "./../SATS/atslangweb.sats"

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_tcats_rpc
  (mycode) = let
//
val
xmlhttp =
XMLHttpRequest_new()
val ((*void*)) =
xmlhttp.onreadystatechange
(
lam((*void*)) =>
(
if (
xmlhttp.is_ready_okay()
) then (
  patsopt_tcats_rpc$reply<> (xmlhttp.responseText())
) (* then *)
// end of [if]
) (* end of [lam] *)
)
//
val command = patsopt_tcats_rpc$cname()
//
val ((*void*)) =
  xmlhttp.open("POST", command, true(*async*))
val ((*void*)) =
  xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
val ((*void*)) =
  xmlhttp.send("mycode=" + encodeURIComponent(mycode))
//
in
  // nothing
end // end of [patsopt_tcats_rpc]

(* ****** ****** *)

(* end of [patsopt_tcats.dats] *)
