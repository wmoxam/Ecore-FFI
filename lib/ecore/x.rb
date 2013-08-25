require 'ffi'

module Ecore::X
  extend FFI::Library
  ffi_lib 'ecore_x'

  EcoreXDamageReportLevel = enum(:raw_rectangles, :delta_rectangles, :bounding_box, :non_empty)

  EcoreXWindowState = enum(:iconified, :modal, :sticky, :maximized_vert, :maximized_horz, :shaded,
                           :skip_taskbar, :skip_pager, :hidden, :fullscreen, :above, :below,
                           :demands_attention)

  EcoreXShapeType = enum(:bound, :clip, :input)

  EcoreXWMProtocol = enum(:delete_request, :take_focus, :ping, :sync_request, :num)

  EcoreXGravity = enum(:forget, :unmap, :nw, :n, :ne, :w, :center, :e, :sw, :s, :se, :static)

  EcoreXAction = enum(:move, :resize, :minimize, :shade, :stick, :maximize_horz, :maximize_vert, :fullscreen, :change_desktop, :close, :above, :below)

  EcoreXWindowType = enum(:unknown, :desktop, :dock, :toolbar, :menu, :utility, :splash, :dialog, :normal, :dropdown_menu, :popup_menu, :tooltip, :notification, :combo, :dnd)

  EcoreXWindowConfigureMask = enum(:x, :y, :w, :h, :border_width, :sibling, :stack_mode)

  # X Library Init and Shutdown Functions
  # http://localhost/ecore/group__Ecore__Xcb__Init__Group.html


  # X Display Attributes
  # http://localhost/ecore/group__Ecore__Xcb__Display__Attr__Group.html


  # X Synchronization Functions
  # http://localhost/ecore/group__Ecore__Xcb__Flush__Group.html

  # XCB Atom Functions
  # http://localhost/ecore/group__Ecore__X__Atom__Group.html

  # I don't understand what, or why ...
  #attach_function :ecore_x_atom_get, [:pointer], EcoreXAtom
  #attach_function :ecore_x_atom_name_get, [EcoreXAtom], :pointer



  # X Composite Extension Functions
  # http://localhost/ecore/group__Ecore__X__Composite__Group.html

  attach_function :ecore_x_composite_query, [], :boolean



  # X Damage Extension Functions
  # http://localhost/ecore/group__Ecore__X__Damage__Group.html

# Not sure how to support X stuff yet
#  attach_function :ecore_x_damage_free, [EcoreXDamage], :void
#  attach_function :ecore_x_damage_new, [EcoreXDrawable, EcoreXDamageReportLevel], EcoreXDamage
#  attach_function :ecore_x_damage_subtract, [EcoreXDamage, EcoreXRegion, EcoreXRegion], :void



  # X DPMS Extension Functions
  # http://localhost/ecore/group__Ecore__X__DPMS__Group.html

  attach_function :ecore_x_dpms_capable_get, [], :boolean
  attach_function :ecore_x_dpms_enabled_get, [], :boolean
  attach_function :ecore_x_dpms_enabled_set, [:int], :void
  attach_function :ecore_x_dpms_query, [], :boolean
  attach_function :ecore_x_dpms_timeout_off_get, [], :int
  attach_function :ecore_x_dpms_timeout_off_set, [:uint], :void
  attach_function :ecore_x_dpms_timeout_standby_get, [], :int
  attach_function :ecore_x_dpms_timeout_standby_set, [:uint], :void
  attach_function :ecore_x_dpms_timeout_suspend_get, [], :int
  attach_function :ecore_x_dpms_timeout_suspend_set, [:uint], :void
  attach_function :ecore_x_dpms_timeouts_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_x_dpms_timeouts_set, [:uint, :uint, :uint], :boolean



  # X Drawable Functions
  # http://localhost/ecore/group__Ecore__X__Drawable__Group.html

#  attach_function :ecore_x_drawable_border_width_get, [EcoreXDrawable], :int
#  attach_function :ecore_x_drawable_depth_get, [EcoreXDrawable], :int
#  attach_function :ecore_x_drawable_geometry_get, [EcoreXDrawable, :pointer, :pointer, :pointer, :pointer], :void



  # X Fixes Extension Functions
  # http://localhost/ecore/group__Ecore__X__Fixes__Group.html

