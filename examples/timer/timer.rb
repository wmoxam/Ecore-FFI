#!/usr/bin/ruby

require '../ecore'

TimerCallback = Proc.new do
  puts "Tick timer. Sec: #{'%3.2f' % (Ecore::ecore_time_get - START_TIME)}"
  1
end

ExitCallback = Proc.new do |data, type, ev|
  event = Ecore::EcoreEventSignalExit.new(ev)
  if event[:interrupt]
    puts "Exit: interrupt"
  elsif event[:quit]
    puts "Exit: quit"
  elsif event[:terminate]
    puts "Exit: terminate"
  end
  Ecore::ecore_main_loop_quit()
  1
end

def string_pointers_from_array(array_of_strings)
  strptrs = array_of_strings.collect do |string|
    FFI::MemoryPointer.from_string(string)
  end
  strptrs << nil

  # Now load all the pointers into a native memory block
  array = FFI::MemoryPointer.new(:pointer, strptrs.length)
  strptrs.each_with_index do |p, i|
   array[i].put_pointer(0,  p)
  end
  array
end

Ecore::ecore_init
Ecore::ecore_app_args_set(ARGV.length, string_pointers_from_array(ARGV))
START_TIME = Ecore::ecore_time_get
handler1 = Ecore::ecore_event_handler_add(Ecore::ECORE_EVENT_SIGNAL_EXIT, ExitCallback, nil)
timer1 = Ecore::ecore_timer_add(0.5, TimerCallback, nil)
Ecore::ecore_main_loop_begin
Ecore::ecore_shutdown
