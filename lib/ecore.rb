require 'ffi'

module Ecore
  ECORE_CALLBACK_CANCEL = 0
  ECORE_CALLBACK_RENEW = 1
  ECORE_CALLBACK_PASS_ON = 1
  ECORE_CALLBACK_DONE = 0
  ECORE_EVENT_SIGNAL_USER = 1
  ECORE_EVENT_SIGNAL_HUP = 2
  ECORE_EVENT_SIGNAL_EXIT = 3
  ECORE_EVENT_SIGNAL_POWER = 4
  ECORE_EVENT_SIGNAL_REALTIME = 5

end

require_relative 'ecore/core'
require_relative 'ecore/con'
require_relative 'ecore/evas'
require_relative 'ecore/file'
require_relative 'ecore/imf'
require_relative 'ecore/input'
require_relative 'ecore/ipc'
