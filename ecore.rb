require 'ffi'

module Ecore
  extend FFI::Library
  ffi_lib 'ecore'


  private
  def self.soft_attach(method, *args)
     begin
       attach_function method, *args
     rescue Exception => e
        STDERR.puts "Warning, could not attach #{method} because #{e.message}"
     end
  end

  public
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

  EcorePollerType = enum(:core, 0)

  EcorePosMap = enum(:linear, :accelerate, :decelerate, :sinusoidal,
                     :accelerate_factor, :decelerate_factor,
                     :sinusoidal_factor, :divisor_interp,
                     :bounce, :spring)
  
  EcoreAnimatorSource = enum(:timer, :custom)

  EcoreConType = enum(:local_user, :local_system, :local_abstract, :remote_tcp, 
                      :remote_mcast, :remote_udp, :remote_broadcast, :remote_nodelay,
                      :usse_ssl,2, :use_ssl3, :use_tls, :use_mixed, :load_cert) 

  EcoreConUrlTime = enum(:none, :ifmodsince, :ifunmodsince)

  EcoreConUrlHttpVersion = enum(:V1_0, :V1_1)

  EcoreFbInputDeviceCap = enum(:none, :relative, :absolute, :keys_or_buttons)

  EcoreIMFAutocapitalType = enum(:none, :word, :sentence, :allcharacter)

  EcoreIMFEventType = enum(:mouse_down, :mouse_up, :mouse_in, :mousse_out, :mouse_move,
                           :mouse_wheel, :key_down, :key_up)

  EcoreIMFInputMode = enum(:alpha, :numeric, :special, :hexa, :tela, :full, :invisible, :autocap)

  EcoreIpcType = enum(:local_user, :local_system, :remote_system, :use_ssl)

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
  callback :ecore_select_cb, [:int, :pointer, :pointer, :pointer, :pointer], :int
  callback :eina_free_cb, [:pointer], :pointer

  soft_attach :ecore_init, [], :int
  soft_attach :ecore_shutdown, [], :int
  soft_attach :ecore_pipe_add, [:ecore_pipe_cb, :pointer], :pointer
  soft_attach :ecore_pipe_del, [:pointer], :pointer
  soft_attach :ecore_pipe_read_close, [:pointer], :void
  soft_attach :ecore_pipe_write_close, [:pointer], :void
  soft_attach :ecore_pipe_write, [:pointer, :pointer, :uint], :int

  # Ecore Animator functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Animator__Group.html

  callback :task_cb, [:pointer], :pointer
  callback :generic_cb, [:pointer], :pointer
  callback :timeline_cb, [:pointer, :int], :pointer

  soft_attach :ecore_animator_add, [:task_cb, :pointer], :pointer
  soft_attach :ecore_animator_custom_source_tick_begin_callback_set, [:generic_cb, :pointer], :void
  soft_attach :ecore_animator_custom_source_tick_end_callback_set, [:generic_cb, :pointer], :void
  soft_attach :ecore_animator_custom_tick, [:void], :void
  soft_attach :ecore_animator_del, [:pointer], :pointer
  soft_attach :ecore_animator_frametime_get, [:void], :double
  soft_attach :ecore_animator_frametime_set, [:double], :void
  soft_attach :ecore_animator_freeze, [:pointer], :void
  soft_attach :ecore_animator_pos_map, [:double, EcorePosMap, :double, :double], :double
  soft_attach :ecore_animator_source_get, [:void], EcoreAnimatorSource
  soft_attach :ecore_animator_source_set, [EcoreAnimatorSource], :void
  soft_attach :ecore_animator_thaw, [:pointer], :void
  soft_attach :ecore_animator_timeline_add, [:double, :timeline_cb, :pointer], :pointer


  # Ecore Application functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Application__Group.html

  soft_attach :ecore_app_args_get, [:pointer, :pointer], :void
  soft_attach :ecore_app_restart, [:void], :void
  soft_attach :ecore_app_args_set, [:int, :pointer], :void

  # Ecore Event functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Event__Group.html

  callback :end_cb, [:pointer, :pointer], :pointer
  callback :data_cb, [:pointer], :pointer
  callback :filter_cb, [:pointer, :pointer, :int, :pointer], :pointer

  soft_attach :ecore_event_add, [:int, :pointer, :end_cb, :pointer], :pointer
  soft_attach :ecore_event_current_event_get, [:void], :pointer
  soft_attach :ecore_event_current_type_get, [:void], :int
  soft_attach :ecore_event_del, [:pointer], :pointer
  soft_attach :ecore_event_filter_add, [:data_cb, :filter_cb, :end_cb, :pointer], :pointer
  soft_attach :ecore_event_filter_del, [:pointer], :pointer
  soft_attach :ecore_event_handler_data_get, [:pointer], :pointer
  soft_attach :ecore_event_handler_data_set, [:pointer, :pointer], :pointer
  soft_attach :ecore_event_handler_del, [:pointer], :pointer
  soft_attach :ecore_event_type_new, [:void], :int
  callback :ecore_event_handler_cb, [:pointer, :int, :pointer], :int

  soft_attach :ecore_event_handler_add, [:int, :ecore_event_handler_cb, :pointer], :pointer
  
  # Process Spawning Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Exe__Group.html

  callback :exe_cb, [:pointer, :pointer], :pointer

  soft_attach :ecore_exe_auto_limits_set, [:pointer, :int, :int, :int, :int], :void
  soft_attach :ecore_exe_callback_pre_free_set, [:pointer, :exe_cb], :void
  soft_attach :ecore_exe_close_stdin, [:pointer], :void
  soft_attach :ecore_exe_cmd_get, [:pointer], :pointer
  soft_attach :ecore_exe_continue, [:pointer], :void
  soft_attach :ecore_exe_data_get, [:pointer], :pointer
  soft_attach :ecore_exe_data_set, [:pointer, :pointer], :pointer
  soft_attach :ecore_exe_event_data_free, [:pointer], :void
  soft_attach :ecore_exe_event_data_get, [:pointer, EcoreExeFlags], :pointer
  soft_attach :ecore_exe_flags_get, [:pointer], EcoreExeFlags
  soft_attach :ecore_exe_free, [:pointer], :pointer
  soft_attach :ecore_exe_hup, [:pointer], :void
  soft_attach :ecore_exe_interrupt, [:pointer], :void
  soft_attach :ecore_exe_kill, [:pointer], :void
  soft_attach :ecore_exe_pause, [:pointer], :void
  soft_attach :ecore_exe_pid_get, [:pointer], :int
  soft_attach :ecore_exe_pipe_run, [:pointer, EcoreExeFlags, :pointer], :pointer
  soft_attach :ecore_exe_quit, [:pointer], :void
  soft_attach :ecore_exe_run, [:pointer, :pointer], :pointer
  soft_attach :ecore_exe_run_priority_get, [:void], :int
  soft_attach :ecore_exe_run_priority_set, [:int], :void
  soft_attach :ecore_exe_send, [:pointer, :pointer, :int], :boolean
  soft_attach :ecore_exe_signal, [:pointer, :int], :void
  soft_attach :ecore_exe_tag_get, [:pointer], :pointer
  soft_attach :ecore_exe_tag_set, [:pointer, :pointer], :void
  soft_attach :ecore_exe_terminate, [:pointer], :void

  # Ecore Main Loop functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Main__Loop__Group.html

  callback :fd_prep_cb, [:pointer, :pointer], :pointer

  soft_attach :ecore_main_fd_handler_prepare_callback_set, [:pointer, :fd_prep_cb, :pointer], :void
  soft_attach :ecore_main_loop_select_func_set, [:ecore_select_cb], :void
  soft_attach :ecore_main_loop_begin, [], :void
  soft_attach :ecore_main_loop_quit, [], :void

  # File Event Handling Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FD__Handler__Group.html

  callback :fd_cb, [:pointer, :pointer], :pointer

  soft_attach :ecore_main_fd_handler_active_get, [:pointer, EcoreFdHandlerFlags], :boolean
  soft_attach :ecore_main_fd_handler_active_set, [:pointer, EcoreFdHandlerFlags], :void
  soft_attach :ecore_main_fd_handler_add, [:int, EcoreFdHandlerFlags, :fd_cb, :pointer, :fd_cb, :pointer], :pointer
  soft_attach :ecore_main_fd_handler_del, [:pointer], :pointer
  soft_attach :ecore_main_fd_handler_fd_get, [:pointer], :int

  # Ecore Idle functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Idle__Group.html

  soft_attach :ecore_idle_enterer_add, [:ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_idle_enterer_before_add, [:ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_idle_enterer_del, [:pointer], :pointer
  soft_attach :ecore_idle_exiter_add, [:ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_idle_exiter_del, [:pointer], :pointer
  soft_attach :ecore_idler_add, [:ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_idler_del, [:pointer], :pointer


  # Pipe wrapper
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Pipe__Group.html

  # Ecore Poll functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Poller__Group.html

  soft_attach :ecore_poller_add, [EcorePollerType, :int, :ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_poller_del, [:pointer], :pointer
  soft_attach :ecore_poller_poll_interval_get, [EcorePollerType], :double
  soft_attach :ecore_poller_poll_interval_set, [EcorePollerType, :double], :void
  soft_attach :ecore_poller_poller_interval_get, [:pointer], :int
  soft_attach :ecore_poller_poller_interval_set, [:pointer, :int], :boolean

  # Ecore Thread functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Thread__Group.html

  soft_attach :ecore_thread_active_get, [:void], :int
  soft_attach :ecore_thread_available_get, [:void], :int
  soft_attach :ecore_thread_cancel, [:pointer], :boolean
  soft_attach :ecore_thread_check, [:pointer], :boolean
  soft_attach :ecore_thread_feedback, [:pointer, :pointer], :boolean
  soft_attach :ecore_thread_feedback_run, [:ecore_thread_cb, :ecore_thread_notify_cb, :ecore_thread_cb, :ecore_thread_cb, :pointer, :boolean], :pointer
  soft_attach :ecore_thread_global_data_add, [:pointer, :pointer, :eina_free_cb, :boolean], :boolean
  soft_attach :ecore_thread_global_data_del, [:pointer], :boolean
  soft_attach :ecore_thread_global_data_find, [:pointer], :pointer
  soft_attach :ecore_thread_global_data_set, [:pointer, :pointer, :eina_free_cb], :pointer
  soft_attach :ecore_thread_global_data_wait, [:pointer, :double], :pointer
  soft_attach :ecore_thread_local_data_add, [:pointer, :pointer, :pointer, :eina_free_cb, :boolean], :boolean
  soft_attach :ecore_thread_local_data_del, [:pointer, :pointer], :boolean
  soft_attach :ecore_thread_local_data_find, [:pointer, :pointer], :pointer
  soft_attach :ecore_thread_local_data_set, [:pointer, :pointer, :pointer, :eina_free_cb], :pointer
  soft_attach :ecore_thread_max_get, [:void], :int
  soft_attach :ecore_thread_max_set, [:int], :void
  soft_attach :ecore_thread_pending_feedback_get, [:void], :int
  soft_attach :ecore_thread_pending_get, [:void], :int
  soft_attach :ecore_thread_pending_total_get, [:void], :int
  soft_attach :ecore_thread_reschedule, [:pointer], :boolean
  soft_attach :ecore_thread_run, [:ecore_thread_cb, :ecore_thread_cb, :ecore_thread_cb, :pointer], :pointer

  # Ecore Time functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Time__Group.html

  soft_attach :ecore_loop_time_get, [:void], :double
  soft_attach :ecore_time_unix_get, [:void], :double
  soft_attach :ecore_timer_del, [:pointer], :pointer
  soft_attach :ecore_timer_delay, [:pointer, :double], :void
  soft_attach :ecore_timer_interval_get, [:pointer], :double
  soft_attach :ecore_timer_interval_set, [:pointer, :double], :void
  soft_attach :ecore_timer_loop_add, [:double, :ecore_task_cb, :pointer], :pointer
  soft_attach :ecore_timer_pending_get, [:pointer], :double
  soft_attach :ecore_timer_precision_get, [:void], :double
  soft_attach :ecore_timer_precision_set, [:double], :void
  callback :ecore_task_cb, [:pointer], :int

  soft_attach :ecore_time_get, [], :double
  soft_attach :ecore_timer_add, [:double, :ecore_task_cb, :pointer], :pointer

  # Loop_Group Ecore Main Loop functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Main.html

  soft_attach :ecore_main_fd_handler_active_get, [:pointer, EcoreFdHandlerFlags], :boolean
  soft_attach :ecore_main_fd_handler_active_set, [:pointer, EcoreFdHandlerFlags], :void
  soft_attach :ecore_main_fd_handler_add, [:int, EcoreFdHandlerFlags, :ecore_fd_cb, :pointer, :ecore_fd_cb, :pointer], :pointer
  soft_attach :ecore_main_fd_handler_del, [:pointer], :pointer
  soft_attach :ecore_main_fd_handler_fd_get, [:pointer], :int
  soft_attach :ecore_main_fd_handler_prepare_callback_set, [:pointer, :ecore_fd_prep_cb, :pointer], :void
  soft_attach :ecore_main_loop_glib_always_integrate_disable, [:void], :void
  soft_attach :ecore_main_loop_glib_integrate, [:void], :boolean
  soft_attach :ecore_main_loop_select_func_set, [:ecore_select_cb], :void

  # Ecore Connection Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Lib__Group.html

  soft_attach :ecore_con_init, [:void], :int
  soft_attach :ecore_con_lookup, [:pointer, :ecore_con_dns_cb, :pointer], :boolean
  soft_attach :ecore_con_shutdown, [:void], :int

  # Ecore Connection Server Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Server__Group.html

  soft_attach :ecore_con_server_add, [EcoreConType, :pointer, :int, :pointer], :pointer
  soft_attach :ecore_con_server_client_limit_set, [:pointer, :int, :char], :void
  soft_attach :ecore_con_server_clients_get, [:pointer], :pointer
  soft_attach :ecore_con_server_connect, [EcoreConType, :pointer, :int, :pointer], :pointer
  soft_attach :ecore_con_server_connected_get, [:pointer], :boolean
  soft_attach :ecore_con_server_data_get, [:pointer], :pointer
  soft_attach :ecore_con_server_data_set, [:pointer, :pointer], :pointer
  soft_attach :ecore_con_server_del, [:pointer], :pointer
  soft_attach :ecore_con_server_flush, [:pointer], :void
  soft_attach :ecore_con_server_ip_get, [:pointer], :pointer
  soft_attach :ecore_con_server_name_get, [:pointer], :pointer
  soft_attach :ecore_con_server_port_get, [:pointer], :int
  soft_attach :ecore_con_server_send, [:pointer, :pointer, :int], :int
  soft_attach :ecore_con_server_timeout_get, [:pointer], :double
  soft_attach :ecore_con_server_timeout_set, [:pointer, :double], :void
  soft_attach :ecore_con_server_uptime_get, [:pointer], :double

  # Ecore Connection Client Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Client__Group.html

  soft_attach :ecore_con_client_connected_get, [:pointer], :boolean
  soft_attach :ecore_con_client_data_get, [:pointer], :pointer
  soft_attach :ecore_con_client_data_set, [:pointer, :pointer], :void
  soft_attach :ecore_con_client_del, [:pointer], :pointer
  soft_attach :ecore_con_client_flush, [:pointer], :void
  soft_attach :ecore_con_client_ip_get, [:pointer], :pointer
  soft_attach :ecore_con_client_port_get, [:pointer], :int
  soft_attach :ecore_con_client_send, [:pointer, :pointer, :int], :int
  soft_attach :ecore_con_client_server_get, [:pointer], :pointer
  soft_attach :ecore_con_client_timeout_get, [:pointer], :double
  soft_attach :ecore_con_client_timeout_set, [:pointer, :double], :void
  soft_attach :ecore_con_client_uptime_get, [:pointer], :double
  soft_attach :ecore_con_ssl_available_get, [:void], :int
  soft_attach :ecore_ipc_ssl_available_get, [:void], :int

  # Ecore URL Connection Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__Url__Group.html

  soft_attach :ecore_con_url_additional_header_add, [:pointer, :pointer, :pointer], :void
  soft_attach :ecore_con_url_additional_headers_clear, [:pointer], :void
  soft_attach :ecore_con_url_cookies_clear, [:pointer], :void
  soft_attach :ecore_con_url_cookies_file_add, [:pointer, :pointer], :void
  soft_attach :ecore_con_url_cookies_ignore_old_session_set, [:pointer, :boolean], :void
  soft_attach :ecore_con_url_cookies_init, [:pointer], :void
  soft_attach :ecore_con_url_cookies_jar_file_set, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_url_cookies_jar_write, [:pointer], :void
  soft_attach :ecore_con_url_cookies_session_clear, [:pointer], :void
  soft_attach :ecore_con_url_custom_new, [:pointer, :pointer], :pointer
  soft_attach :ecore_con_url_data_get, [:pointer], :pointer
  soft_attach :ecore_con_url_data_set, [:pointer, :pointer], :void
  soft_attach :ecore_con_url_fd_set, [:pointer, :int], :void
  soft_attach :ecore_con_url_free, [:pointer], :void
  soft_attach :ecore_con_url_ftp_upload, [:pointer, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_con_url_ftp_use_epsv_set, [:pointer, :boolean], :void
  soft_attach :ecore_con_url_get, [:pointer], :boolean
  soft_attach :ecore_con_url_httpauth_set, [:pointer, :pointer, :pointer, :boolean], :boolean
  soft_attach :ecore_con_url_init, [:void], :int
  soft_attach :ecore_con_url_new, [:pointer], :pointer
  soft_attach :ecore_con_url_pipeline_get, [:void], :boolean
  soft_attach :ecore_con_url_pipeline_set, [:boolean], :void
  soft_attach :ecore_con_url_post, [:pointer, :pointer, :long, :pointer], :boolean
  soft_attach :ecore_con_url_received_bytes_get, [:pointer], :int
  soft_attach :ecore_con_url_response_headers_get, [:pointer], :pointer
  soft_attach :ecore_con_url_send, [:pointer, :pointer, :long, :pointer], :boolean
  soft_attach :ecore_con_url_shutdown, [:void], :int
  soft_attach :ecore_con_url_ssl_ca_set, [:pointer, :pointer], :int
  soft_attach :ecore_con_url_ssl_verify_peer_set, [:pointer, :boolean], :void
  soft_attach :ecore_con_url_time, [:pointer, EcoreConUrlTime, :double], :void
  soft_attach :ecore_con_url_url_set, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_url_verbose_set, [:pointer, :boolean], :void

  # Ecore Connection SSL Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Con__SSL__Group.html

  soft_attach :ecore_con_ssl_available_get, [:void], :int
  soft_attach :ecore_con_ssl_server_cafile_add, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_ssl_server_cert_add, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_ssl_server_crl_add, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_ssl_server_privkey_add, [:pointer, :pointer], :boolean
  soft_attach :ecore_con_ssl_server_verify, [:pointer], :void

  # Ecore_FB - Frame buffer convenience functions.
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Group.html

  soft_attach :ecore_fb_callback_gain_set, [:pointer, :pointer], :void
  soft_attach :ecore_fb_callback_lose_set, [:pointer, :pointer], :void
  soft_attach :ecore_fb_init, [:pointer], :int
  soft_attach :ecore_fb_input_device_axis_size_set, [:pointer, :int, :int], :void
  soft_attach :ecore_fb_input_device_cap_get, [:pointer], EcoreFbInputDeviceCap
  soft_attach :ecore_fb_input_device_close, [:pointer], :void
  soft_attach :ecore_fb_input_device_listen, [:pointer, :boolean], :void
  soft_attach :ecore_fb_input_device_name_get, [:pointer], :pointer
  soft_attach :ecore_fb_input_device_open, [:pointer], :pointer
  soft_attach :ecore_fb_input_device_threshold_click_get, [:pointer], :double
  soft_attach :ecore_fb_input_device_threshold_click_set, [:pointer, :double], :void
  soft_attach :ecore_fb_shutdown, [:void], :int
  soft_attach :ecore_fb_size_get, [:pointer, :pointer], :void
  soft_attach :ecore_fb_touch_screen_calibrate_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  soft_attach :ecore_fb_touch_screen_calibrate_set, [:int, :int, :int, :int, :int], :void

  # Framebuffer Double Click Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Click__Group.html

  soft_attach :ecore_fb_double_click_time_get, [:void], :double
  soft_attach :ecore_fb_double_click_time_set, [:double], :void

  # Framebuffer Calibration Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__FB__Calibrate__Group.html

  soft_attach :ecore_fb_touch_screen_calibrate_get, [:pointer, :pointer, :pointer, :pointer, :pointer], :void
  soft_attach :ecore_fb_touch_screen_calibrate_set, [:int, :int, :int, :int, :int], :void

  # Ecore_File - Files and directories convenience functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__File__Group.html

  soft_attach :ecore_file_app_exe_get, [:pointer], :pointer
  soft_attach :ecore_file_app_installed, [:pointer], :boolean
  soft_attach :ecore_file_app_list, [:void], :pointer
  soft_attach :ecore_file_can_exec, [:pointer], :boolean
  soft_attach :ecore_file_can_read, [:pointer], :boolean
  soft_attach :ecore_file_can_write, [:pointer], :boolean
  soft_attach :ecore_file_cp, [:pointer, :pointer], :boolean
  soft_attach :ecore_file_dir_get, [:pointer], :pointer
  soft_attach :ecore_file_dir_is_empty, [:pointer], :int
  soft_attach :ecore_file_download, [:pointer, :pointer, :ecore_file_download_completion_cb, :ecore_file_download_progress_cb, :pointer, :pointer], :boolean
  soft_attach :ecore_file_download_abort, [:pointer], :void
  soft_attach :ecore_file_download_abort_all, [:void], :void
  soft_attach :ecore_file_download_full, [:pointer, :pointer, :ecore_file_download_completion_cb, :ecore_file_download_progress_cb, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_file_download_protocol_available, [:pointer], :boolean
  soft_attach :ecore_file_escape_name, [:pointer], :pointer
  soft_attach :ecore_file_exists, [:pointer], :boolean
  soft_attach :ecore_file_file_get, [:pointer], :pointer
  soft_attach :ecore_file_is_dir, [:pointer], :boolean
  soft_attach :ecore_file_ls, [:pointer], :pointer
  soft_attach :ecore_file_mkdir, [:pointer], :boolean
  soft_attach :ecore_file_mkdirs, [:pointer], :int
  soft_attach :ecore_file_mkpath, [:pointer], :boolean
  soft_attach :ecore_file_mkpaths, [:pointer], :int
  soft_attach :ecore_file_mksubdirs, [:pointer, :pointer], :int
  soft_attach :ecore_file_mod_time, [:pointer], :long
  soft_attach :ecore_file_monitor_add, [:pointer, :ecore_file_monitor_cb, :pointer], :pointer
  soft_attach :ecore_file_monitor_del, [:pointer], :void
  soft_attach :ecore_file_monitor_path_get, [:pointer], :pointer
  soft_attach :ecore_file_mv, [:pointer, :pointer], :boolean
  soft_attach :ecore_file_path_dir_exists, [:pointer], :boolean
  soft_attach :ecore_file_readlink, [:pointer], :pointer
  soft_attach :ecore_file_realpath, [:pointer], :pointer
  soft_attach :ecore_file_recursive_rm, [:pointer], :boolean
  soft_attach :ecore_file_remove, [:pointer], :boolean
  soft_attach :ecore_file_rmdir, [:pointer], :boolean
  soft_attach :ecore_file_size, [:pointer], :long
  soft_attach :ecore_file_strip_ext, [:pointer], :pointer
  soft_attach :ecore_file_symlink, [:pointer, :pointer], :boolean
  soft_attach :ecore_file_unlink, [:pointer], :boolean

  # Ecore Input Method Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Lib__Group.html

  soft_attach :ecore_imf_init, [:void], :int
  soft_attach :ecore_imf_shutdown, [:void], :int

  # Ecore Input Method Context Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Context__Group.html

  soft_attach :ecore_imf_context_add, [:pointer], :pointer
  soft_attach :ecore_imf_context_autocapital_type_get, [:pointer], EcoreIMFAutocapitalType
  soft_attach :ecore_imf_context_autocapital_type_set, [:pointer, EcoreIMFAutocapitalType], :void
  soft_attach :ecore_imf_context_available_ids_get, [:void], :pointer
  soft_attach :ecore_imf_context_client_canvas_get, [:pointer], :pointer
  soft_attach :ecore_imf_context_client_canvas_set, [:pointer, :pointer], :void
  soft_attach :ecore_imf_context_client_window_get, [:pointer], :pointer
  soft_attach :ecore_imf_context_client_window_set, [:pointer, :pointer], :void
  soft_attach :ecore_imf_context_cursor_position_set, [:pointer, :int], :void
  soft_attach :ecore_imf_context_default_id_get, [:void], :pointer
  soft_attach :ecore_imf_context_del, [:pointer], :void
  soft_attach :ecore_imf_context_filter_event, [:pointer, EcoreIMFEventType, :pointer], :boolean
  soft_attach :ecore_imf_context_focus_in, [:pointer], :void
  soft_attach :ecore_imf_context_focus_out, [:pointer], :void
  soft_attach :ecore_imf_context_hide, [:pointer], :void
  soft_attach :ecore_imf_context_info_by_id_get, [:pointer], :pointer
  soft_attach :ecore_imf_context_info_get, [:pointer], :pointer
  soft_attach :ecore_imf_context_input_mode_get, [:pointer], EcoreIMFInputMode
  soft_attach :ecore_imf_context_input_mode_set, [:pointer, EcoreIMFInputMode], :void
  soft_attach :ecore_imf_context_prediction_allow_get, [:pointer], :boolean
  soft_attach :ecore_imf_context_prediction_allow_set, [:pointer, :boolean], :void
  soft_attach :ecore_imf_context_preedit_string_get, [:pointer, :pointer, :pointer], :void
  soft_attach :ecore_imf_context_preedit_string_with_attributes_get, [:pointer, :pointer, :pointer, :pointer], :void
  soft_attach :ecore_imf_context_reset, [:pointer], :void
  soft_attach :ecore_imf_context_retrieve_surrounding_callback_set, [:pointer, :pointer, :pointer], :void
  soft_attach :ecore_imf_context_show, [:pointer], :void
  soft_attach :ecore_imf_context_use_preedit_set, [:pointer, :boolean], :void

  # Ecore Input Method Context Module Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Context__Module__Group.html

  soft_attach :ecore_imf_context_commit_event_add, [:pointer, :pointer], :void
  soft_attach :ecore_imf_context_data_get, [:pointer], :pointer
  soft_attach :ecore_imf_context_data_set, [:pointer, :pointer], :void
  soft_attach :ecore_imf_context_delete_surrounding_event_add, [:pointer, :int, :int], :void
  soft_attach :ecore_imf_context_new, [:pointer], :pointer
  soft_attach :ecore_imf_context_preedit_changed_event_add, [:pointer], :void
  soft_attach :ecore_imf_context_preedit_end_event_add, [:pointer], :void
  soft_attach :ecore_imf_context_preedit_start_event_add, [:pointer], :void
  soft_attach :ecore_imf_context_surrounding_get, [:pointer, :pointer, :pointer], :boolean

  # Ecore Input Method Context Evas Helper Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IMF__Evas__Group.html

  soft_attach :ecore_imf_evas_event_key_down_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_key_up_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_down_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_in_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_move_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_out_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_up_wrap, [:pointer, :pointer], :void
  soft_attach :ecore_imf_evas_event_mouse_wheel_wrap, [:pointer, :pointer], :void

  # IPC Library Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Library__Group.html

  soft_attach :ecore_ipc_init, [:void], :int
  soft_attach :ecore_ipc_shutdown, [:void], :int

  # IPC Server Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Server__Group.html

  soft_attach :ecore_ipc_server_add, [EcoreIpcType, :pointer, :int, :pointer], :pointer
  soft_attach :ecore_ipc_server_clients_get, [:pointer], :pointer
  soft_attach :ecore_ipc_server_connect, [EcoreIpcType, :pointer, :int, :pointer], :pointer
  soft_attach :ecore_ipc_server_connected_get, [:pointer], :boolean
  soft_attach :ecore_ipc_server_data_get, [:pointer], :pointer
  soft_attach :ecore_ipc_server_del, [:pointer], :pointer
  soft_attach :ecore_ipc_server_send, [:pointer, :int, :int, :int, :int, :int, :pointer, :int], :int

  # IPC Client Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__IPC__Client__Group.html

  soft_attach :ecore_ipc_client_data_get, [:pointer], :pointer
  soft_attach :ecore_ipc_client_data_set, [:pointer, :pointer], :void
  soft_attach :ecore_ipc_client_del, [:pointer], :pointer
  soft_attach :ecore_ipc_client_send, [:pointer, :int, :int, :int, :int, :int, :pointer, :int], :int
  soft_attach :ecore_ipc_client_server_get, [:pointer], :pointer

  # X Library Init and Shutdown Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Init__Group.html

  soft_attach :ecore_x_disconnect, [:void], :int
  soft_attach :ecore_x_init, [:pointer], :int
  soft_attach :ecore_x_shutdown, [:void], :int

  # X Display Attributes
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Display__Attr__Group.html

  soft_attach :ecore_x_connection_get, [:void], :pointer
  soft_attach :ecore_x_default_screen_get, [:void], :pointer
  soft_attach :ecore_x_double_click_time_get, [:void], :double
  soft_attach :ecore_x_double_click_time_set, [:double], :void
  soft_attach :ecore_x_fd_get, [:void], :int

  # X Synchronization Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__Xcb__Flush__Group.html

  # XCB Atom Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Atom__Group.html

  soft_attach :ecore_x_atom_get, [:pointer], :int
  soft_attach :ecore_x_atom_get_prefetch, [:pointer], :void
  soft_attach :ecore_x_atom_name_get, [:int], :pointer
  soft_attach :ecore_x_get_atom_name_prefetch, [:int], :void

  # X Composite Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Composite__Group.html

  soft_attach :ecore_x_composite_query, [:void], :boolean

  # X Damage Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Damage__Group.html

  soft_attach :ecore_x_damage_free, [:int], :void
  soft_attach :ecore_x_damage_new, [:int, EcoreXDamageReportLevel], :int
  soft_attach :ecore_x_damage_query, [:void], :boolean
  soft_attach :ecore_x_damage_subtract, [:int, :int, :int], :void

  # X DPMS Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__DPMS__Group.html

  soft_attach :ecore_x_dpms_capable_get, [:void], :boolean
  soft_attach :ecore_x_dpms_enable_get, [:void], :int
  soft_attach :ecore_x_dpms_enabled_get, [:void], :boolean
  soft_attach :ecore_x_dpms_enabled_set, [:int], :void
  soft_attach :ecore_x_dpms_query, [:void], :boolean
  soft_attach :ecore_x_dpms_timeout_off_get, [:void], :int
  soft_attach :ecore_x_dpms_timeout_off_set, [:uint], :void
  soft_attach :ecore_x_dpms_timeout_standby_get, [:void], :int
  soft_attach :ecore_x_dpms_timeout_standby_set, [:uint], :void
  soft_attach :ecore_x_dpms_timeout_suspend_get, [:void], :int
  soft_attach :ecore_x_dpms_timeout_suspend_set, [:uint], :void
  soft_attach :ecore_x_dpms_timeouts_get, [:pointer, :pointer, :pointer], :void
  soft_attach :ecore_x_dpms_timeouts_set, [:uint, :uint, :uint], :boolean

  # X Drawable Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Drawable__Group.html

  soft_attach :ecore_x_drawable_border_width_get, [:int], :int
  soft_attach :ecore_x_drawable_depth_get, [:int], :int
  soft_attach :ecore_x_drawable_geometry_get, [:int, :pointer, :pointer, :pointer, :pointer], :void
  soft_attach :ecore_x_drawable_geometry_get_prefetch, [:int], :void

  # X Fixes Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Fixes__Group.html

  soft_attach :ecore_x_region_combine, [:int, :int, :int], :void
  soft_attach :ecore_x_region_copy, [:int, :int], :void
  soft_attach :ecore_x_region_expand, [:int, :int, :uint, :uint, :uint, :uint], :void
  soft_attach :ecore_x_region_extents, [:int, :int], :void
  soft_attach :ecore_x_region_fetch, [:int, :pointer, :pointer], :pointer
  soft_attach :ecore_x_region_fetch_prefetch, [:int], :void
  soft_attach :ecore_x_region_free, [:int], :void
  soft_attach :ecore_x_region_gc_clip_set, [:int, :int, :int, :int], :void
  soft_attach :ecore_x_region_intersect, [:int, :int, :int], :void
  soft_attach :ecore_x_region_invert, [:int, :pointer, :int], :void
  soft_attach :ecore_x_region_new, [:pointer, :int], :int
  soft_attach :ecore_x_region_new_from_bitmap, [:int], :int
  soft_attach :ecore_x_region_new_from_gc, [:int], :int
  soft_attach :ecore_x_region_new_from_picture, [:int], :int
  soft_attach :ecore_x_region_new_from_window, [:int, :intType], :int
  soft_attach :ecore_x_region_picture_clip_set, [:int, :int, :int, :int], :void
  soft_attach :ecore_x_region_set, [:int, :pointer, :int], :void
  soft_attach :ecore_x_region_subtract, [:int, :int, :int], :void
  soft_attach :ecore_x_region_translate, [:int, :int, :int], :void
  soft_attach :ecore_x_region_window_shape_set, [:int, :int, EcoreXShapeType, :int, :int], :void
  soft_attach :ecore_x_xfixes_query, [:void], :int

  # ICCCM related functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__ICCCM__Group.html

  soft_attach :ecore_x_icccm_client_leader_get, [:int], :int
  soft_attach :ecore_x_icccm_client_leader_get_prefetch, [:int], :void
  soft_attach :ecore_x_icccm_client_leader_set, [:int, :int], :void
  soft_attach :ecore_x_icccm_client_machine_get, [:int], :pointer
  soft_attach :ecore_x_icccm_colormap_window_set, [:int, :int], :void
  soft_attach :ecore_x_icccm_colormap_window_unset, [:int, :int], :void
  soft_attach :ecore_x_icccm_command_get, [:int, :pointer, :pointer], :void
  soft_attach :ecore_x_icccm_command_set, [:int, :int, :pointer], :void
  soft_attach :ecore_x_icccm_delete_window_send, [:int, :int], :void
  soft_attach :ecore_x_icccm_hints_get, [:int, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_icccm_hints_set, [:int, :boolean, :intStateHint, :int, :int, :int, :int, :boolean], :void
  soft_attach :ecore_x_icccm_icon_name_get, [:int], :pointer
  soft_attach :ecore_x_icccm_icon_name_set, [:int, :pointer], :void
  soft_attach :ecore_x_icccm_iconic_request_send, [:int, :int], :void
  soft_attach :ecore_x_icccm_move_resize_send, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_icccm_name_class_get, [:int, :pointer, :pointer], :void
  soft_attach :ecore_x_icccm_name_class_set, [:int, :pointer, :pointer], :void
  soft_attach :ecore_x_icccm_protocol_isset, [:int, EcoreXWMProtocol], :boolean
  soft_attach :ecore_x_icccm_protocol_set, [:int, EcoreXWMProtocol, :boolean], :void
  soft_attach :ecore_x_icccm_save_yourself_send, [:int, :int], :void
  soft_attach :ecore_x_icccm_size_pos_hints_get, [:int, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_icccm_size_pos_hints_set, [:int, :boolean, EcoreXGravity, :int, :int, :int, :int, :int, :int, :int, :int, :double, :double], :void
  soft_attach :ecore_x_icccm_state_get, [:int], :intStateHint
  soft_attach :ecore_x_icccm_state_set, [:int, :intStateHint], :void
  soft_attach :ecore_x_icccm_take_focus_send, [:int, :int], :void
  soft_attach :ecore_x_icccm_title_get, [:int], :pointer
  soft_attach :ecore_x_icccm_title_set, [:int, :pointer], :void
  soft_attach :ecore_x_icccm_transient_for_get, [:int], :int
  soft_attach :ecore_x_icccm_transient_for_set, [:int, :int], :void
  soft_attach :ecore_x_icccm_transient_for_unset, [:int], :void
  soft_attach :ecore_x_icccm_window_role_get, [:int], :pointer
  soft_attach :ecore_x_icccm_window_role_get_prefetch, [:int], :void
  soft_attach :ecore_x_icccm_window_role_set, [:int, :pointer], :void

  # MWM related functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__MWM__Group.html

  soft_attach :ecore_x_mwm_borderless_set, [:int, :boolean], :void
  soft_attach :ecore_x_mwm_hints_get, [:int, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_mwm_hints_get_prefetch, [:int], :void

  # Extended Window Manager Hint (EWMH) functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__NetWM__Group.html

  soft_attach :ecore_x_netwm_allowed_action_get, [:int, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_allowed_action_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_allowed_action_isset, [:int, EcoreXAction], :boolean
  soft_attach :ecore_x_netwm_allowed_action_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_client_active_set, [:int, :int], :void
  soft_attach :ecore_x_netwm_client_list_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_client_list_stacking_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_desk_count_set, [:int, :uint], :void
  soft_attach :ecore_x_netwm_desk_current_set, [:int, :uint], :void
  soft_attach :ecore_x_netwm_desk_layout_set, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_netwm_desk_names_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_desk_roots_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_desk_size_set, [:int, :uint, :uint], :void
  soft_attach :ecore_x_netwm_desk_viewports_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_desk_workareas_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_desktop_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_desktop_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_desktop_request_send, [:int, :int, :uint], :void
  soft_attach :ecore_x_netwm_desktop_set, [:int, :uint], :void
  soft_attach :ecore_x_netwm_frame_size_get, [:int, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_frame_size_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_frame_size_set, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_netwm_handled_icons_get, [:int], :boolean
  soft_attach :ecore_x_netwm_handled_icons_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_handled_icons_set, [:int], :void
  soft_attach :ecore_x_netwm_icon_geometry_get, [:int, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_icon_geometry_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_icon_geometry_set, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_netwm_icon_name_get, [:int, :pointer], :int
  soft_attach :ecore_x_netwm_icon_name_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_icon_name_set, [:int, :pointer], :void
  soft_attach :ecore_x_netwm_icons_get, [:int, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_icons_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_name_get, [:int, :pointer], :int
  soft_attach :ecore_x_netwm_name_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_name_set, [:int, :pointer], :void
  soft_attach :ecore_x_netwm_opacity_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_opacity_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_opacity_set, [:int, :uint], :void
  soft_attach :ecore_x_netwm_pid_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_pid_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_pid_set, [:int, :int], :void
  soft_attach :ecore_x_netwm_ping_send, [:int], :void
  soft_attach :ecore_x_netwm_showing_desktop_set, [:int, :boolean], :void
  soft_attach :ecore_x_netwm_startup_id_get, [:int, :pointer], :int
  soft_attach :ecore_x_netwm_startup_id_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_startup_id_set, [:int, :pointer], :void
  soft_attach :ecore_x_netwm_state_request_send, [:int, :int, EcoreXWindowState, EcoreXWindowState, :boolean], :void
  soft_attach :ecore_x_netwm_strut_get, [:int, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_strut_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_strut_partial_get, [:int, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_strut_partial_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_strut_partial_set, [:int, :int, :int, :int, :int, :int, :int, :int, :int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_netwm_strut_set, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_netwm_supported_get, [:int, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_supported_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_supported_set, [:int, :pointer, :int], :void
  soft_attach :ecore_x_netwm_sync_counter_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_sync_counter_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_sync_request_send, [:int, :uint], :void
  soft_attach :ecore_x_netwm_user_time_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_user_time_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_user_time_set, [:int, :uint], :void
  soft_attach :ecore_x_netwm_visible_icon_name_get, [:int, :pointer], :int
  soft_attach :ecore_x_netwm_visible_icon_name_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_visible_icon_name_set, [:int, :pointer], :void
  soft_attach :ecore_x_netwm_visible_name_get, [:int, :pointer], :int
  soft_attach :ecore_x_netwm_visible_name_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_visible_name_set, [:int, :pointer], :void
  soft_attach :ecore_x_netwm_window_state_get, [:int, :pointer, :pointer], :boolean
  soft_attach :ecore_x_netwm_window_state_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_window_state_set, [:int, :pointer, :uint], :void
  soft_attach :ecore_x_netwm_window_type_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_netwm_window_type_get_prefetch, [:int], :void
  soft_attach :ecore_x_netwm_window_type_set, [:int, EcoreXWindowType], :void
  soft_attach :ecore_x_netwm_wm_identify, [:int, :int, :pointer], :void
  soft_attach :ecore_x_screen_is_composited, [:int], :boolean

  # X Pixmap Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__RandR__Group.html

  soft_attach :ecore_x_randr_get_screen_info_prefetch, [:int], :void
  soft_attach :ecore_x_randr_query, [:void], :boolean

  # X RandR Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__RandR__Group.html

  soft_attach :ecore_x_randr_get_screen_info_prefetch, [:int], :void
  soft_attach :ecore_x_randr_query, [:void], :boolean

  # X ScreenSaver extension
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__ScreenSaver__Group.html

  soft_attach :ecore_x_screensaver_blank_get, [:void], :int
  soft_attach :ecore_x_screensaver_blank_set, [:int], :void
  soft_attach :ecore_x_screensaver_event_available_get, [:void], :boolean
  soft_attach :ecore_x_screensaver_event_listen_set, [:boolean], :void
  soft_attach :ecore_x_screensaver_expose_get, [:void], :int
  soft_attach :ecore_x_screensaver_expose_set, [:int], :void
  soft_attach :ecore_x_screensaver_idle_time_get, [:void], :int
  soft_attach :ecore_x_screensaver_interval_get, [:void], :int
  soft_attach :ecore_x_screensaver_interval_set, [:int], :void
  soft_attach :ecore_x_screensaver_set, [:int, :int, :int, :int], :void
  soft_attach :ecore_x_screensaver_timeout_get, [:void], :int
  soft_attach :ecore_x_screensaver_timeout_set, [:int], :void

  # X Shape extension
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Shape__Group.html

  soft_attach :ecore_x_window_shape_mask_set, [:int, :int], :void
  soft_attach :ecore_x_window_shape_rectangle_set, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_window_shape_rectangles_get, [:int, :pointer], :pointer
  soft_attach :ecore_x_window_shape_rectangles_get_prefetch, [:int], :void

  # X Sync Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Sync__Group.html

  soft_attach :ecore_x_sync_alarm_free, [:int], :boolean
  soft_attach :ecore_x_sync_alarm_new, [:int], :int
  soft_attach :ecore_x_sync_query, [:void], :boolean

  # X Window Creation Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Create__Group.html

  soft_attach :ecore_x_window_argb_new, [:int, :int, :int, :int, :int], :int
  soft_attach :ecore_x_window_input_new, [:int, :int, :int, :int, :int], :int
  soft_attach :ecore_x_window_manager_argb_new, [:int, :int, :int, :int, :int], :int
  soft_attach :ecore_x_window_new, [:int, :int, :int, :int, :int], :int
  soft_attach :ecore_x_window_override_argb_new, [:int, :int, :int, :int, :int], :int
  soft_attach :ecore_x_window_override_new, [:int, :int, :int, :int, :int], :int

  # X Window Destroy Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Destroy__Group.html

  soft_attach :ecore_x_window_delete_request_send, [:int], :void
  soft_attach :ecore_x_window_free, [:int], :void

  # X Window Configure Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Configure__Group.html

  soft_attach :ecore_x_window_border_width_set, [:int, :int], :void
  soft_attach :ecore_x_window_configure, [:int, EcoreXWindowConfigureMask, :int, :int, :int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_window_lower, [:int], :void
  soft_attach :ecore_x_window_move, [:int, :int, :int], :void
  soft_attach :ecore_x_window_move_resize, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_window_raise, [:int], :void
  soft_attach :ecore_x_window_resize, [:int, :int, :int], :void

  # X Window Visibility Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Visibility__Group.html

  soft_attach :ecore_x_window_hide, [:int], :void
  soft_attach :ecore_x_window_show, [:int], :void
  soft_attach :ecore_x_window_visible_get, [:int], :int

  # X Window Input Focus Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Input__Focus__Group.html

  soft_attach :ecore_x_window_focus, [:int], :void
  soft_attach :ecore_x_window_focus_at_time, [:int, :int], :void
  soft_attach :ecore_x_window_focus_get, [:void], :int

  # X Window Reparent Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Reparent__Group.html

  soft_attach :ecore_x_window_reparent, [:int, :int, :int, :int], :void

  # X Window Change Attributes Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Change__Attributes__Group.html

  soft_attach :ecore_x_window_background_color_set, [:int, :ushort, :ushort, :ushort], :void
  soft_attach :ecore_x_window_client_manage, [:int], :void
  soft_attach :ecore_x_window_client_sniff, [:int], :void
  soft_attach :ecore_x_window_container_manage, [:int], :void
  soft_attach :ecore_x_window_cursor_set, [:int, :int], :void
  soft_attach :ecore_x_window_cursor_show, [:int, :boolean], :void
  soft_attach :ecore_x_window_gravity_set, [:int, EcoreXGravity], :void
  soft_attach :ecore_x_window_override_set, [:int, :boolean], :void
  soft_attach :ecore_x_window_pixel_gravity_set, [:int, EcoreXGravity], :void
  soft_attach :ecore_x_window_pixmap_set, [:int, :int], :void
  soft_attach :ecore_x_window_sniff, [:int], :void

  # X Window Change Save Set Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Save__Set__Group.html

  soft_attach :ecore_x_window_save_set_add, [:int], :void
  soft_attach :ecore_x_window_save_set_del, [:int], :void

  # X Window Get Attributes Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Get__Attributes__Group.html

  soft_attach :ecore_x_window_attributes_get, [:int, :pointer], :boolean
  soft_attach :ecore_x_window_visible_get, [:int], :int

  # X Window Geometry Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Geometry__Group.html

  soft_attach :ecore_x_window_at_xy_begin_get, [:int, :int, :int], :int
  soft_attach :ecore_x_window_at_xy_get, [:int, :int], :int
  soft_attach :ecore_x_window_at_xy_with_skip_get, [:int, :int, :pointer, :int], :int
  soft_attach :ecore_x_window_border_width_get, [:int], :int
  soft_attach :ecore_x_window_border_width_set, [:int, :int], :void
  soft_attach :ecore_x_window_geometry_get, [:int, :pointer, :pointer, :pointer, :pointer], :void
  soft_attach :ecore_x_window_move, [:int, :int, :int], :void
  soft_attach :ecore_x_window_move_resize, [:int, :int, :int, :int, :int], :void
  soft_attach :ecore_x_window_resize, [:int, :int, :int], :void
  soft_attach :ecore_x_window_root_get, [:int], :int
  soft_attach :ecore_x_window_shadow_parent_get, [:int, :int], :int
  soft_attach :ecore_x_window_shadow_tree_at_xy_with_skip_get, [:int, :int, :int, :pointer, :int], :int
  soft_attach :ecore_x_window_size_get, [:int, :pointer, :pointer], :void

  # X Xinerama Extension Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Xinerama__Group.html

  soft_attach :ecore_x_xinerama_query, [:void], :boolean
  soft_attach :ecore_x_xinerama_screen_count_get, [:void], :int
  soft_attach :ecore_x_xinerama_screen_geometry_get, [:int, :pointer, :pointer, :pointer, :pointer], :boolean

  # X Library Init and Shutdown Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Init__Group.html

  soft_attach :ecore_x_disconnect, [:void], :int
  soft_attach :ecore_x_init, [:pointer], :int
  soft_attach :ecore_x_shutdown, [:void], :int

  # X Display Attributes
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Display__Attr__Group.html

  soft_attach :ecore_x_default_screen_get, [:void], :pointer
  soft_attach :ecore_x_display_get, [:void], :pointer
  soft_attach :ecore_x_double_click_time_get, [:void], :double
  soft_attach :ecore_x_double_click_time_set, [:double], :void
  soft_attach :ecore_x_fd_get, [:void], :int

  # X Synchronization Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Flush__Group.html

  # X Window Focus Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Focus__Functions.html

  soft_attach :ecore_x_window_focus, [:int], :void
  soft_attach :ecore_x_window_focus_at_time, [:int, :int], :void
  soft_attach :ecore_x_window_focus_get, [:void], :int

  # X Window Z Order Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Z__Order__Group.html

  soft_attach :ecore_x_window_lower, [:int], :void
  soft_attach :ecore_x_window_raise, [:int], :void

  # X Window Parent Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Parent__Group.html

  soft_attach :ecore_x_pointer_xy_get, [:int, :pointer, :pointer], :void
  soft_attach :ecore_x_window_children_get, [:int, :pointer], :pointer
  soft_attach :ecore_x_window_parent_get, [:int], :int
  soft_attach :ecore_x_window_reparent, [:int, :int, :int, :int], :void

  # X Window Shape Functions
  # http://docs.enlightenment.org/auto/ecore/group__Ecore__X__Window__Shape.html

  soft_attach :ecore_x_window_shape_input_mask_set, [:int, :int], :void
  soft_attach :ecore_x_window_shape_mask_set, [:int, :int], :void
end
  
