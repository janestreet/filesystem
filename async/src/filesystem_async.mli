open! Core
open! Async

(** @inline *)
include Filesystem.S with module IO := Deferred and type Fd.t = Unix.Fd.t
