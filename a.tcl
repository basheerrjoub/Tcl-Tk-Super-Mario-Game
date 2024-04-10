#!/usr/bin/wish
package require Tk

wm title . "Super Mario"
canvas .myCanvas -width 1024 -height 720

# Background Image
set img [image create photo -file "images/background.png"]
pack .myCanvas -expand yes -fill both
.myCanvas create image 10 10 -anchor nw -image $img


# Mario starting Position
set m_x 50
set m_y 600

# Mario Character Image
set marioCharImg [image create photo -file "images/mario_char.png"]
set marObj [.myCanvas create image $m_x $m_y -image $marioCharImg]

# Character Movement Procedure
proc move { obj x y } {
    .myCanvas move $obj $x $y
}

pack [label .l -textvariable keysym -padx 2m -pady 1m]
set keysym "Press any key"

bind . <Key> {
  set keysym "You pressed %K"    
  set dx 0
  set dy 0
  if {[string equal %K "Up"]} {
    set dy -10
  } elseif {[string equal %K "Down"]} {
    set dy 10
  } elseif {[string equal %K "Right"]} {
    set dx 10
  } elseif {[string equal %K "Left"]} {
    set dx -10
  }
  move $marObj $dx $dy 
}
