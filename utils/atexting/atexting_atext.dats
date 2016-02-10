(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)
//
implement
atext_make
(
  loc, node
) = $rec{
  atext_loc= loc, atext_node= node
} (* $rec *)
//
(* ****** ****** *)
//
implement
atext_make_token(tok) =
  atext_make(tok.token_loc, TEXTtoken(tok))
//
(* ****** ****** *)
//
extern
fun{}
fprint_atext_node_
  : (FILEref, atext_node) -> void
//
(* ****** ****** *)

#ifdef
CODEGEN2
#then
#codegen2
( "fprint"
, atext_node, fprint_atext_node_
)
#else
//
#include
"./atexting_atext_fprint.hats"
//
implement
fprint_val<token> = fprint_token
implement
fprint_val<atext> = fprint_atext
implement
fprint_val<atextlst> = fprint_atextlst
//
implement
fprint_atext(out, x0) =
  fprint_atext_node_<>(out, x0.atext_node)
//
implement
fprint_atextlst
  (out, xs) =
  fprint_list_sep<atext>(out, $UN.cast{List0(atext)}(xs), ", ")
//
#endif // #ifdef

(* ****** ****** *)

(* end of [atexting_atext.dats] *)
