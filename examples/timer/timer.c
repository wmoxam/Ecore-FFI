// From: http://docs.enlightenment.org/auto/ecore/Ecore_Main_Loop_Page.html

#include <Ecore.h>

Ecore_Timer         *timer1     = NULL;
Ecore_Event_Handler *handler1   = NULL;
double               start_time = 0.0;

int timer_func(void *data)
{
  printf("Tick timer. Sec: %3.2f\n", ecore_time_get() - start_time);
  return 1;
}

int exit_func(void *data, int ev_type, void *ev)
{
  Ecore_Event_Signal_Exit *e;

  e = (Ecore_Event_Signal_Exit *)ev;
  if (e->interrupt)      printf("Exit: interrupt\n");
  else if (e->quit)      printf("Exit: quit\n");
  else if (e->terminate) printf("Exit: terminate\n");
  ecore_main_loop_quit();
  return 1;
}

int main(int argc, const char **argv)
{
  ecore_init();
  ecore_app_args_set(argc, argv);  
  start_time = ecore_time_get();
  handler1 = ecore_event_handler_add(ECORE_EVENT_SIGNAL_EXIT, exit_func, NULL);
  timer1 = ecore_timer_add(0.5, timer_func, NULL);  
  ecore_main_loop_begin();
  ecore_shutdown();
  return 0;
}

