require 'ffi'

module Ecore::Fb
  extend FFI::Library
  ffi_lib 'ecore_fb'

  EcoreFbInputDeviceCap = enum(:none, :relative, :absolute, :keys_or_buttons)

  # Ecore_FB - Frame buffer convenience functions.
  # http://localhost/ecore/group__Ecore__FB__Group.html

  attach_function :ecore_fb_callback_gain_set, [:pointer, :pointer], :void
  attach_function :ecore_fb_callback_lose_set, [:pointer, :pointer], :void
  attach_function :ecore_fb_init, [:pointer], :int
  attach_function :ecore_fb_input_device_axis_size_set, [:pointer, :int, :int], :void
  attach_function :ecore_fb_input_device_cap_get, [:pointer], EcoreFbInputDeviceCap
  attach_function :ecore_fb_input_device_close, [:pointer], :void
  attach_function :ecore_fb_input_device_listen, [:pointer, :bool], :void
  attach_function :ecore_fb_input_device_name_get, [:pointer], :pointer
  attach_function :ecore_fb_input_device_open, [:pointer], :pointer
  attach_function :ecore_fb_input_device_threshold_click_get, [:pointer], :double
  attach_function :ecore_fb_input_device_threshold_click_set, [:pointer, :double], :void
  attach_function :ecore_fb_input_device_window_set, [:pointer, :pointer], :void
  attach_function :ecore_fb_shutdown, [], :int
  attach_function :ecore_fb_size_get, [:pointer, :pointer], :void
  attach_function :ecore_fb_touch_screen_calibrate_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_fb_touch_screen_calibrate_set, [:int, :int, :int, :int, :int], :void

  # Framebuffer Double Click Functions
  # http://localhost/ecore/group__Ecore__FB__Click__Group.html


  # Framebuffer Calibration Functions
  # http://localhost/ecore/group__Ecore__FB__Calibrate__Group.html

  attach_function :ecore_fb_touch_screen_calibrate_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_fb_touch_screen_calibrate_set, [:int, :int, :int, :int, :int], :void
end
