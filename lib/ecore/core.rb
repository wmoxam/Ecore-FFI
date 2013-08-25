require 'ffi'

module Ecore
  extend FFI::Library
  ffi_lib 'ecore'

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

  EcorePollerType = enum(:core, 0)

  EcorePosMap = enum(:linear, :accelerate, :decelerate, :sinusoidal,
                     :accelerate_factor, :decelerate_factor,
                     :sinusoidal_factor, :divisor_interp,
                     :bounce, :spring)
  
  EcoreAnimatorSource = enum(:timer, :custom)

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

  # Ecore initialization and shutdown functions
  # http://localhost/ecore/group__Ecore__Init__Group.html

  attach_function :ecore_init, [], :int
  attach_function :ecore_shutdown, [], :int

  # Main Loop and Job Functions
  # http://localhost/ecore/group__Ecore__Group.html
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
  callback :ecore_select_cb, [:int, :pointer, :pointer, :pointer, :pointer], :int
  callback :eina_free_cb, [:pointer], :pointer
  callback :ecore_cb, [:pointer], :pointer

  # Ecore Job Functions
  # http://localhost/ecore/group__Ecore__Job__Group.html

  attach_function :ecore_job_add, [:ecore_cb, :pointer], :pointer
  attach_function :ecore_job_del, [:pointer], :pointer

  # Ecore Idle Functions
  # http://localhost/ecore/group__Ecore__Idle__Group.html

  # Ecore Throttle functions
  # http://localhost/ecore/group__Ecore__Throttle__Group.html

  attach_function :ecore_throttle_adjust, [:double], :void
  attach_function :ecore_throttle_get, [], :double

  # Ecore Animator functions
  # http://localhost/ecore/group__Ecore__Animator__Group.html

  attach_function :ecore_animator_add, [:ecore_task_cb, :pointer], :pointer
  attach_function :ecore_animator_custom_source_tick_begin_callback_set, [:ecore_cb, :pointer], :void
  attach_function :ecore_animator_custom_source_tick_end_callback_set, [:ecore_cb, :pointer], :void
  attach_function :ecore_animator_custom_tick, [], :void
  attach_function :ecore_animator_del, [:pointer], :pointer
  attach_function :ecore_animator_frametime_get, [], :double
  attach_function :ecore_animator_frametime_set, [:double], :void
  attach_function :ecore_animator_freeze, [:pointer], :void
  attach_function :ecore_animator_pos_map, [:double, EcorePosMap, :double, :double], :double
  attach_function :ecore_animator_source_get, [], EcoreAnimatorSource
  attach_function :ecore_animator_source_set, [EcoreAnimatorSource], :void
  attach_function :ecore_animator_thaw, [:pointer], :void
  attach_function :ecore_animator_timeline_add, [:double, :ecore_timeline_cb, :pointer], :pointer


  callback :task_cb, [:pointer], :pointer
  callback :generic_cb, [:pointer], :pointer
  callback :timeline_cb, [:pointer, :int], :pointer


  # Ecore Application functions
  # http://localhost/ecore/group__Ecore__Application__Group.html

  attach_function :ecore_app_args_get, [:pointer, :pointer], :void
  attach_function :ecore_app_args_set, [:int, :pointer], :void
  attach_function :ecore_app_restart, [], :void

  # Ecore Event functions
  # http://localhost/ecore/group__Ecore__Event__Group.html

  attach_function :ecore_event_add, [:int, :pointer, :ecore_end_cb, :pointer], :pointer
  attach_function :ecore_event_current_event_get, [], :pointer
  attach_function :ecore_event_current_type_get, [], :int
  attach_function :ecore_event_del, [:pointer], :pointer
  attach_function :ecore_event_filter_add, [:ecore_data_cb, :ecore_filter_cb, :ecore_end_cb, :pointer], :pointer
  attach_function :ecore_event_filter_del, [:pointer], :pointer
  attach_function :ecore_event_handler_add, [:int, :ecore_event_handler_cb, :pointer], :pointer
  attach_function :ecore_event_handler_data_get, [:pointer], :pointer
  attach_function :ecore_event_handler_data_set, [:pointer, :pointer], :pointer
  attach_function :ecore_event_handler_del, [:pointer], :pointer
  attach_function :ecore_event_type_new, [], :int


  callback :end_cb, [:pointer, :pointer], :pointer
  callback :data_cb, [:pointer], :pointer
  callback :filter_cb, [:pointer, :pointer, :int, :pointer], :pointer

  callback :ecore_event_handler_cb, [:pointer, :int, :pointer], :int

  
  # Process Spawning Functions
  # http://localhost/ecore/group__Ecore__Exe__Group.html

  attach_function :ecore_exe_auto_limits_set, [:pointer, :int, :int, :int, :int], :void
  attach_function :ecore_exe_callback_pre_free_set, [:pointer, :ecore_exe_cb], :void
  attach_function :ecore_exe_close_stdin, [:pointer], :void
  attach_function :ecore_exe_cmd_get, [:pointer], :pointer
  attach_function :ecore_exe_continue, [:pointer], :void
  attach_function :ecore_exe_data_get, [:pointer], :pointer
  attach_function :ecore_exe_data_set, [:pointer, :pointer], :pointer
  attach_function :ecore_exe_event_data_free, [:pointer], :void
  attach_function :ecore_exe_event_data_get, [:pointer, EcoreExeFlags], :pointer
  attach_function :ecore_exe_flags_get, [:pointer], EcoreExeFlags
  attach_function :ecore_exe_free, [:pointer], :pointer
  attach_function :ecore_exe_hup, [:pointer], :void
  attach_function :ecore_exe_interrupt, [:pointer], :void
  attach_function :ecore_exe_kill, [:pointer], :void
  attach_function :ecore_exe_pause, [:pointer], :void
  attach_function :ecore_exe_pid_get, [:pointer], :uint
  attach_function :ecore_exe_pipe_run, [:pointer, EcoreExeFlags, :pointer], :pointer
  attach_function :ecore_exe_quit, [:pointer], :void
  attach_function :ecore_exe_run, [:pointer, :pointer], :pointer
  attach_function :ecore_exe_run_priority_get, [], :int
  attach_function :ecore_exe_run_priority_set, [:int], :void
  attach_function :ecore_exe_send, [:pointer, :pointer, :int], :bool
  attach_function :ecore_exe_signal, [:pointer, :int], :void
  attach_function :ecore_exe_tag_get, [:pointer], :pointer
  attach_function :ecore_exe_tag_set, [:pointer, :pointer], :void
  attach_function :ecore_exe_terminate, [:pointer], :void


  callback :exe_cb, [:pointer, :pointer], :pointer

  # Ecore Timer functions
  # http://localhost/ecore/group__Ecore__Timer__Group.html

  attach_function :ecore_timer_add, [:double, :ecore_task_cb, :pointer], :pointer
  attach_function :ecore_timer_del, [:pointer], :pointer
  attach_function :ecore_timer_delay, [:pointer, :double], :void
  attach_function :ecore_timer_freeze, [:pointer], :void
  attach_function :ecore_timer_interval_get, [:pointer], :double
  attach_function :ecore_timer_interval_set, [:pointer, :double], :void
  attach_function :ecore_timer_loop_add, [:double, :ecore_task_cb, :pointer], :pointer
  attach_function :ecore_timer_pending_get, [:pointer], :double
  attach_function :ecore_timer_precision_get, [], :double
  attach_function :ecore_timer_precision_set, [:double], :void
  attach_function :ecore_timer_reset, [:pointer], :void
  attach_function :ecore_timer_thaw, [:pointer], :void


  # Ecore Main Loop functions
  # http://localhost/ecore/group__Ecore__Main__Loop__Group.html

  attach_function :ecore_main_fd_handler_active_get, [:pointer, EcoreFdHandlerFlags], :bool
  attach_function :ecore_main_fd_handler_active_set, [:pointer, EcoreFdHandlerFlags], :void
  attach_function :ecore_main_fd_handler_add, [:int, EcoreFdHandlerFlags, :ecore_fd_cb, :pointer, :ecore_fd_cb, :pointer], :pointer
  attach_function :ecore_main_fd_handler_del, [:pointer], :pointer
  attach_function :ecore_main_fd_handler_fd_get, [:pointer], :int
  attach_function :ecore_main_fd_handler_prepare_callback_set, [:pointer, :ecore_fd_prep_cb, :pointer], :void
  attach_function :ecore_main_loop_begin, [], :void
  attach_function :ecore_main_loop_glib_always_integrate_disable, [], :void
  attach_function :ecore_main_loop_glib_integrate, [], :bool
  attach_function :ecore_main_loop_iterate, [], :void
  attach_function :ecore_main_loop_iterate_may_block, [:int], :int
  attach_function :ecore_main_loop_quit, [], :void
  attach_function :ecore_main_loop_select_func_set, [:pointer], :void
  attach_function :ecore_main_loop_thread_safe_call_async, [:ecore_cb, :pointer], :void
  attach_function :ecore_main_loop_thread_safe_call_sync, [:ecore_data_cb, :pointer], :pointer
  attach_function :ecore_thread_main_loop_begin, [], :int
  attach_function :ecore_thread_main_loop_end, [], :int


  callback :fd_prep_cb, [:pointer, :pointer], :pointer
  callback :ecore_select_function, [:int, :pointer, :pointer, :pointer, :pointer], :pointer

  # File Event Handling Functions
  # http://localhost/ecore/group__Ecore__FD__Handler__Group.html

  attach_function :ecore_main_fd_handler_active_get, [:pointer, EcoreFdHandlerFlags], :bool
  attach_function :ecore_main_fd_handler_active_set, [:pointer, EcoreFdHandlerFlags], :void
  attach_function :ecore_main_fd_handler_add, [:int, EcoreFdHandlerFlags, :ecore_fd_cb, :pointer, :ecore_fd_cb, :pointer], :pointer
  attach_function :ecore_main_fd_handler_del, [:pointer], :pointer
  attach_function :ecore_main_fd_handler_fd_get, [:pointer], :int
  attach_function :ecore_main_fd_handler_prepare_callback_set, [:pointer, :ecore_fd_prep_cb, :pointer], :void


  callback :fd_cb, [:pointer, :pointer], :pointer


  # Ecore Idle functions
  # http://localhost/ecore/group__Ecore__Idle__Group.html

  attach_function :ecore_idle_enterer_add, [:ecore_task_cb, :pointer], :pointer
  attach_function :ecore_idle_enterer_before_add, [:ecore_task_cb, :pointer], :pointer
  attach_function :ecore_idle_enterer_del, [:pointer], :pointer
  attach_function :ecore_idle_exiter_add, [:ecore_task_cb, :pointer], :pointer
  attach_function :ecore_idle_exiter_del, [:pointer], :pointer
  attach_function :ecore_idler_add, [:ecore_task_cb, :pointer], :pointer
  attach_function :ecore_idler_del, [:pointer], :pointer




  # Pipe wrapper
  # http://localhost/ecore/group__Ecore__Pipe__Group.html

  attach_function :ecore_pipe_add, [:ecore_pipe_cb, :pointer], :pointer
  attach_function :ecore_pipe_del, [:pointer], :pointer
  attach_function :ecore_pipe_freeze, [:pointer], :void
  attach_function :ecore_pipe_read_close, [:pointer], :void
  attach_function :ecore_pipe_thaw, [:pointer], :void
  attach_function :ecore_pipe_wait, [:pointer, :int, :double], :int
  attach_function :ecore_pipe_write, [:pointer, :pointer, :uint], :bool
  attach_function :ecore_pipe_write_close, [:pointer], :void


  # Ecore Poll functions
  # http://localhost/ecore/group__Ecore__Poller__Group.html

  attach_function :ecore_poller_add, [EcorePollerType, :int, :ecore_task_cb, :pointer], :pointer
  attach_function :ecore_poller_del, [:pointer], :pointer
  attach_function :ecore_poller_poll_interval_get, [EcorePollerType], :double
  attach_function :ecore_poller_poll_interval_set, [EcorePollerType, :double], :void
  attach_function :ecore_poller_poller_interval_get, [:pointer], :int
  attach_function :ecore_poller_poller_interval_set, [:pointer, :int], :bool



  # Ecore Thread functions
  # http://localhost/ecore/group__Ecore__Thread__Group.html

  attach_function :ecore_thread_active_get, [], :int
  attach_function :ecore_thread_available_get, [], :int
  attach_function :ecore_thread_cancel, [:pointer], :bool
  attach_function :ecore_thread_check, [:pointer], :bool
  attach_function :ecore_thread_feedback, [:pointer, :pointer], :bool
  attach_function :ecore_thread_feedback_run, [:ecore_thread_cb, :ecore_thread_notify_cb, :ecore_thread_cb, :ecore_thread_cb, :pointer, :bool], :pointer
  attach_function :ecore_thread_global_data_add, [:pointer, :pointer, :eina_free_cb, :bool], :bool
  attach_function :ecore_thread_global_data_del, [:pointer], :bool
  attach_function :ecore_thread_global_data_find, [:pointer], :pointer
  attach_function :ecore_thread_global_data_set, [:pointer, :pointer, :eina_free_cb], :pointer
  attach_function :ecore_thread_global_data_wait, [:pointer, :double], :pointer
  attach_function :ecore_thread_local_data_add, [:pointer, :pointer, :pointer, :eina_free_cb, :bool], :bool
  attach_function :ecore_thread_local_data_del, [:pointer, :pointer], :bool
  attach_function :ecore_thread_local_data_find, [:pointer, :pointer], :pointer
  attach_function :ecore_thread_local_data_set, [:pointer, :pointer, :pointer, :eina_free_cb], :pointer
  attach_function :ecore_thread_max_get, [], :int
  attach_function :ecore_thread_max_reset, [], :void
  attach_function :ecore_thread_max_set, [:int], :void
  attach_function :ecore_thread_pending_feedback_get, [], :int
  attach_function :ecore_thread_pending_get, [], :int
  attach_function :ecore_thread_pending_total_get, [], :int
  attach_function :ecore_thread_reschedule, [:pointer], :bool
  attach_function :ecore_thread_run, [:ecore_thread_cb, :ecore_thread_cb, :ecore_thread_cb, :pointer], :pointer



  # Ecore Time functions
  # http://localhost/ecore/group__Ecore__Time__Group.html

  attach_function :ecore_loop_time_get, [], :double
  attach_function :ecore_time_get, [], :double
  attach_function :ecore_time_unix_get, [], :double


  callback :ecore_task_cb, [:pointer], :int
end
  
