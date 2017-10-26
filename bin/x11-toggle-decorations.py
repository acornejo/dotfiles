#!/usr/bin/env python

import gtk.gdk

WM_ACTIVE = "_NET_ACTIVE_WINDOW"

def get_active_window():
  window_id = gtk.gdk.get_default_root_window().property_get(WM_ACTIVE)[2][0]
  return gtk.gdk.window_foreign_new(window_id)

def toggle_decorations(window):
  active = window.get_decorations()
  if active != gtk.gdk.WMDecoration(2):
    active = gtk.gdk.WMDecoration(2)
  else:
    active = gtk.gdk.WMDecoration(1)
  print active
  window.set_decorations(active)
  gtk.gdk.window_process_all_updates()
  gtk.gdk.flush()

if __name__ == "__main__":
  window = get_active_window()
  if window is None:
    print "No active window!"
  else:
    toggle_decorations(window)

