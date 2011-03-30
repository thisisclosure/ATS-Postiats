(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
overload + with $LOC.location_combine
staload SYM = "pats_symbol.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
staload FIX = "pats_fixity.sats"
staload FIL = "pats_filename.sats"

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

#define sz2i int_of_size
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

implement
synent_null {a} () = $UN.cast{a} (null)
implement
synent_is_null (x) = ptr_is_null ($UN.cast{ptr} (x))
implement
synent_isnot_null (x) = ptr_isnot_null ($UN.cast{ptr} (x))

(* ****** ****** *)

implement
dcstkind_is_fun (x) =
  case+ x of DCKfun () => true | _ => false
// end of [dcstkind_is_fun]

implement
dcstkind_is_val (x) =
  case+ x of DCKval () => true | _ => false
// end of [dcstkind_is_val]

implement
dcstkind_is_prfun (x) =
  case+ x of DCKprfun () => true | _ => false
// end of [dcstkind_is_prfun]

implement
dcstkind_is_prval (x) =
  case+ x of DCKprval () => true | _ => false
// end of [dcstkind_is_prval]

implement
dcstkind_is_castfn (x) =
  case+ x of DCKcastfn () => true | _ => false
// end of [dcstkind_is_castfn]

implement
fprint_dcstkind
  (out, dck) = case+ dck of
  | DCKfun () => fprint_string (out, "DCKfun")
  | DCKval () => fprint_string (out, "DCKval")
  | DCKpraxi () => fprint_string (out, "DCKpraxi")
  | DCKprfun () => fprint_string (out, "DCKprfun")
  | DCKprval () => fprint_string (out, "DCKprval")
  | DCKcastfn () => fprint_string (out, "DCKcastfn")
// end of [fprint_dcstkind]

implement
print_dcstkind (x) = fprint_dcstkind (stdout_ref, x)

(* ****** ****** *)

implement
i0de_make_sym
  (loc, sym) = '{
  i0de_loc= loc, i0de_sym= sym
} // end of [i0de_make_sym]

implement
i0de_make_string
  (loc, name) = let
  val sym = $SYM.symbol_make_string (name)
in '{
  i0de_loc= loc, i0de_sym= sym
} end // end of [i0de_make_string]

(* ****** ****** *)

implement
s0rtq_none (loc) = '{
  s0rtq_loc= loc, s0rtq_node= S0RTQnone ()
} // end of [s0rtq_none]

implement
s0rtq_symdot (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0rtq_loc= loc, s0rtq_node= S0RTQsymdot (ent1.i0de_sym)
} end // end of [s0rtq_symdot]

(* ****** ****** *)

implement
s0taq_none (loc) = '{
  s0taq_loc= loc, s0taq_node= S0TAQnone ()
} // end of [s0taq_none]

implement
s0taq_symdot (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0taq_loc= loc, s0taq_node= S0TAQsymdot (ent1.i0de_sym)
} end // end of [s0taq_symdot]

implement
s0taq_symcolon (ent1, tok2) = let
  val loc = ent1.i0de_loc + tok2.token_loc
in '{
  s0taq_loc= loc, s0taq_node= S0TAQsymcolon (ent1.i0de_sym)
} end // end of [s0taq_symcolon]

(* ****** ****** *)

implement
sqi0de_make_none (ent) = let
  val loc = ent.i0de_loc
  val qua = s0taq_none (loc)
in '{
  sqi0de_loc= loc
, sqi0de_qua= qua, sqi0de_sym= ent.i0de_sym
} end // end of [sqi0de_make_node]

implement
sqi0de_make_some
  (ent1, ent2) = let
  val loc = ent1.s0taq_loc + ent2.i0de_loc
in '{
  sqi0de_loc= loc
, sqi0de_qua= ent1, sqi0de_sym= ent2.i0de_sym
} end // end of [sqi0de_make_some]

(* ****** ****** *)

implement
l0ab_make_i0de (x) = let
  val lab = $LAB.label_make_sym (x.i0de_sym)
in '{
  l0ab_loc= x.i0de_loc, l0ab_lab= lab
} end // end of [l0ab_make_i0de]

implement
l0ab_make_i0nt (x) = let
  val int = int_of_string (x.i0nt_rep)
  val lab = $LAB.label_make_int (int)
in '{
  l0ab_loc= x.i0nt_loc, l0ab_lab= lab
} end // end of [l0ab_make_i0nt]

(* ****** ****** *)
//
// HX: omitted precedence is assumed to equal 0
//
implement
p0rec_emp () = P0RECint (0)

implement
p0rec_i0de (id) = P0RECi0de (id)

