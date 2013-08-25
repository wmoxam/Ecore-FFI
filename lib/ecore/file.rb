require 'ffi'

module Ecore::File
  extend FFI::Library
  ffi_lib 'ecore_file'

  EcoreFileEvent = enum(:none, :created_file, :created_directory, :deleted_file, :deleted_directory, :deleted_self, :modified, :closed)

  callback :ecore_file_monitor_cb, [:pointer, :pointer, EcoreFileEvent, :string], :void
  callback :ecore_file_download_completion_cb, [:pointer, :string, :int], :void
  callback :ecore_file_download_progress_cb, [:pointer, :string, :long, :long, :long, :long], :void

  # Ecore_File - Files and directories convenience functions
  # http://localhost/ecore/group__Ecore__File__Group.html

  attach_function :ecore_file_app_exe_get, [:pointer], :pointer
  attach_function :ecore_file_app_installed, [:pointer], :bool
  attach_function :ecore_file_app_list, [], :pointer
  attach_function :ecore_file_can_exec, [:pointer], :bool
  attach_function :ecore_file_can_read, [:pointer], :bool
  attach_function :ecore_file_can_write, [:pointer], :bool
  attach_function :ecore_file_cp, [:pointer, :pointer], :bool
  attach_function :ecore_file_dir_get, [:pointer], :pointer
  attach_function :ecore_file_dir_is_empty, [:pointer], :int
  attach_function :ecore_file_download, [:pointer, :pointer, :ecore_file_download_completion_cb, :ecore_file_download_progress_cb, :pointer, :pointer], :bool
  attach_function :ecore_file_download_abort, [:pointer], :void
  attach_function :ecore_file_download_abort_all, [], :void
  attach_function :ecore_file_download_full, [:pointer, :pointer, :ecore_file_download_completion_cb, :ecore_file_download_progress_cb, :pointer, :pointer, :pointer], :bool
  attach_function :ecore_file_download_protocol_available, [:pointer], :bool
  attach_function :ecore_file_escape_name, [:pointer], :pointer
  attach_function :ecore_file_exists, [:pointer], :bool
  attach_function :ecore_file_file_get, [:pointer], :pointer
  attach_function :ecore_file_is_dir, [:pointer], :bool
  attach_function :ecore_file_ls, [:pointer], :pointer
  attach_function :ecore_file_mkdir, [:pointer], :bool
  attach_function :ecore_file_mkdirs, [:pointer], :int
  attach_function :ecore_file_mkpath, [:pointer], :bool
  attach_function :ecore_file_mkpaths, [:pointer], :int
  attach_function :ecore_file_mksubdirs, [:pointer, :pointer], :int
  attach_function :ecore_file_mod_time, [:pointer], :long
  attach_function :ecore_file_monitor_add, [:pointer, :ecore_file_monitor_cb, :pointer], :pointer
  attach_function :ecore_file_monitor_del, [:pointer], :void
  attach_function :ecore_file_monitor_path_get, [:pointer], :pointer
  attach_function :ecore_file_mv, [:pointer, :pointer], :bool
  attach_function :ecore_file_path_dir_exists, [:pointer], :bool
  attach_function :ecore_file_readlink, [:pointer], :pointer
  attach_function :ecore_file_realpath, [:pointer], :pointer
  attach_function :ecore_file_recursive_rm, [:pointer], :bool
  attach_function :ecore_file_remove, [:pointer], :bool
  attach_function :ecore_file_rmdir, [:pointer], :bool
  attach_function :ecore_file_size, [:pointer], :long
  attach_function :ecore_file_strip_ext, [:pointer], :pointer
  attach_function :ecore_file_symlink, [:pointer, :pointer], :bool
  attach_function :ecore_file_unlink, [:pointer], :bool
end
  
