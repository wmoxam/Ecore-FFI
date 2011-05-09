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

  # Ecore Application functions
  attach_function :ecore_app_args_set, [:int, :pointer], :void

  # Ecore Event functions
  callback :ecore_event_handler_cb, [:pointer, :int, :pointer], :int

  attach_function :ecore_event_handler_add, [:int, :ecore_event_handler_cb, :pointer], :pointer
  
  # Ecore Time functions
  callback :ecore_task_cb, [:pointer], :int

  attach_function :ecore_time_get, [], :double
  attach_function :ecore_timer_add, [:double, :ecore_task_cb, :pointer], :pointer

  # Ecore Main Loop functions
  attach_function :ecore_main_loop_begin, [], :void
  attach_function :ecore_main_loop_quit, [], :void
end
  
