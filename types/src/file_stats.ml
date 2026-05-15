open! Core
include File_stats_intf
module Int64_u = Int64

module Or_testing = struct
  (** Hide nondeterministic or host-specific values during expect tests. *)
  type 'a t = 'a [@@deriving equal ~portable ~localize, quickcheck ~portable]

  let sexp_of_t sexp_of_a a =
    if am_running_test then Sexp.Atom "<hidden>" else sexp_of_a a
  ;;
end

type t =
  { host_device : int Or_testing.t
  ; inode : int Or_testing.t
  ; kind : File_kind.t
  ; permissions : File_permissions.t
  ; hard_links : int
  ; user_id : int Or_testing.t
  ; group_id : int Or_testing.t
  ; file_device : int Or_testing.t
  ; size : Int64_u.t
  ; access_time : Time_ns.t Or_testing.t
  ; modify_time : Time_ns.t Or_testing.t
  ; status_time : Time_ns.t Or_testing.t
  }
[@@deriving equal ~portable ~localize, quickcheck ~portable, sexp_of ~portable]

let size_in_byte_units_exn t = Byte_units.of_bytes_int64_exn (Int64_u.to_int64 t.size)
