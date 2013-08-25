require 'ffi'

module Ecore::Ipc
  extend FFI::Library
  ffi_lib 'ecore_ipc'


  EcoreIpcType = enum(:local_user, :local_system, :remote_system, :use_ssl)


  # IPC Library Functions
  # http://localhost/ecore/group__Ecore__IPC__Library__Group.html

  attach_function :ecore_ipc_init, [], :int
  attach_function :ecore_ipc_shutdown, [], :int



  # IPC Server Functions
  # http://localhost/ecore/group__Ecore__IPC__Server__Group.html

  attach_function :ecore_ipc_server_add, [EcoreIpcType, :pointer, :int, :pointer], :pointer
  attach_function :ecore_ipc_server_clients_get, [:pointer], :pointer
  attach_function :ecore_ipc_server_connect, [EcoreIpcType, :pointer, :int, :pointer], :pointer
  attach_function :ecore_ipc_server_connected_get, [:pointer], :bool
  attach_function :ecore_ipc_server_data_get, [:pointer], :pointer
  attach_function :ecore_ipc_server_del, [:pointer], :pointer
  attach_function :ecore_ipc_server_send, [:pointer, :int, :int, :int, :int, :int, :pointer, :int], :int
  attach_function :ecore_ipc_ssl_available_get, [], :int


  # IPC Client Functions
  # http://localhost/ecore/group__Ecore__IPC__Client__Group.html

  attach_function :ecore_ipc_client_data_get, [:pointer], :pointer
  attach_function :ecore_ipc_client_data_set, [:pointer, :pointer], :void
  attach_function :ecore_ipc_client_del, [:pointer], :pointer
  attach_function :ecore_ipc_client_send, [:pointer, :int, :int, :int, :int, :int, :pointer, :int], :int
  attach_function :ecore_ipc_client_server_get, [:pointer], :pointer
end
  
