#!/usr/bin/env ruby

# Author : Angel Alonso

require 'gosu'
include Gosu

$dimension_x = 1440
$dimension_y = 900
$line_limit = 70

class AppWindow < Window

  def initialize
    super $dimension_x, $dimension_y, true
    self.caption = "Select your area"
	@font = Gosu::Font.new(self, "Arial", 18)
  	@points = []
	@upperleft = [0,0]
	@lowerright = [0,0]
	@step = "before"
  end

  def update
    @points << [ mouse_x, mouse_y ]
    @points.shift if @points.size > $line_limit
  end

  def draw
    if self.button_down?(Gosu::MsLeft)
	  if @step == "before"
	    @step = "onfirstclick"
	  elsif @step == "afterfirstclick"
	    @step = "onsecondclick"
	  end
	end
    if !self.button_down?(Gosu::MsLeft)
	  if @step == "before"
	  elsif @step == "onfirstclick"
	    @upperleft[0],@upperleft[1] = mouse_x.to_i,mouse_y.to_i
		@step = "afterfirstclick"
      elsif @step == "onsecondclick"
        @lowerright[0],@lowerright[1] = mouse_x.to_i,mouse_y.to_i
		@step = "aftersecondclick"
	  elsif @step == "aftersecondclick"
	    if self.button_down?(Gosu::KbReturn)
		  puts "end"
          puts @upperleft
		  puts @lowerright
		  exit
		elsif self.button_down?(Gosu::KbEscape)
		  @step = "before"
		end  
      end
	end
	
  	return if @points.empty?
	@points.inject(@points[0]) do |last, point|
	  if @step == "before"
	    @font.draw(" <c=ff0000>Click on the upper left corner of the area</c>", 10, 10, 1.0, 1.0, 1.0)
	    draw_quad(mouse_x, mouse_y, 0xffffffff, mouse_x + 2, mouse_y, 0xffffffff, mouse_x, mouse_y + 2, 0xffffffff, mouse_x + 2, mouse_y + 2, 0xffffffff, 0)
      elsif @step == "afterfirstclick"
	    @font.draw(" <c=ff0000>Now, click on the lower right corner of the area</c>", 10, 10, 1.0, 1.0, 1.0)
		draw_quad(@upperleft[0], @upperleft[1], 0xffffffff, mouse_x, @upperleft[1], 0xffffffff, @upperleft[0], mouse_y, 0xffffffff, mouse_x, mouse_y, 0xffffffff, 0)
      elsif @step == "aftersecondclick"
	    @font.draw(" <c=ff0000>Press ENTER to confirm, ESCAPE to retry</c>", 100, 100, 1.0, 1.0, 1.0)
		draw_quad(@upperleft[0], @upperleft[1], 0xffffffff, @lowerright[0], @upperleft[1], 0xffffffff, @upperleft[0], @lowerright[1], 0xffffffff, @lowerright[0], @lowerright[1], 0xffffffff, 0)
	  end
	end
	
  end
end

AppWindow.new.show
