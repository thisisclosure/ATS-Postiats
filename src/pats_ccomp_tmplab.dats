(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

assume
tmplab_type = '{
  tmplab_stamp = stamp
} // end of [tmplab]

in // in of [local]

implement
tmplab_make () = '{
  tmplab_stamp= $STMP.tmplab_stamp_make ()
} // end of [tmplab_make]

implement
tmplab_get_stamp (tl) = tl.tmplab_stamp

implement
fprint_tmplab
  (out, tl) =
{
  val (
  ) = fprint_string (out, "tmplab(")
  val (
  ) = $STMP.fprint_stamp (out, tl.tmplab_stamp)
  val () = fprint_string (out, ")")
} // end of [fprint_tmplab]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_tmplab.dats] *)
