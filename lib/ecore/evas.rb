require 'ffi'

module Ecore::Evas
  extend FFI::Library
  ffi_lib 'ecore_evas'

  EcoreEvasAvoidDamageType = enum(:none, :expose, :built_in)

  EcoreEvasEngineType = enum(:software_buffer, :software_xlib, :xrender_x11, :opengl_x11, :software_xcb, :xrender_xcb, 
                             :software_gdi, :software_ddraw, :direct3d, :opengl_glew, :cocoa, :software_sdl, :directfb,
                             :software_fb, :software_8_x11, :software_16_x11, :software_16_ddraw, :software_16_wince, :opengl_sdl)

  EcoreEvasObjectAssociateFlags = enum(:base, :stack, :layer, :del)

  callback :ecore_evas_event_cb, [:pointer], :void

  # Ecore_Evas wrapper/helper set of functions
  # http://localhost/ecore/group__Ecore__Evas__Group.html

  attach_function :ecore_evas_activate, [:pointer], :void
  attach_function :ecore_evas_alpha_get, [:pointer], :bool
  attach_function :ecore_evas_alpha_set, [:pointer, :bool], :void
  attach_function :ecore_evas_aspect_get, [:pointer], :double
  attach_function :ecore_evas_aspect_set, [:pointer, :double], :void
  attach_function :ecore_evas_avoid_damage_get, [:pointer], EcoreEvasAvoidDamageType
  attach_function :ecore_evas_avoid_damage_set, [:pointer, EcoreEvasAvoidDamageType], :void
  attach_function :ecore_evas_borderless_get, [:pointer], :bool
  attach_function :ecore_evas_borderless_set, [:pointer, :bool], :void
  attach_function :ecore_evas_buffer_allocfunc_new, [:int, :int, :pointer, :pointer, :pointer], :pointer
  attach_function :ecore_evas_buffer_new, [:int, :int], :pointer
  attach_function :ecore_evas_buffer_pixels_get, [:pointer], :pointer
  attach_function :ecore_evas_callback_delete_request_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_destroy_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_focus_in_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_focus_out_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_hide_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_mouse_in_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_mouse_out_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_move_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_post_render_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_pre_free_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_pre_render_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_resize_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_show_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_state_change_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_sticky_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_callback_unsticky_set, [:pointer, :ecore_evas_event_cb], :void
  attach_function :ecore_evas_cursor_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_cursor_set, [:pointer, :pointer, :int, :int, :int], :void
  attach_function :ecore_evas_data_get, [:pointer, :pointer], :pointer
  attach_function :ecore_evas_data_set, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_demand_attention_get, [:pointer], :bool
  attach_function :ecore_evas_demand_attention_set, [:pointer, :bool], :void
  attach_function :ecore_evas_ecore_evas_get, [:pointer], :pointer
  attach_function :ecore_evas_ecore_evas_list_get, [], :pointer
  attach_function :ecore_evas_engine_name_get, [:pointer], :pointer
  attach_function :ecore_evas_engine_type_supported_get, [EcoreEvasEngineType], :int
  attach_function :ecore_evas_engines_get, [], :pointer
  attach_function :ecore_evas_ews_backing_store_get, [:pointer], :pointer
  attach_function :ecore_evas_ews_delete_request, [:pointer], :void
  attach_function :ecore_evas_ews_new, [:int, :int, :int, :int], :pointer
  attach_function :ecore_evas_fb_new, [:pointer, :int, :int, :int], :pointer
  attach_function :ecore_evas_focus_get, [:pointer], :bool
  attach_function :ecore_evas_focus_set, [:pointer, :bool], :void
  attach_function :ecore_evas_focus_skip_get, [:pointer], :bool
  attach_function :ecore_evas_focus_skip_set, [:pointer, :bool], :void
  attach_function :ecore_evas_free, [:pointer], :void
  attach_function :ecore_evas_fullscreen_get, [:pointer], :bool
  attach_function :ecore_evas_fullscreen_set, [:pointer, :bool], :void
  attach_function :ecore_evas_geometry_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_get, [:pointer], :pointer
  attach_function :ecore_evas_gl_x11_direct_resize_get, [:pointer], :bool
  attach_function :ecore_evas_gl_x11_direct_resize_set, [:pointer, :bool], :void
  #attach_function :ecore_evas_gl_x11_extra_event_window_add, [:pointer, EcoreXWindow], :void
  #attach_function :ecore_evas_gl_x11_new, [:pointer, EcoreXWindow, :int, :int, :int, :int], :pointer
  attach_function :ecore_evas_gl_x11_pre_post_swap_callback_set, [:pointer, :pointer, :pointer, :pointer], :void
  #attach_function :ecore_evas_gl_x11_window_get, [:pointer], EcoreXWindow
  attach_function :ecore_evas_hide, [:pointer], :void
  attach_function :ecore_evas_iconified_get, [:pointer], :bool
  attach_function :ecore_evas_iconified_set, [:pointer, :bool], :void
  attach_function :ecore_evas_ignore_events_get, [:pointer], :bool
  attach_function :ecore_evas_ignore_events_set, [:pointer, :bool], :void
  attach_function :ecore_evas_init, [], :int
  attach_function :ecore_evas_input_event_register, [:pointer], :void
  attach_function :ecore_evas_input_event_unregister, [:pointer], :void
  attach_function :ecore_evas_layer_get, [:pointer], :int
  attach_function :ecore_evas_layer_set, [:pointer, :int], :void
  attach_function :ecore_evas_lower, [:pointer], :void
  attach_function :ecore_evas_managed_move, [:pointer, :int, :int], :void
  attach_function :ecore_evas_manual_render, [:pointer], :void
  attach_function :ecore_evas_maximized_get, [:pointer], :bool
  attach_function :ecore_evas_maximized_set, [:pointer, :bool], :void
  attach_function :ecore_evas_modal_get, [:pointer], :bool
  attach_function :ecore_evas_modal_set, [:pointer, :bool], :void
  attach_function :ecore_evas_move, [:pointer, :int, :int], :void
  attach_function :ecore_evas_move_resize, [:pointer, :int, :int, :int, :int], :void
  attach_function :ecore_evas_name_class_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_name_class_set, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_new, [:pointer, :int, :int, :int, :int, :pointer], :pointer
  attach_function :ecore_evas_object_associate, [:pointer, :pointer, EcoreEvasObjectAssociateFlags], :bool
  attach_function :ecore_evas_object_associate_get, [:pointer], :pointer
  attach_function :ecore_evas_object_cursor_set, [:pointer, :pointer, :int, :int, :int], :void
  attach_function :ecore_evas_object_dissociate, [:pointer, :pointer], :bool
  attach_function :ecore_evas_object_ecore_evas_get, [:pointer], :pointer
  attach_function :ecore_evas_object_evas_get, [:pointer], :pointer
  attach_function :ecore_evas_object_image_new, [:pointer], :pointer
  attach_function :ecore_evas_override_get, [:pointer], :bool
  attach_function :ecore_evas_override_set, [:pointer, :bool], :void
  attach_function :ecore_evas_raise, [:pointer], :void
  attach_function :ecore_evas_request_geometry_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_resize, [:pointer, :int, :int], :void
  attach_function :ecore_evas_rotation_get, [:pointer], :int
  attach_function :ecore_evas_rotation_set, [:pointer, :int], :void
  attach_function :ecore_evas_rotation_with_resize_set, [:pointer, :int], :void
  attach_function :ecore_evas_screen_geometry_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_shaped_get, [:pointer], :bool
  attach_function :ecore_evas_shaped_set, [:pointer, :bool], :void
  attach_function :ecore_evas_show, [:pointer], :void
  attach_function :ecore_evas_shutdown, [], :int
  attach_function :ecore_evas_size_base_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_size_base_set, [:pointer, :int, :int], :void
  attach_function :ecore_evas_size_max_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_size_max_set, [:pointer, :int, :int], :void
  attach_function :ecore_evas_size_min_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_size_min_set, [:pointer, :int, :int], :void
  attach_function :ecore_evas_size_step_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_evas_size_step_set, [:pointer, :int, :int], :void
  attach_function :ecore_evas_software_x11_16_direct_resize_get, [:pointer], :bool
  attach_function :ecore_evas_software_x11_16_direct_resize_set, [:pointer, :bool], :void
  #attach_function :ecore_evas_software_x11_16_extra_event_window_add, [:pointer, EcoreXWindow], :void
  #attach_function :ecore_evas_software_x11_16_new, [:pointer, EcoreXWindow, :int, :int, :int, :int], :pointer
  #attach_function :ecore_evas_software_x11_16_window_get, [:pointer], EcoreXWindow
  attach_function :ecore_evas_software_x11_8_direct_resize_get, [:pointer], :bool
  attach_function :ecore_evas_software_x11_8_direct_resize_set, [:pointer, :bool], :void
  #attach_function :ecore_evas_software_x11_8_extra_event_window_add, [:pointer, EcoreXWindow], :void
  #attach_function :ecore_evas_software_x11_8_new, [:pointer, EcoreXWindow, :int, :int, :int, :int], :pointer
  #attach_function :ecore_evas_software_x11_8_subwindow_get, [:pointer], EcoreXWindow
  #attach_function :ecore_evas_software_x11_8_window_get, [:pointer], EcoreXWindow
  attach_function :ecore_evas_software_x11_direct_resize_get, [:pointer], :bool
  attach_function :ecore_evas_software_x11_direct_resize_set, [:pointer, :bool], :void
  #attach_function :ecore_evas_software_x11_extra_event_window_add, [:pointer, EcoreXWindow], :void
  #attach_function :ecore_evas_software_x11_new, [:pointer, EcoreXWindow, :int, :int, :int, :int], :pointer
  #attach_function :ecore_evas_software_x11_window_get, [:pointer], EcoreXWindow
  attach_function :ecore_evas_sticky_get, [:pointer], :bool
  attach_function :ecore_evas_sticky_set, [:pointer, :bool], :void
  attach_function :ecore_evas_title_get, [:pointer], :pointer
  attach_function :ecore_evas_title_set, [:pointer, :pointer], :void
  attach_function :ecore_evas_transparent_get, [:pointer], :bool
  attach_function :ecore_evas_transparent_set, [:pointer, :bool], :void
  attach_function :ecore_evas_urgent_get, [:pointer], :bool
  attach_function :ecore_evas_urgent_set, [:pointer, :bool], :void
  attach_function :ecore_evas_visibility_get, [:pointer], :int
  #attach_function :ecore_evas_window_get, [:pointer], EcoreWindow
  attach_function :ecore_evas_window_group_get, [:pointer], :pointer
  attach_function :ecore_evas_window_group_set, [:pointer, :pointer], :void
  attach_function :ecore_evas_withdrawn_get, [:pointer], :bool
  attach_function :ecore_evas_withdrawn_set, [:pointer, :bool], :void
  attach_function :ecore_getopt_callback_ecore_evas_list_engines, [:pointer, :pointer, :pointer, :pointer, :pointer], :char

  # Ecore_Evas Single Process Windowing System
  # http://localhost/ecore/group__Ecore__Evas__Ews.html 

  attach_function :ecore_evas_ews_background_set, [:pointer], :void
  attach_function :ecore_evas_ews_children_get, [], :pointer
  attach_function :ecore_evas_ews_ecore_evas_get, [], :pointer
  attach_function :ecore_evas_ews_engine_set, [:pointer, :pointer], :bool
  attach_function :ecore_evas_ews_evas_get, [], :pointer
  attach_function :ecore_evas_ews_manager_get, [], :pointer
  attach_function :ecore_evas_ews_manager_set, [:pointer], :void
  attach_function :ecore_evas_ews_setup, [:int, :int, :int, :int], :bool

  # External plug/socket infrastructure to remote canvases
  # http://localhost/ecore/group__Ecore__Evas__Extn.html

  attach_function :ecore_evas_extn_plug_connect, [:pointer, :pointer, :int, :bool], :bool
  attach_function :ecore_evas_extn_plug_new, [:pointer], :pointer
  attach_function :ecore_evas_extn_plug_object_data_lock, [:pointer], :void
  attach_function :ecore_evas_extn_plug_object_data_unlock, [:pointer], :void
  attach_function :ecore_evas_extn_socket_listen, [:pointer, :pointer, :int, :bool], :bool
  attach_function :ecore_evas_extn_socket_new, [:int, :int], :pointer
end
  
