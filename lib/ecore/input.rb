require 'ffi'

module Ecore::Input
  extend FFI::Library
  ffi_lib 'ecore_input'

  ECORE_EVENT_MODIFIER_SHIFT     = 0x0001
  ECORE_EVENT_MODIFIER_CTRL      = 0x0002
  ECORE_EVENT_MODIFIER_ALT       = 0x0004
  ECORE_EVENT_MODIFIER_WIN       = 0x0008
  ECORE_EVENT_MODIFIER_SCROLL    = 0x0010
  ECORE_EVENT_MODIFIER_NUM       = 0x0020
  ECORE_EVENT_MODIFIER_CAPS      = 0x0040
  ECORE_EVENT_LOCK_SCROLL        = 0x0080
  ECORE_EVENT_LOCK_NUM           = 0x0100
  ECORE_EVENT_LOCK_CAPS          = 0x0200
  ECORE_EVENT_LOCK_SHIFT         = 0x0300
  ECORE_EVENT_MODIFIER_ALTGR     = 0x0400

  EcoreEventModifier = enum(:none, :shift, :ctrl, :alt, :win, :scroll, :caps, :mode, :last)
  EcoreEventPress = enum(:down, :up)
  EcoreEventIO = enum(:in, :out)
  EcoreComposeState = enum(:none, :middle, :done)

  class EcoreEventKey < FFI::Struct
    layout  :keyname, :string,
	    :key, :string,
	    :string, :string,
	    :compose, :string,
	    :window, :pointer,
	    :root_window, :pointer,
	    :event_window, :pointer,
	    :timestamp, :uint,
	    :modifiers, :uint,
	    :same_screen, :int
  end

  # TODO
  #
  # struct _Ecore_Event_Key
  #   {
  #      const char      *keyname;
  #      const char      *key;
  #      const char      *string;
  #      const char      *compose;
  #      Ecore_Window     window;
  #      Ecore_Window     root_window;
  #      Ecore_Window     event_window;
  #      
  #      unsigned int     timestamp;
  #      unsigned int     modifiers;
  #      
  #      int              same_screen;
  #   };
  #
  # struct _Ecore_Event_Mouse_Button
  #   {
  #      Ecore_Window     window;
  #      Ecore_Window     root_window;
  #      Ecore_Window     event_window;
  #      
  #      unsigned int     timestamp;
  #      unsigned int     modifiers;
  #      unsigned int     buttons;
  #      unsigned int     double_click;
  #      unsigned int     triple_click;
  #      int              same_screen;
  #      
  #      int              x;
  #      int              y;
  #      struct {
  #           int           x;
  #           int           y;
  #        } root;
  #        
  #        struct {
  #           int           device; /* 0 if normal mouse, 1+ for other mouse-devices (eg multi-touch - other fingers) */
  #           double        radius, radius_x, radius_y; /* radius of press point - radius_x and y if its an ellipse (radius is the average of the 2) */
  #           double        pressure; /* pressure - 1.0 == normal, > 1.0 == more, 0.0 == none */
  #           double        angle; /* angle relative to perpendicular (0.0 == perpendicular), in degrees */
  #           double        x, y; /* same as x, y root.x, root.y, but with sub-pixel precision, if available */
  #           struct {
  #              double     x, y;
  #           } root;
  #        } multi;
  #     };
  #  # 
  #struct _Ecore_Event_Mouse_Wheel
  #     {
  #        Ecore_Window     window;
  #        Ecore_Window     root_window;
  #        Ecore_Window     event_window;
  #        
  #        unsigned int     timestamp;
  #        unsigned int     modifiers;
  #        
  #        int              same_screen;
  #        int              direction;
  #        int              z;
  #        
  #        int              x;
  #        int              y;
  #        struct {
  #           int           x;
  #           int           y;
  #        } root;
  #     };
  #   
  #   struct _Ecore_Event_Mouse_Move
  #     {
  #        Ecore_Window     window;
  #        Ecore_Window     root_window;
  #        Ecore_Window     event_window;
  #        
  #        unsigned int     timestamp;
  #        unsigned int     modifiers;
  #        
  #        int              same_screen;
  #        
  #        int              x;
  #        int              y;
  #        struct {
  #           int           x;
  #           int           y;
  #        } root;
  #        
  #        struct {
  #           int           device; /* 0 if normal mouse, 1+ for other mouse-devices (eg multi-touch - other fingers) */
  #           double        radius, radius_x, radius_y; /* radius of press point - radius_x and y if its an ellipse (radius is the average of the 2) */
  #           double        pressure; /* pressure - 1.0 == normal, > 1.0 == more, 0.0 == none */
  #           double        angle; /* angle relative to perpendicular (0.0 == perpendicular), in degrees */
  #           double        x, y; /* same as x, y root.x, root.y, but with sub-pixel precision, if available */
  #           struct {
  #              double     x, y;
  #           } root;
  #        } multi;
  #     };
  # 

  class EcoreEventMouseIO < FFI::Struct
    layout :window, :pointer,
           :event_window, :pointer,
           :timestamp, :uint,
           :modifiers, :uint,
           :x, :int,
	   :y, :int
  end
  

  attach_function :ecore_event_init, [], :int
  attach_function :ecore_event_shutdown, [], :int
  attach_function :ecore_event_modifier_mask, [EcoreEventModifier], :uint
  attach_function :ecore_event_update_modifier, [:string, :pointer, :int], EcoreEventModifier
  attach_function :ecore_compose_get, [:pointer, :pointer], EcoreComposeState
end
  
