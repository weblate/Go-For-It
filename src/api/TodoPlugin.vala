/* Copyright 2015 Manuel Kehl (mank319)
*
* This file is part of Go For It!.
*
* Go For It! is free software: you can redistribute it
* and/or modify it under the terms of version 3 of the 
* GNU General Public License as published by the Free Software Foundation.
*
* Go For It! is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Go For It!. If not, see http://www.gnu.org/licenses/.
*/

using GOFI.Todo;

namespace GOFI.API {
    
    /**
     * A TodoPluginProvider provides a TodoPlugin when it is needed.
     */
    public interface TodoPluginProvider : GLib.Object {
        
        /**
         * Signal that is emited when this gets unloaded.
         */
        public signal void removed (); 
        
        /**
         * Returns the name of this plugin.
         */
        public abstract string get_name ();
        
        /**
         * Returns a new TodoPlugin.
         */
        public abstract TodoPlugin get_plugin (TaskTimer timer);
    }
    
    /**
     * This class is responsible for managing tasks and controlling the 
     * TaskTimer.
     */
    public abstract class TodoPlugin : GLib.Object {
        
        /**
         * TaskTimer for controlling the TimerView in MainLayout.
         */
        protected TaskTimer task_timer;
        
        /**
         * List of menu items to be added to the application menu.
         */
        protected List<Gtk.MenuItem> menu_items;
        
        /**
         * Signal that is emited when there are no tasks left.
         */
        public signal void cleared ();
        
        /**
         * Constructor of TodoPlugin, should always be called by sub classes.
         */
        public TodoPlugin (TaskTimer timer) {
            this.task_timer = timer;
            this.menu_items = new List<Gtk.MenuItem> ();
        }
        
        /**
         * Returns a copy of menu_items.
         */
        public List<Gtk.MenuItem> get_menu_items () {
            return menu_items.copy ();
        }
        
        /**
         * A function called when this TodoPlugin is about to get removed from 
         * the application. Stops all activity and saves all tasks.
         */
        public abstract void stop ();
        
        /**
         * Primary widget showing all tasks that need to be done.
         */
        public abstract Gtk.Widget get_primary_widget (out string page_name);
        
        /**
         * Secondary widget that can be used for things like showing all tasks
         * that have been done.
         */
        public abstract Gtk.Widget get_secondary_widget (out string page_name);
    }
}
