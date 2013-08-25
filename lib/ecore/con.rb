require 'ffi'

module Ecore::Con
  extend FFI::Library
  ffi_lib 'ecore_con'

  EcoreConType = enum(:local_user, :local_system, :local_abstract, :remote_tcp, 
                      :remote_mcast, :remote_udp, :remote_broadcast, :remote_nodelay,
                      :usse_ssl,2, :use_ssl3, :use_tls, :use_mixed, :load_cert) 

  EcoreConUrlTime = enum(:none, :ifmodsince, :ifunmodsince)

  EcoreConUrlHttpVersion = enum(:V1_0, :V1_1)

  callback :ecore_con_dns_cb, [:string, :string, :pointer, :int, :pointer], :void

  # Ecore Connection Library Functions
  # http://localhost/ecore/group__Ecore__Con__Lib__Group.html

  attach_function :ecore_con_init, [], :int
  attach_function :ecore_con_lookup, [:pointer, :ecore_con_dns_cb, :pointer], :bool
  attach_function :ecore_con_shutdown, [], :int

  # Ecore Connection Server Functions
  # http://localhost/ecore/group__Ecore__Con__Server__Group.html

  attach_function :ecore_con_client_fd_get, [:pointer], :int
  attach_function :ecore_con_server_add, [EcoreConType, :pointer, :int, :pointer], :pointer
  attach_function :ecore_con_server_client_limit_set, [:pointer, :int, :char], :void
  attach_function :ecore_con_server_clients_get, [:pointer], :pointer
  attach_function :ecore_con_server_connect, [EcoreConType, :pointer, :int, :pointer], :pointer
  attach_function :ecore_con_server_connected_get, [:pointer], :bool
  attach_function :ecore_con_server_data_get, [:pointer], :pointer
  attach_function :ecore_con_server_data_set, [:pointer, :pointer], :pointer
  attach_function :ecore_con_server_del, [:pointer], :pointer
  attach_function :ecore_con_server_fd_get, [:pointer], :int
  attach_function :ecore_con_server_flush, [:pointer], :void
  attach_function :ecore_con_server_ip_get, [:pointer], :pointer
  attach_function :ecore_con_server_name_get, [:pointer], :pointer
  attach_function :ecore_con_server_port_get, [:pointer], :int
  attach_function :ecore_con_server_send, [:pointer, :pointer, :int], :int
  attach_function :ecore_con_server_timeout_get, [:pointer], :double
  attach_function :ecore_con_server_timeout_set, [:pointer, :double], :void
  attach_function :ecore_con_server_uptime_get, [:pointer], :double



  # Ecore Connection Client Functions
  # http://localhost/ecore/group__Ecore__Con__Client__Group.html

  attach_function :ecore_con_client_connected_get, [:pointer], :bool
  attach_function :ecore_con_client_data_get, [:pointer], :pointer
  attach_function :ecore_con_client_data_set, [:pointer, :pointer], :void
  attach_function :ecore_con_client_del, [:pointer], :pointer
  attach_function :ecore_con_client_fd_get, [:pointer], :int
  attach_function :ecore_con_client_flush, [:pointer], :void
  attach_function :ecore_con_client_ip_get, [:pointer], :pointer
  attach_function :ecore_con_client_port_get, [:pointer], :int
  attach_function :ecore_con_client_send, [:pointer, :pointer, :int], :int
  attach_function :ecore_con_client_server_get, [:pointer], :pointer
  attach_function :ecore_con_client_timeout_get, [:pointer], :double
  attach_function :ecore_con_client_timeout_set, [:pointer, :double], :void
  attach_function :ecore_con_client_uptime_get, [:pointer], :double
  attach_function :ecore_con_server_fd_get, [:pointer], :int
  attach_function :ecore_con_ssl_available_get, [], :int



  # Ecore URL Connection Functions
  # http://localhost/ecore/group__Ecore__Con__Url__Group.html

  attach_function :ecore_con_url_additional_header_add, [:pointer, :pointer, :pointer], :void
  attach_function :ecore_con_url_additional_headers_clear, [:pointer], :void
  attach_function :ecore_con_url_cookies_clear, [:pointer], :void
  attach_function :ecore_con_url_cookies_file_add, [:pointer, :pointer], :void
  attach_function :ecore_con_url_cookies_ignore_old_session_set, [:pointer, :bool], :void
  attach_function :ecore_con_url_cookies_init, [:pointer], :void
  attach_function :ecore_con_url_cookies_jar_file_set, [:pointer, :pointer], :bool
  attach_function :ecore_con_url_cookies_jar_write, [:pointer], :void
  attach_function :ecore_con_url_cookies_session_clear, [:pointer], :void
  attach_function :ecore_con_url_custom_new, [:pointer, :pointer], :pointer
  attach_function :ecore_con_url_data_get, [:pointer], :pointer
  attach_function :ecore_con_url_data_set, [:pointer, :pointer], :void
  attach_function :ecore_con_url_fd_set, [:pointer, :int], :void
  attach_function :ecore_con_url_free, [:pointer], :void
  attach_function :ecore_con_url_ftp_upload, [:pointer, :pointer, :pointer, :pointer, :pointer], :bool
  attach_function :ecore_con_url_ftp_use_epsv_set, [:pointer, :bool], :void
  attach_function :ecore_con_url_get, [:pointer], :bool
  attach_function :ecore_con_url_http_version_set, [:pointer, EcoreConUrlHttpVersion], :bool
  attach_function :ecore_con_url_httpauth_set, [:pointer, :pointer, :pointer, :bool], :bool
  attach_function :ecore_con_url_init, [], :int
  attach_function :ecore_con_url_new, [:pointer], :pointer
  attach_function :ecore_con_url_pipeline_get, [], :bool
  attach_function :ecore_con_url_pipeline_set, [:bool], :void
  attach_function :ecore_con_url_post, [:pointer, :pointer, :long, :pointer], :bool
  attach_function :ecore_con_url_proxy_password_set, [:pointer, :pointer], :bool
  attach_function :ecore_con_url_proxy_set, [:pointer, :pointer], :bool
  attach_function :ecore_con_url_proxy_username_set, [:pointer, :pointer], :bool
  attach_function :ecore_con_url_received_bytes_get, [:pointer], :int
  attach_function :ecore_con_url_response_headers_get, [:pointer], :pointer
  attach_function :ecore_con_url_shutdown, [], :int
  attach_function :ecore_con_url_ssl_ca_set, [:pointer, :pointer], :int
  attach_function :ecore_con_url_ssl_verify_peer_set, [:pointer, :bool], :void
  attach_function :ecore_con_url_status_code_get, [:pointer], :int
  attach_function :ecore_con_url_time, [:pointer, EcoreConUrlTime, :double], :void
  attach_function :ecore_con_url_timeout_set, [:pointer, :double], :void
  attach_function :ecore_con_url_url_get, [:pointer], :pointer
  attach_function :ecore_con_url_url_set, [:pointer, :pointer], :bool
  attach_function :ecore_con_url_verbose_set, [:pointer, :bool], :void



  # Ecore Connection SSL Functions
  # http://localhost/ecore/group__Ecore__Con__SSL__Group.html

  attach_function :ecore_con_ssl_available_get, [], :int
  attach_function :ecore_con_ssl_client_upgrade, [:pointer, EcoreConType], :bool
  attach_function :ecore_con_ssl_server_cafile_add, [:pointer, :pointer], :bool
  attach_function :ecore_con_ssl_server_cert_add, [:pointer, :pointer], :bool
  attach_function :ecore_con_ssl_server_crl_add, [:pointer, :pointer], :bool
  attach_function :ecore_con_ssl_server_privkey_add, [:pointer, :pointer], :bool
  attach_function :ecore_con_ssl_server_upgrade, [:pointer, EcoreConType], :bool
  attach_function :ecore_con_ssl_server_verify, [:pointer], :void
  attach_function :ecore_con_ssl_server_verify_basic, [:pointer], :void
  attach_function :ecore_con_ssl_server_verify_name_get, [:pointer], :pointer
  attach_function :ecore_con_ssl_server_verify_name_set, [:pointer, :pointer], :void

  # Ecore Connection SOCKS functions
  # http://localhost/ecore/group__Ecore__Con__Socks__Group.html

  attach_function :ecore_con_socks4_remote_add, [:pointer, :int, :pointer], :pointer
  attach_function :ecore_con_socks4_remote_del, [:pointer, :int, :pointer], :void
  attach_function :ecore_con_socks4_remote_exists, [:pointer, :int, :pointer], :bool
  attach_function :ecore_con_socks5_remote_add, [:pointer, :int, :pointer, :pointer], :pointer
  attach_function :ecore_con_socks5_remote_del, [:pointer, :int, :pointer, :pointer], :void
  attach_function :ecore_con_socks5_remote_exists, [:pointer, :int, :pointer, :pointer], :bool
  attach_function :ecore_con_socks_apply_always, [:pointer], :void
  attach_function :ecore_con_socks_apply_once, [:pointer], :void
  attach_function :ecore_con_socks_bind_get, [:pointer], :bool
  attach_function :ecore_con_socks_bind_set, [:pointer, :bool], :void
  attach_function :ecore_con_socks_lookup_get, [:pointer], :bool
  attach_function :ecore_con_socks_lookup_set, [:pointer, :bool], :void
  attach_function :ecore_con_socks_remote_del, [:pointer], :void
  attach_function :ecore_con_socks_version_get, [:pointer], :int
end
  
