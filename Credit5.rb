require 'rubygems'
require 'gosu'

module ZOrder
   BACKGROUND, MIDDLE, TOP = *0..2
end


#Global Constant:
WIN_WIDTH = 640
WIN_HEIGHT = 400

class DemoWindow < Gosu::Window

#set up variable and attributes
def initialize
   super(WIN_WIDTH, WIN_HEIGHT, false)
   @background = Gosu::Color::RED
   @button_font = Gosu::Font.new(20)
   @info_font = Gosu::Font.new(10)
   @locs = [60,60]
   @x = rand(5..500)
   @y = rand(5..300)
end

#Draw the background, the button with 'click me' text and text
#showing the mouse coordinates

def draw

#Draw background color
   Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, @background, ZOrder::BACKGROUND, mode=:default)
#Draw the button
   Gosu.draw_rect(@x, @y, 100, 50, Gosu::Color::GREEN, ZOrder::MIDDLE, mode=:default)
#Draw the button text
   @button_font.draw("Click me", @x+20, @y+10, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
#Draw the mouse position information
   @info_font.draw_markup("mouse_x: #{@locs[0]}", 0, 350, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
   @info_font.draw_markup("mouse_y: #{@locs[1]}", 0, 370, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

if mouse_x.between?(@x, @x+100) && mouse_y.between?(@y, @y+50)
Gosu.draw_line(@x, @y, Gosu::Color::BLACK, @x+100, @y, Gosu::Color::BLACK, ZOrder::TOP, mode =:default)
Gosu.draw_line(@x, @y+50, Gosu::Color::BLACK, @x+100, @y+50, Gosu::Color::BLACK, ZOrder::TOP, mode =:default)
Gosu.draw_line(@x, @y, Gosu::Color::BLACK, @x, @y+50, Gosu::Color::BLACK, ZOrder::TOP, mode =:default)
Gosu.draw_line(@x+100, @y, Gosu::Color::BLACK, @x+100, @y+50, Gosu::Color::BLACK, ZOrder::TOP, mode =:default)

end

#this is called by gosu to see if it should show the cursor (or mouse)
def needs_cursor?
   true
end

#if the button area (rectangle) is clicked then it will shift to a random position on the screen
# also show the mouse_x and mouse_y coordinates at all times of the cursor on the screen

def mouse_over_button(mouse_x, mouse_y)
   mouse_x.between?(@x, @x+100) && mouse_y.between?(@y, @y+50)
end


def button_down(id)
   case id
   when Gosu::MsLeft
   @x = rand(5..500)
   @y = rand(5..300)
   end
end

def update
   if mouse_over_button(mouse_x, mouse_y)
   @locs = [mouse_x, mouse_y]
   else
   @background = Gosu::Color::RED
   @locs = [mouse_x, mouse_y]
   end
  end
 end
end

DemoWindow.new.show