#  attach_function :ecore_x_region_combine, [EcoreXRegion, EcoreXRegion, EcoreXRegion], :void
#  attach_function :ecore_x_region_copy, [EcoreXRegion, EcoreXRegion], :void
#  attach_function :ecore_x_region_expand, [EcoreXRegion, EcoreXRegion, :uint, :uint, :uint, :uint], :void
#  attach_function :ecore_x_region_extents, [EcoreXRegion, EcoreXRegion], :void
#  attach_function :ecore_x_region_fetch, [EcoreXRegion, :pointer, :pointer], :pointer
#  attach_function :ecore_x_region_free, [EcoreXRegion], :void
#  attach_function :ecore_x_region_gc_clip_set, [EcoreXRegion, EcoreXGC, :int, :int], :void
#  attach_function :ecore_x_region_intersect, [EcoreXRegion, EcoreXRegion, EcoreXRegion], :void
#  attach_function :ecore_x_region_invert, [EcoreXRegion, :pointer, EcoreXRegion], :void
#  attach_function :ecore_x_region_new, [:pointer, :int], EcoreXRegion
#  attach_function :ecore_x_region_new_from_bitmap, [EcoreXPixmap], EcoreXRegion
#  attach_function :ecore_x_region_new_from_gc, [EcoreXGC], EcoreXRegion
#  attach_function :ecore_x_region_new_from_picture, [EcoreXPicture], EcoreXRegion
#  attach_function :ecore_x_region_new_from_window, [EcoreXWindow, EcoreXRegionType], EcoreXRegion
#  attach_function :ecore_x_region_picture_clip_set, [EcoreXRegion, EcoreXPicture, :int, :int], :void
#  attach_function :ecore_x_region_set, [EcoreXRegion, :pointer, :int], :void
#  attach_function :ecore_x_region_subtract, [EcoreXRegion, EcoreXRegion, EcoreXRegion], :void
#  attach_function :ecore_x_region_translate, [EcoreXRegion, :int, :int], :void
#  attach_function :ecore_x_region_window_shape_set, [EcoreXRegion, EcoreXWindow, EcoreXShapeType, :int, :int], :void



  # ICCCM related functions
  # http://localhost/ecore/group__Ecore__X__ICCCM__Group.html


  # MWM related functions
  # http://localhost/ecore/group__Ecore__X__MWM__Group.html

#  attach_function :ecore_x_mwm_borderless_set, [EcoreXWindow, :boolean], :void



  # Extended Window Manager Hint (EWMH) functions
  # http://localhost/ecore/group__Ecore__X__NetWM__Group.html


  # X Pixmap Functions
  # http://localhost/ecore/group__Ecore__X__RandR__Group.html


  # X RandR Extension Functions
  # http://localhost/ecore/group__Ecore__X__RandR__Group.html


  # X ScreenSaver extension
  # http://localhost/ecore/group__Ecore__X__ScreenSaver__Group.html


  # X Shape extension
  # http://localhost/ecore/group__Ecore__X__Shape__Group.html


  # X Sync Extension Functions
  # http://localhost/ecore/group__Ecore__X__Sync__Group.html


  # X Window Creation Functions
  # http://localhost/ecore/group__Ecore__X__Window__Create__Group.html

#  attach_function :ecore_x_window_argb_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow
#  attach_function :ecore_x_window_input_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow
#  attach_function :ecore_x_window_manager_argb_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow
#  attach_function :ecore_x_window_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow
#  attach_function :ecore_x_window_override_argb_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow
#  attach_function :ecore_x_window_override_new, [EcoreXWindow, :int, :int, :int, :int], EcoreXWindow



  # X Window Destroy Functions
  # http://localhost/ecore/group__Ecore__X__Window__Destroy__Group.html

#  attach_function :ecore_x_window_delete_request_send, [EcoreXWindow], :void
#  attach_function :ecore_x_window_free, [EcoreXWindow], :void



  # X Window Configure Functions
  # http://localhost/ecore/group__Ecore__X__Window__Configure__Group.html


  # X Window Visibility Functions
  # http://localhost/ecore/group__Ecore__X__Window__Visibility__Group.html

