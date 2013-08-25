require 'ffi'

module Ecore::Imf::Evas
  extend FFI::Library
  ffi_lib 'ecore_imf_evas'

  # Ecore Input Method Context Evas Helper Functions
  # http://localhost/ecore/group__Ecore__IMF__Evas__Group.html

  attach_function :ecore_imf_evas_event_key_down_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_key_up_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_down_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_in_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_move_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_out_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_up_wrap, [:pointer, :pointer], :void
  attach_function :ecore_imf_evas_event_mouse_wheel_wrap, [:pointer, :pointer], :void

end