implement
p0rec_i0de_adj
  (id, opr, int) = let
  val str = int.i0nt_rep
  val adj = int_of_string (str) in P0RECi0de_adj (id, opr, adj)
end // end of [p0rec_i0de_adj]

implement
p0rec_i0nt (int) = let
  val str = int.i0nt_rep
  val pval = int_of_string (str) in P0RECint (pval)
end // end of [p0rec_i0nt]

(* ****** ****** *)

implement
e0xp_app (e1, e2) = let
  val loc = e1.e0xp_loc + e2.e0xp_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPapp (e1, e2)
} end // end of [e0xp_app]

implement
e0xp_char (tok) = let
  val- T_CHAR (c) = tok.token_node
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPchar (c)
} end // end of [e0xp_char]

implement
e0xp_eval (
  t_beg, e, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPeval e
} end // end of [e0xp_eval]

implement
e0xp_float (tok) = let
  val- T_FLOAT_deciexp (f) = tok.token_node
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPfloat (f)
} end // end of [e0xp_float]

implement
e0xp_i0de (id) = '{
  e0xp_loc= id.i0de_loc, e0xp_node= E0XPide id.i0de_sym
} // end of [e0xp_ide]

implement
e0xp_i0nt (int) = let
in '{
  e0xp_loc= int.i0nt_loc, e0xp_node= E0XPint (int)
} end // end of [e0xp_i0nt]

implement
e0xp_list (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  e0xp_loc= loc, e0xp_node= E0XPlist xs
} end // end of [e0xp_list]

implement
e0xp_string (tok) = let
  val- T_STRING (s) = tok.token_node
  val n = string_length (s)
in '{
  e0xp_loc= tok.token_loc, e0xp_node= E0XPstring (s, (sz2i)n)
} end // end of [e0xp_float]

(* ****** ****** *)

implement
s0rt_app (x1, x2) = let
  val loc = x1.s0rt_loc + x2.s0rt_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTapp (x1, x2)
} end // end of [s0rt_app]

implement
s0rt_i0de (id) = '{
  s0rt_loc= id.i0de_loc, s0rt_node= S0RTide id.i0de_sym
} // end of [s0rt_ide]

implement
s0rt_sqid (ent1, ent2) = let
  val loc = ent1.s0rtq_loc + ent2.i0de_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTqid (ent1, ent2.i0de_sym)
} end // end of [s0rt_ide]

implement
s0rt_list (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0rt_loc= loc, s0rt_node= S0RTlist (xs)
} end // end of [s0rt_list]

implement
s0rt_type (x) = let
  val- T_TYPE (knd) = x.token_node
in '{
  s0rt_loc= x.token_loc, s0rt_node= S0RTtype (knd)
} end // end of [s0rt_i0nt]

(* ****** ****** *)

implement
d0atsrtcon_make
  (id, arg) = let
  val loc = (case+ arg of
    | Some s0t => id.i0de_loc + s0t.s0rt_loc
    | None () => id.i0de_loc
  ) : location // end of [val]
in '{
  d0atsrtcon_loc= loc
, d0atsrtcon_sym= id.i0de_sym
, d0atsrtcon_arg= arg
} end // end of [d0atsrtcon_make]

implement
d0atsrtdec_make
  (id, tok, xs) = let
  fun loop (
    id: i0de, x: d0atsrtcon, xs: d0atsrtconlst
  ) : location =
    case+ xs of
    | list_cons (x, xs) => loop (id, x, xs)
    | list_nil () => id.i0de_loc + x.d0atsrtcon_loc
  // end of [loop]
  val loc = (
    case+ xs of
    | list_cons (x, xs) => loop (id, x, xs)
    | list_nil () => id.i0de_loc + tok.token_loc
  ) : location // end of [val]
in '{
  d0atsrtdec_loc= loc
, d0atsrtdec_sym= id.i0de_sym, d0atsrtdec_con= xs
} end // end of [d0atsrtdec_make]

(* ****** ****** *)

implement
s0arg_make (x1, x2) = let
  val loc = (case x2 of
    | Some s0t => x1.i0de_loc + s0t.s0rt_loc
    | None () => x1.i0de_loc
  ) : location // end of [val]
in '{
  s0arg_loc= loc, s0arg_sym= x1.i0de_sym, s0arg_srt= x2
} end // end of [s0arg_make]

(* ****** ****** *)

implement
s0marg_make_sing (x) = '{
  s0marg_loc= x.s0arg_loc, s0marg_arg= list_sing (x)
} // end of [s0marg_make_sing]

