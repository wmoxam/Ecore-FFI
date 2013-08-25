require 'ffi'

module Ecore::Imf
  extend FFI::Library
  ffi_lib 'ecore_imf'

  EcoreIMFAutocapitalType = enum(:none, :word, :sentence, :allcharacter)

  EcoreIMFCallbackType = enum(:preedit_start, :preedit_end, :preedit_changed, :commit, :delete_surrounding)

  EcoreIMFEventType = enum(:mouse_down, :mouse_up, :mouse_in, :mousse_out, :mouse_move,
                           :mouse_wheel, :key_down, :key_up)

  EcoreIMFInputPanelLang = enum(:automatic, :alphabetic)

  EcoreIMFInputPanelLayout = enum(:normal, :number, :email, :url, :phonenumber, :ip, :month, :numberonly, :invalid, :hex, :terminal, :password)

  EcoreIMFInputPanelReturnKeyType = enum(:default, :done, :go, :join, :login, :next, :search, :send, :signin)

  EcoreIMFInputMode = enum(:alpha, :numeric, :special, :hexa, :tela, :full, :invisible, :autocap)

  callback :ecore_imf_event_cb, [:pointer, :pointer, :pointer], :void

  # Ecore Input Method Library Functions
  # http://localhost/ecore/group__Ecore__IMF__Lib__Group.html

  attach_function :ecore_imf_init, [], :int
  attach_function :ecore_imf_shutdown, [], :int

  # Ecore Input Method Context Functions
  # http://localhost/ecore/group__Ecore__IMF__Context__Group.html

  attach_function :ecore_imf_context_add, [:pointer], :pointer
  attach_function :ecore_imf_context_autocapital_type_get, [:pointer], EcoreIMFAutocapitalType
  attach_function :ecore_imf_context_autocapital_type_set, [:pointer, EcoreIMFAutocapitalType], :void
  attach_function :ecore_imf_context_available_ids_get, [], :pointer
  attach_function :ecore_imf_context_client_canvas_get, [:pointer], :pointer
  attach_function :ecore_imf_context_client_canvas_set, [:pointer, :pointer], :void
  attach_function :ecore_imf_context_client_window_get, [:pointer], :pointer
  attach_function :ecore_imf_context_client_window_set, [:pointer, :pointer], :void
  attach_function :ecore_imf_context_control_panel_hide, [:pointer], :void
  attach_function :ecore_imf_context_control_panel_show, [:pointer], :void
  attach_function :ecore_imf_context_cursor_location_set, [:pointer, :int, :int, :int, :int], :void
  attach_function :ecore_imf_context_cursor_position_set, [:pointer, :int], :void
  attach_function :ecore_imf_context_default_id_get, [], :pointer
  attach_function :ecore_imf_context_del, [:pointer], :void
  attach_function :ecore_imf_context_event_callback_add, [:pointer, EcoreIMFCallbackType, :ecore_imf_event_cb, :pointer], :void
  attach_function :ecore_imf_context_event_callback_del, [:pointer, EcoreIMFCallbackType, :ecore_imf_event_cb], :pointer
  attach_function :ecore_imf_context_filter_event, [:pointer, EcoreIMFEventType, :pointer], :bool
  attach_function :ecore_imf_context_focus_in, [:pointer], :void
  attach_function :ecore_imf_context_focus_out, [:pointer], :void
  attach_function :ecore_imf_context_hide, [:pointer], :void
  attach_function :ecore_imf_context_info_by_id_get, [:pointer], :pointer
  attach_function :ecore_imf_context_info_get, [:pointer], :pointer
  attach_function :ecore_imf_context_input_mode_get, [:pointer], EcoreIMFInputMode
  attach_function :ecore_imf_context_input_mode_set, [:pointer, EcoreIMFInputMode], :void
  attach_function :ecore_imf_context_input_panel_caps_lock_mode_get, [:pointer], :bool
  attach_function :ecore_imf_context_input_panel_caps_lock_mode_set, [:pointer, :bool], :void
  attach_function :ecore_imf_context_input_panel_enabled_get, [:pointer], :bool
  attach_function :ecore_imf_context_input_panel_enabled_set, [:pointer, :bool], :void
  attach_function :ecore_imf_context_input_panel_hide, [:pointer], :void
  attach_function :ecore_imf_context_input_panel_imdata_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_imf_context_input_panel_imdata_set, [:pointer, :pointer, :int], :void
  attach_function :ecore_imf_context_input_panel_language_get, [:pointer], EcoreIMFInputPanelLang
  attach_function :ecore_imf_context_input_panel_language_set, [:pointer, EcoreIMFInputPanelLang], :void
  attach_function :ecore_imf_context_input_panel_layout_get, [:pointer], EcoreIMFInputPanelLayout
  attach_function :ecore_imf_context_input_panel_layout_set, [:pointer, EcoreIMFInputPanelLayout], :void
  attach_function :ecore_imf_context_input_panel_return_key_disabled_get, [:pointer], :bool
  attach_function :ecore_imf_context_input_panel_return_key_disabled_set, [:pointer, :bool], :void
  attach_function :ecore_imf_context_input_panel_return_key_type_get, [:pointer], EcoreIMFInputPanelReturnKeyType
  attach_function :ecore_imf_context_input_panel_return_key_type_set, [:pointer, EcoreIMFInputPanelReturnKeyType], :void
  attach_function :ecore_imf_context_input_panel_show, [:pointer], :void
  attach_function :ecore_imf_context_prediction_allow_get, [:pointer], :bool
  attach_function :ecore_imf_context_prediction_allow_set, [:pointer, :bool], :void
  attach_function :ecore_imf_context_preedit_string_get, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_imf_context_preedit_string_with_attributes_get, [:pointer, :pointer, :pointer, :pointer], :void
  attach_function :ecore_imf_context_reset, [:pointer], :void
  attach_function :ecore_imf_context_retrieve_surrounding_callback_set, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_imf_context_show, [:pointer], :void
  attach_function :ecore_imf_context_use_preedit_set, [:pointer, :bool], :void



  # Ecore Input Method Context Module Functions
  # http://localhost/ecore/group__Ecore__IMF__Context__Module__Group.html

  attach_function :ecore_imf_context_commit_event_add, [:pointer, :pointer], :void
  attach_function :ecore_imf_context_data_get, [:pointer], :pointer
  attach_function :ecore_imf_context_data_set, [:pointer, :pointer], :void
  attach_function :ecore_imf_context_delete_surrounding_event_add, [:pointer, :int, :int], :void
  attach_function :ecore_imf_context_event_callback_call, [:pointer, EcoreIMFCallbackType, :pointer], :void
  attach_function :ecore_imf_context_new, [:pointer], :pointer
  attach_function :ecore_imf_context_preedit_changed_event_add, [:pointer], :void
  attach_function :ecore_imf_context_preedit_end_event_add, [:pointer], :void
  attach_function :ecore_imf_context_preedit_start_event_add, [:pointer], :void
  attach_function :ecore_imf_context_surrounding_get, [:pointer, :pointer, :pointer], :bool
end
  
require_relative 'imf/evas'
