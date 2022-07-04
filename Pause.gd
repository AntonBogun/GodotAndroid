extends ReferenceRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var main
var colrect
var default_col=Color(77.0/255,77.0/255,77.0/255)

func _ready():
	main=find_parent("Main")
	colrect=main.find_node("Color")


func _set_labels(playername,time):
	$LastPlayer.text=playername
	$TimeLeft.text=time

func _on_Unpause_pressed():
	visible=false
	main._next()

func _on_End_pressed():
	visible=false
	colrect.color=default_col
	main._prev()
