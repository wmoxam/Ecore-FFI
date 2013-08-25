require 'ffi'

module Ecore:Wl
  extend FFI::Library
  ffi_lib 'ecore_wl'

 # Wayland Library Init and Shutdown Functions
  # http://localhost/ecore/group__Ecore__Wl__Init__Group.html

  attach_function :ecore_wl_init, [:pointer], :int
  attach_function :ecore_wl_shutdown, [], :int

  # Wayland Synchronization Functions
  # http://localhost/ecore/group__Ecore__Wl__Flush__Group.html

  attach_function :ecore_wl_flush, [], :void
  attach_function :ecore_wl_sync, [], :void

  # Wayland Display Functions
  # http://localhost/ecore/group__Ecore__Wl__Display__Group.html

  attach_function :ecore_wl_display_get, [], :pointer
  attach_function :ecore_wl_screen_size_get, [:pointer, :pointer], :void
  attach_function :ecore_wl_shm_get, [], :pointer

  # Wayland Library Init and Shutdown Functions
  # http://localhost/ecore/group__Ecore__Wl__Window__Group.html

  attach_function :ecore_wl_window_free, [:pointer], :void
  attach_function :ecore_wl_window_hide, [:pointer], :void
  attach_function :ecore_wl_window_move, [:pointer, :int, :int], :void
  attach_function :ecore_wl_window_new, [:pointer, :int, :int, :int, :int, :int], :pointer
  attach_function :ecore_wl_window_raise, [:pointer], :void
  attach_function :ecore_wl_window_resize, [:pointer, :int, :int, :int], :void
  attach_function :ecore_wl_window_show, [:pointer], :void
end
