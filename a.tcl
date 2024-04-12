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

set g_x 400
set g_y 600
# Goomba Character Image
set goombaCharImg [image create photo -file "images/goomba.png"]
set goombaObj [.myCanvas create image $g_x $g_y -image $goombaCharImg]


# Character Movement Procedure
proc move { obj x y } {
    global m_x m_y keysym
    if {([expr {$m_x + $x}] < 1000) && ([expr {$m_x + $x}] > 30)} {
      .myCanvas move $obj $x $y
      set m_x [expr {$m_x + $x}]
      set m_y [expr {$m_y + $y}]

    }
    set keysym "$m_x and $m_y"
    return
}



# Character Movement Procedure
proc move_g { obj x y } {
    global g_x g_y
    if {([expr {$g_x + $x}] < 1000) && ([expr {$g_x + $x}] > 30)} {
      .myCanvas move $obj $x $y
      set g_x [expr {$g_x + $x}]
      set g_y [expr {$g_y + $y}]

    }
    return
}



# Enemy Follow X
proc follow {obj} {
  global m_x m_y g_x g_y
  set magnitude [expr {$g_x - $m_x}]
  set dx 0
  if {$magnitude > 0} {
    set dx -10
  } elseif {$magnitude < 0} {
    set dx 10
  } else {
    # Lost Game 
  
  set reply [tk_dialog .myCanvas.foo "You Lost" "Do you want to Play Again?" \
        questhead 0 Yes No "I'm not sure"]
  }
  
  move_g $obj $dx 0

}

pack [label .l -textvariable keysym -padx 2m -pady 1m]
set keysym "Press any key"

bind . <Key> {
  set keysym "You pressed %K"    
  set dx 0
  set dy 0
  if {[string equal %K "Up"]} {
    # Jump
    set dy -245
    after 200  { 
      move $marObj $dx $dy
      set dy 245
      after 200 { move $marObj $dx $dy }
    }
    return 
  } elseif {[string equal %K "Down"]} {
    set dy 10
  } elseif {[string equal %K "Right"]} {
    set dx 10
  } elseif {[string equal %K "Left"]} {
    set dx -10
  }
  move $marObj $dx $dy
  follow $goombaObj
}