#  attach_function :ecore_x_window_visible_get, [EcoreXWindow], :int



  # X Window Input Focus Functions
  # http://localhost/ecore/group__Ecore__X__Window__Input__Focus__Group.html


  # X Window Reparent Functions
  # http://localhost/ecore/group__Ecore__X__Window__Reparent__Group.html


  # X Window Change Attributes Functions
  # http://localhost/ecore/group__Ecore__X__Window__Change__Attributes__Group.html


  # X Window Change Save Set Functions
  # http://localhost/ecore/group__Ecore__X__Window__Save__Set__Group.html


  # X Window Get Attributes Functions
  # http://localhost/ecore/group__Ecore__X__Window__Get__Attributes__Group.html


  # X Window Geometry Functions
  # http://localhost/ecore/group__Ecore__X__Window__Geometry__Group.html

#  attach_function :ecore_x_window_at_xy_get, [:int, :int], EcoreXWindow
#  attach_function :ecore_x_window_at_xy_with_skip_get, [:int, :int, :pointer, :int], EcoreXWindow
#  attach_function :ecore_x_window_border_width_get, [EcoreXWindow], :int
#  attach_function :ecore_x_window_border_width_set, [EcoreXWindow, :int], :void
#  attach_function :ecore_x_window_geometry_get, [EcoreXWindow, :pointer, :pointer, :pointer, :pointer], :void
#  attach_function :ecore_x_window_move, [EcoreXWindow, :int, :int], :void
#  attach_function :ecore_x_window_move_resize, [EcoreXWindow, :int, :int, :int, :int], :void
#  attach_function :ecore_x_window_resize, [EcoreXWindow, :int, :int], :void
#  attach_function :ecore_x_window_root_get, [EcoreXWindow], EcoreXWindow
#  attach_function :ecore_x_window_shadow_parent_get, [EcoreXWindow, EcoreXWindow], EcoreXWindow
#  attach_function :ecore_x_window_shadow_tree_at_xy_with_skip_get, [EcoreXWindow, :int, :int, :pointer, :int], EcoreXWindow
#  attach_function :ecore_x_window_size_get, [EcoreXWindow, :pointer, :pointer], :void



  # X Xinerama Extension Functions
  # http://localhost/ecore/group__Ecore__X__Xinerama__Group.html


  # X Library Init and Shutdown Functions
  # http://localhost/ecore/group__Ecore__X__Init__Group.html

  attach_function :ecore_x_disconnect, [], :int
  attach_function :ecore_x_init, [:pointer], :int
  attach_function :ecore_x_shutdown, [], :int



  # X Display Attributes
  # http://localhost/ecore/group__Ecore__X__Display__Attr__Group.html

  attach_function :ecore_x_default_screen_get, [], :pointer
  attach_function :ecore_x_display_get, [], :pointer
  attach_function :ecore_x_double_click_time_get, [], :double
  attach_function :ecore_x_double_click_time_set, [:double], :void
  attach_function :ecore_x_fd_get, [], :int
  attach_function :ecore_x_screen_count_get, [], :int
  attach_function :ecore_x_screen_get, [:int], :pointer
  attach_function :ecore_x_screen_index_get, [:pointer], :int
  attach_function :ecore_x_screen_size_get, [:pointer, :pointer, :pointer], :void



  # X Synchronization Functions
  # http://localhost/ecore/group__Ecore__X__Flush__Group.html

  # X Window Focus Functions
  # http://localhost/ecore/group__Ecore__X__Window__Focus__Functions.html

#  attach_function :ecore_x_window_focus, [EcoreXWindow], :void
#  attach_function :ecore_x_window_focus_at_time, [EcoreXWindow, EcoreXTime], :void
#  attach_function :ecore_x_window_focus_get, [], EcoreXWindow



  # X Window Z Order Functions
  # http://localhost/ecore/group__Ecore__X__Window__Z__Order__Group.html

#  attach_function :ecore_x_window_lower, [EcoreXWindow], :void
#  attach_function :ecore_x_window_raise, [EcoreXWindow], :void



  # X Window Parent Functions
  # http://localhost/ecore/group__Ecore__X__Window__Parent__Group.html

#  attach_function :ecore_x_window_parent_get, [EcoreXWindow], EcoreXWindow
#  attach_function :ecore_x_window_reparent, [EcoreXWindow, EcoreXWindow, :int, :int], :void



  # X Window Shape Functions
  # http://localhost/ecore/group__Ecore__X__Window__Shape.html

#  attach_function :ecore_x_window_shape_input_mask_set, [EcoreXWindow, EcoreXPixmap], :void
#  attach_function :ecore_x_window_shape_mask_set, [EcoreXWindow, EcoreXPixmap], :void


end
  
