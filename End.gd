extends ReferenceRect


var main
var colrect
var default_col=Color(77.0/255,77.0/255,77.0/255)


func _ready():
	main=find_parent("Main")
	colrect=main.find_node("Color")


func _set_label(playername,is_player=true):
	$WinLabel.visible=true
	$WinPlayer.visible=true
	if is_player:
		$WinPlayer.text=playername
	else:
		$WinLabel.visible=false
		$WinPlayer.visible=false
		# colrect.color=default_col #WHYY??? #nvm had to return after _end_game()

func _on_Back_pressed():
	visible=false
	colrect.color=default_col
	main._next()
