#!/usr/bin/ruby

'''
Author: Angel Alonso Fonseca
'''

require 'gtk3'
#require 'curses'
#include Curses


class RubyApp < Gtk::Window
    def initialize
        super
    
        set_title "Lock pointer in a box"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        set_default_size 300, 200

        set_window_position Gtk::Window::Position::CENTER

		$winpos = getwinpos().to_s
		label = Gtk::Label.new $winpos
		add label		
		
		show_all
		
		count = 0
		
		while( count < 10 )
			sleep 0.5
			$newwinpos = getwinpos().to_s
			if $newwinpos != $winpos 
				$winpos = $newwinpos
				label.text = $winpos
				print $winpos
			end
		end
		#case getch
		#when KEY_MOUSE
		#	m = getmouse
		#	winx.addstr "Mouse Position: #{m.x} #{m.y} #{m.z}"
		#end
        
    end
	def getwinpos
		require 'Win32API'
 
		getCursorPos = Win32API.new("user32", "GetCursorPos", ['P'], 'V')
		lpPoint = " " * 8 # store two LONGs
		getCursorPos.Call(lpPoint)
		x, y = lpPoint.unpack("LL") # get the actual values
		
		return x, y
	end
end


Gtk.init
    window = RubyApp.new
Gtk.main