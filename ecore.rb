require 'ffi'

module Ecore
  extend FFI::Library
  ffi_lib 'ecore'

  ECORE_CALLBACK_CANCEL = 0
  ECORE_CALLBACK_RENEW = 1
  ECORE_CALLBACK_PASS_ON = 1
  ECORE_CALLBACK_DONE = 0
  ECORE_EVENT_SIGNAL_USER = 1
  ECORE_EVENT_SIGNAL_HUP = 2
  ECORE_EVENT_SIGNAL_EXIT = 3
  ECORE_EVENT_SIGNAL_POWER = 4
  ECORE_EVENT_SIGNAL_REALTIME = 5

  class EcoreEventSignalExit < FFI::Struct
    layout :interrupt, :int,
           :quit, :int,
           :terminate, :int,
           :ext_data, :pointer,
           :data, :pointer
  end

  class EcoreEventSignalUser < FFI::Struct
    layout :number, :int,
           :ext_date, :pointer,
           :data, :pointer
  end

  class EcoreEventSignalHup < FFI::Struct
    layout :ext_data, :pointer,
           :data, :pointer
  end

  class EcoreEventSignalPower < FFI::Struct
    layout :ext_data, :pointer,
           :data, :pointer
  end

  class EcoreSignalRealtime < FFI::Struct
    layout :num, :int,
           :data, :pointer
  end

  class EcoreExeEventAdd < FFI::Struct
    layout :exe, :pointer, # EcoreExe
           :ext_data, :pointer
  end

  class EcoreExeEventDel < FFI::Struct
    layout :pid, :int,
           :exit_code, :int,
           :exe, :pointer, # EcoreExe
           :exited, :int,
           :signalled, :int,
           :ext_data, :pointer,
           :data, :pointer
  end

  class EcoreExeEventData < FFI::Struct
    layout :exe, :pointer,
           :data, :pointer,
           :size, :int,
           :lines, :pointer # EcoreExeEventDataLine
  end

  EcoreFdHandlerFlags = enum(:read, :write, :error)

  EcoreExeFlags = enum(:none, :pipe_read, :pipe_write, :pipe_error,
                       :pipe_read_line_buffered, :pipe_error_line_buffered,
                       :pipe_auto, :respawn, :use_sh, :not_leader)

  EcoreExeWin32Priority = enum(:idle, :below_normal, :normal,
                               :above_normal, :high, :realtime)

  EcorePollerType = enum(:core, 0)

  EcorePosMap = enum(:linear, :accelerate, :decelerate, :sinusoidal,
                     :accelerate_factor, :decelerate_factor,
                     :sinusoidal_factor, :divisor_interp,
                     :bounce, :spring)

  # Main Loop and Job Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Group.html
  callback :ecore_data_cb, [:pointer], :pointer
  callback :ecore_filter_cb, [:pointer, :pointer, :int, :pointer], :int
  callback :ecore_end_cb, [:pointer, :pointer], :void 
  callback :ecore_pipe_cb, [:pointer, :pointer, :uint], :void
  callback :ecore_exe_cb, [:pointer, :pointer], :void
  callback :ecore_event_handler_cb, [:pointer, :int, :pointer], :int
  callback :ecore_thread_cb, [:pointer, :pointer], :void
  callback :ecore_thread_notify_cb, [:pointer, :pointer, :pointer], :void
  callback :ecore_task_cb, [:pointer], :int
  callback :ecore_timeline_cb, [:pointer], :int
  callback :ecore_db, [:pointer], :int
  callback :ecore_fd_cb, [:pointer, :pointer], :int
  callback :ecore_fd_prep_cb, [:pointer, :pointer], :void
  callback :ecore_win32_handle_cb, [:pointer, :pointer], :int

  attach_function :ecore_init, [], :int
  attach_function :ecore_shutdown, [], :int
  attach_function :ecore_pipe_add, [:ecore_pipe_cb, :pointer], :pointer
  attach_function :ecore_pipe_del, [:pointer], :pointer
  attach_function :ecore_pipe_read_close, [:pointer], :void
  attach_function :ecore_pipe_write_close, [:pointer], :void
  attach_function :ecore_pipe_write, [:pointer, :pointer, :uint], :int

  # Ecore initialisation and shutdown functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Init__Group.html

  # Ecore Animator functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Animator__Group.html


  # Ecore Application functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Application__Group.html
  attach_function :ecore_app_args_set, [:int, :pointer], :void

  # Ecore Event functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Event__Group.html
  callback :ecore_event_handler_cb, [:pointer, :int, :pointer], :int

  attach_function :ecore_event_handler_add, [:int, :ecore_event_handler_cb, :pointer], :pointer
  
  # Process Spawning Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Exe__Group.html

  # Ecore Main Loop functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Main__Loop__Group.html
  attach_function :ecore_main_loop_begin, [], :void
  attach_function :ecore_main_loop_quit, [], :void

  # File Event Handling Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FD__Handler__Group.html

  # Ecore Idle functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Idle__Group.html

  # Ecore Job functions
  # http://docs.enlightenment.org/auto/ecore/modules.html

  # Pipe wrapper
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Pipe__Group.html

  # Ecore Poll functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Poller__Group.html

  # Ecore Thread functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Thread__Group.html

  # Ecore Time functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Time__Group.html
  callback :ecore_task_cb, [:pointer], :int

  attach_function :ecore_time_get, [], :double
  attach_function :ecore_timer_add, [:double, :ecore_task_cb, :pointer], :pointer

  # Loop_Group Ecore Main Loop functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Main.html

  # Ecore Connection Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Lib__Group.html

  # Ecore Connection Server Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Server__Group.html

  # Ecore Connection Client Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Client__Group.html

  # Ecore URL Connection Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Url__Group.html

  # Ecore Connection SSL Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__SSL__Group.html

  # Events
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Events__Group.html

  # Ecore_FB - Frame buffer convenience functions.
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Group.html

  # Framebuffer Double Click Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Click__Group.html

  # Framebuffer Calibration Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Calibrate__Group.html

  # Ecore_File - Files and directories convenience functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__File__Group.html

  # Ecore Input Method Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Lib__Group.html

  # Ecore Input Method Context Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Context__Group.html

  # Ecore Input Method Context Module Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Context__Module__Group.html

  # Ecore Input Method Context Evas Helper Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Evas__Group.html

  # IPC Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Library__Group.html

  # IPC Server Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Server__Group.html

  # IPC Client Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Client__Group.html

  # Ecore_Win32 library
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Win32__Group.html

  # Ecore_WinCE library
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__WinCE__Group.html

  # X Library Init and Shutdown Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Init__Group.html

  # X Display Attributes
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Display__Attr__Group.html

  # X Synchronization Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Flush__Group.html

  # XCB Atom Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Atom__Group.html

  # X Composite Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Composite__Group.html

  # X Damage Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Damage__Group.html

  # X DPMS Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__DPMS__Group.html

  # X Drawable Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Drawable__Group.html

  # X Fixes Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Fixes__Group.html

  # ICCCM related functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__ICCCM__Group.html

  # MWM related functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__MWM__Group.html

  # Extended Window Manager Hint (EWMH) functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__NetWM__Group.html

  # X Pixmap Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__RandR__Group.html

  # X RandR Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__RandR__Group.html

  # X ScreenSaver extension
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__ScreenSaver__Group.html

  # X Shape extension
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Shape__Group.html

  # X Sync Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Sync__Group.html

  # X Window Creation Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Create__Group.html

  # X Window Destroy Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Destroy__Group.html

  # X Window Configure Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Configure__Group.html

  # X Window Visibility Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Visibility__Group.html

  # X Window Input Focus Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Input__Focus__Group.html

  # X Window Reparent Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Reparent__Group.html

  # X Window Change Attributes Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Change__Attributes__Group.html

  # X Window Change Save Set Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Save__Set__Group.html

  # X Window Get Attributes Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Get__Attributes__Group.html

  # X Window Geometry Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Geometry__Group.html

  # X Xinerama Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Xinerama__Group.html

  # X Library Init and Shutdown Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Init__Group.html

  # X Display Attributes
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Display__Attr__Group.html

  # X Synchronization Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Flush__Group.html

  # X Window Focus Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Focus__Functions.html

  # X Window Z Order Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Z__Order__Group.html

  # X Window Parent Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Parent__Group.html

  # X Window Shape Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Shape.html

end
  