implement
s0marg_make_many
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0marg_loc= loc, s0marg_arg= xs
} end // end of [s0marg_make_many]

(* ****** ****** *)

implement
d0atarg_make_none (s0t) = '{
  d0atarg_loc= s0t.s0rt_loc
, d0atarg_sym= None (), d0atarg_srt= s0t
}

implement
d0atarg_make_some
  (id, s0t) = let
  val loc = id.i0de_loc + s0t.s0rt_loc
in '{
  d0atarg_loc= loc
, d0atarg_sym= Some (id.i0de_sym), d0atarg_srt= s0t
} end // end of [d0atarg_make_some]

implement
d0atmarg_make
  (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  d0atmarg_loc= loc, d0atmarg_arg= xs
} end // end of [d0atmarg_make]

(* ****** ****** *)

implement
s0rtext_srt (s0t) = '{
  s0rtext_loc= s0t.s0rt_loc, s0rtext_node= S0TEsrt s0t
} // end of [s0rtext_srt]

implement
s0rtext_sub (
  t_beg, id, s0te, s0e, s0es, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0rtext_loc= loc, s0rtext_node= S0TEsub (id, s0te, s0e, s0es)
} end // end of [s0rtext_sub]

implement
s0qua_prop (s0e) = '{
  s0qua_loc= s0e.s0exp_loc, s0qua_node= S0QUAprop s0e
}

implement
s0qua_vars (id, ids, s0te) = let
  val loc = id.i0de_loc + s0te.s0rtext_loc
in '{
  s0qua_loc= loc, s0qua_node= S0QUAvars (id, ids, s0te)
} end // end of [s0qua_vars]

(* ****** ****** *)

implement
s0exp_ann (x1, x2) = let
  val loc = x1.s0exp_loc + x2.s0rt_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Eann (x1, x2)
} end // end of [s0exp_ann]

implement
s0exp_app (x1, x2) = let
  val loc = x1.s0exp_loc + x2.s0exp_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Eapp (x1, x2)
} end // end of [s0exp_app]

local
//
fun loop {n:nat} .<n>. (
  tok: token, x: s0exp, xs: list (s0exp, n)
) : location =
  case+ xs of
  | list_cons (x, xs) => loop (tok, x, xs)
  | list_nil () => tok.token_loc + x.s0exp_loc
// end of [loop]
//
in // in of [local]
//
implement
s0exp_extype
  (tok1, tok2, xs) = let
  val- T_STRING (str) = tok2.token_node
  val loc = (case+ xs of
    | list_nil () => tok1.token_loc + tok2.token_loc
    | list_cons (x, xs) => loop (tok1, x, xs)
  ) : location // end of [val]
in '{
  s0exp_loc= loc, s0exp_node= S0Eextype (str, xs)
} end // end of [s0exp_extype]
//
end // end of [local]

implement
s0exp_char (tok) = let
  val- T_CHAR (c) = tok.token_node
in '{
  s0exp_loc= tok.token_loc, s0exp_node= S0Echar (c)
} end // end of [s0exp_char]

implement
s0exp_i0nt (x) = let
in '{
  s0exp_loc= x.i0nt_loc, s0exp_node= S0Ei0nt (x)
} end // end of [s0exp_i0nt]

implement
s0exp_sqid (x) = let
in '{
  s0exp_loc= x.sqi0de_loc
, s0exp_node= S0Esqid (x.sqi0de_qua, x.sqi0de_sym)
} end // end of [s0exp_qid]

implement
s0exp_opid (x1, x2) = let
  val loc = x1.token_loc + x2.i0de_loc
in '{
  s0exp_loc= loc
, s0exp_node= S0Eopid (x2.i0de_sym)
} end // end of [s0exp_opid]

implement
s0exp_lam (t_lam, ent2, ent3, ent4) = let
  val loc = t_lam.token_loc + ent4.s0exp_loc
in '{
  s0exp_loc= loc, s0exp_node = S0Elam (ent2, ent3, ent4)
} end // end of [s0exp_lam]

implement
s0exp_list (t_beg, xs, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Elist (xs)
} end // end of [s0exp_list]

implement
s0exp_list2 (t_beg, xs1, xs2, t_end) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Elist2 (xs1, xs2)
} end // end of [s0exp_list2]

implement
s0exp_tytup (
  knd, npf, t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Etytup (knd, npf, xs)
} end // end of [s0exp_tytup]

implement
s0exp_tyrec (
  knd, npf, t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Etyrec (knd, npf, xs)
} end // end of [s0exp_tyrec]

implement
s0exp_tyrec_ext (
  name, npf, t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Etyrec_ext (name, npf, xs)
} end // end of [s0exp_tyrec]

