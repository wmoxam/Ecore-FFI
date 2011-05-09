require 'ffi'

module Ecore
  extend FFI::Library
  ffi_lib 'ecore'

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

  # Main Loop and Job Functions
  attach_function :ecore_init, [], :int
  attach_function :ecore_shutdown, [], :int

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
  
