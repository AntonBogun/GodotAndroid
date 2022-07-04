extends ReferenceRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main

# Called when the node enters the scene tree for the first time.
func _ready():
	main=find_parent("Main")


func _on_Start_pressed():
	visible=false
	main._next()


func _on_Back_pressed():
	visible=false
	main._prev()