implement
s0exp_uni (
  t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Euni (xs)
} end // end of [s0exp_uni]

implement
s0exp_exi (
  funres, t_beg, xs, t_end
) = let
  val loc = t_beg.token_loc + t_end.token_loc
in '{
  s0exp_loc= loc, s0exp_node= S0Eexi (funres, xs)
} end // end of [s0exp_exi]

(* ****** ****** *)

implement
labs0exp_make (ent1, ent2) = L0ABELED (ent1, ent2)

(* ****** ****** *)

implement
s0rtdef_make (id, def) = let
(*
  val () = print "s0rtdef_make:\n"
  val () = begin
    print "def.loc = "; print def.s0rtext_loc; print_newline ()
  end // end of [val]
*)
  val loc = id.i0de_loc + def.s0rtext_loc
in '{
  s0rtdef_loc= loc
, s0rtdef_sym= id.i0de_sym
, s0rtdef_def= def
} end // end of [s0rtdef_make]

(* ****** ****** *)

implement
s0tacon_make
  (id, arg, def) = let
  val loc_id = id.i0de_loc
  val loc = (case+ def of
    | Some s0e => loc_id + s0e.s0exp_loc
    | None () => (
        case+ list_last_opt<d0atmarg> (arg) of
        | ~Some_vt x => loc_id + x.d0atmarg_loc
        | ~None_vt () => loc_id
      ) // end of [None]
  ) : location // end of [val]
in '{
  s0tacon_loc= loc
, s0tacon_sym= id.i0de_sym
, s0tacon_arg= arg
, s0tacon_def= def
} end // end of [s0tacon_make_some_some]

(* ****** ****** *)

implement
s0expdef_make (
 id, arg, res, def
) = let
  val loc = id.i0de_loc + def.s0exp_loc
in '{
  s0expdef_loc= loc
, s0expdef_sym= id.i0de_sym
, s0expdef_loc_id= id.i0de_loc
, s0expdef_arg= arg
, s0expdef_res= res
, s0expdef_def= def
} end // end of [s0expdef_make]

(* ****** ****** *)

implement
s0aspdec_make (
  qid, arg, res, def
) = let
  val loc = qid.sqi0de_loc + def.s0exp_loc
in '{
  s0aspdec_loc= loc
, s0aspdec_qid= qid
, s0aspdec_arg= arg
, s0aspdec_res= res
, s0aspdec_def= def
} end // end of [s0aspdec_make]

(* ****** ****** *)

implement
d0atcon_make
  (qua, id, ind, arg) = let
  val loc_id = id.i0de_loc
  val loc = (case+ arg of
    | Some s0e => loc_id + s0e.s0exp_loc
    | None () => begin case+ ind of
      | Some s0e => loc_id + s0e.s0exp_loc | _ => loc_id
      end // end of [None]
  ) : location // end of [val]
in '{
  d0atcon_loc= loc
, d0atcon_sym= id.i0de_sym
, d0atcon_qua= qua
, d0atcon_arg= arg
, d0atcon_ind= ind
} end // end of [d0atcon_make]

(* ****** ****** *)

implement
d0atdec_make (
  id, arg, con
) = let
  val loc_id = id.i0de_loc
  val loc = (case+
    list_last_opt<d0atcon> (con) of
    ~Some_vt (x) => loc_id + x.d0atcon_loc
  | ~None_vt _ => loc_id
  ) : location // end of [val]
  val loc_hd = (case+
    list_last_opt<d0atmarg> (arg) of
    ~Some_vt (x) => loc_id + x.d0atmarg_loc
  | ~None_vt _ => loc_id
  ) : location // end of [val]
  val fil = $FIL.filename_get_current ()
in '{
  d0atdec_loc= loc
, d0atdec_loc_hd= loc_hd
, d0atdec_fil= fil
, d0atdec_sym= id.i0de_sym
, d0atdec_arg= arg
, d0atdec_con= con
} end // end of [d0atdec_make]

(* ****** ****** *)

local

fun loop {n:nat} .<n>. (
  tok: token, id: i0de, ids: list (i0de, n)
) : location =
  case+ ids of
  | list_cons (id, ids) => loop (tok, id, ids)
  | list_nil () => tok.token_loc + id.i0de_loc
// end of [loop]

in // end of [local]

implement
d0ecl_fixity
  (tok, prec, ids) = let
  val- T_FIXITY (knd) = tok.token_node
  val fxty = (case+ knd of
    | FXK_infix () => F0XTYinf (prec, $FIX.ASSOCnon ())
    | FXK_infixl () => F0XTYinf (prec, $FIX.ASSOClft ())
    | FXK_infixr () => F0XTYinf (prec, $FIX.ASSOCrgt ())
    | FXK_prefix () => F0XTYpre (prec)
    | FXK_postfix () => F0XTYpos (prec)
  ) : f0xty // end of [val]
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cfixity (fxty, ids)
} end // end of [d0ecl_infix]

implement
d0ecl_nonfix
  (tok, ids) = let
  val- T_NONFIX () = tok.token_node
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cnonfix (ids)
} end // end of [d0ecl_nonfix]

implement
d0ecl_symintr
  (tok, ids) = let
  val- T_SYMINTR () = tok.token_node
  val loc = (case+ ids of
    | list_cons (id, ids) => loop (tok, id, ids)
    | list_nil () => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csymintr (ids)
} end // end of [d0ecl_symintr]

end // end of [local]

(* ****** ****** *)

implement
d0ecl_e0xpdef
  (tok, ent2, ent3) = let
  val loc = (case+ ent3 of
    | Some x => tok.token_loc + x.e0xp_loc
    | None () => tok.token_loc + ent2.i0de_loc
  ) : location // end of [val]  
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpdef (ent2.i0de_sym, ent3)
} end // end of [d0ecl_e0xpdef]

(* ****** ****** *)

implement
d0ecl_e0xpact_assert
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.e0xp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpact (E0XPACTassert, ent2)
} end // end of [d0ecl_e0xpact_assert]

implement
d0ecl_e0xpact_print
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.e0xp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpact (E0XPACTprint, ent2)
} end // end of [d0ecl_e0xpact_print]

implement
d0ecl_e0xpact_error
  (tok, ent2) = let
  val loc = tok.token_loc + ent2.e0xp_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Ce0xpact (E0XPACTerror, ent2)
} end // end of [d0ecl_e0xpact_error]

implement
d0ecl_datsrts
  (tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<d0atsrtdec> (xs) of
    | ~Some_vt x => loc + x.d0atsrtdec_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cdatsrts (xs)
} end // end of [d0ecl_datsrts]

implement
d0ecl_srtdefs
  (tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0rtdef> (xs) of
    | ~Some_vt x => loc + x.s0rtdef_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csrtdefs (xs)
} end // end of [d0ecl_srtdefs]

implement
d0ecl_stacons
  (knd, tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0tacon> (xs) of
    | ~Some_vt x => loc + x.s0tacon_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstacons (knd, xs)
} end // end of [d0ecl_stacons]

implement
d0ecl_sexpdefs
  (knd, tok, xs) = let
  val loc = tok.token_loc
  val loc = (case+
    list_last_opt<s0expdef> (xs) of
    | ~Some_vt x => loc + x.s0expdef_loc | ~None_vt _ => loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csexpdefs (knd, xs)
} end // end of [d0ecl_sexpdefs]

implement
d0ecl_saspdec (tok, x) = let
  val loc = tok.token_loc + x.s0aspdec_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Csaspdec (x)
} end // end of [d0ecl_saspdec]

(* ****** ****** *)

implement
d0ecl_datdecs_none (
  knd, tok, ent2
) = let
  val loc = (case+
    list_last_opt<d0atdec> (ent2) of
    ~Some_vt x => tok.token_loc + x.d0atdec_loc
  | ~None_vt _ => tok.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cdatdecs (knd, ent2, list_nil)
} end // end of [d0ecl_datdecs_none]

implement
d0ecl_datdecs_some (
  knd, tok, ent2, tok2, ent4
) = let
  val loc = (case+
    list_last_opt<s0expdef> (ent4) of
    ~Some_vt x => tok.token_loc + x.s0expdef_loc
  | ~None_vt _ => tok.token_loc + tok2.token_loc
  ) : location // end of [val]
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cdatdecs (knd, ent2, ent4)
} end // end of [d0ecl_datdecs_some]

(* ****** ****** *)

implement
d0ecl_staload_none
  (tok, tok2) = let
  val- T_STRING (name) = tok2.token_node
  val loc = tok.token_loc + tok2.token_loc
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstaload (None, name)
} end // end of [d0ecl_staload_none]

implement
d0ecl_staload_some
  (tok, ent2, ent4) = let
  val- T_STRING (name) = ent4.token_node
  val loc = tok.token_loc + ent4.token_loc
  val sym = ent2.i0de_sym
in '{
  d0ecl_loc= loc, d0ecl_node= D0Cstaload (Some sym, name)
} end // end of [d0ecl_staload_some]

(* ****** ****** *)

(* end of [pats_syntax.dats] *)
