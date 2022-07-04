extends ReferenceRect


var main
var colrect
var default_col=Color(77.0/255,77.0/255,77.0/255)
var rng
func _ready():
	main=find_parent("Main")
	colrect=get_node("../Color")
	rng=RandomNumberGenerator.new()
	rng.randomize()
var current_index=-1


func _new_player_button():
	var new_button=Button.new()
	new_button.rect_min_size=$Scroll/Container/New.rect_min_size
	$Scroll/Container.add_child(new_button)
	$Scroll/Container.move_child(new_button,$Scroll/Container/New.get_position_in_parent())
	new_button.toggle_mode=true
	new_button.set_script(load("PlayerButton.gd"))
	new_button.connect("toggled_with_reference",self,"_on_player_toggled")
	return new_button

func _on_New_pressed():
	if current_index!=-1:
		$Scroll/Container.get_child(current_index).pressed=false
	main.players.push_back(main.player.new())
	var size=main.players.size()
	var new_button=_new_player_button()
	new_button.text="%d"%size
	main.players[size-1].name="%d"%size
	new_button.pressed=true
		
func _on_player_toggled(button):
	var state=button.pressed
	if current_index!=-1 and state:
		$Scroll/Container.get_child(current_index).pressed=false
	if state:
		var index=button.get_position_in_parent()
		current_index=index
		$Edit.visible=true
		$Edit/ColorPicker.color=main.players[index].color
		colrect.color=main.players[index].color
		$Edit/Name.text=main.players[index].name
		$Edit/Bird.selected=main.players[index].bird
	else:
		$Edit.visible=false
		colrect.color=default_col
		current_index=-1

func _add_and_sync_player_buttons():
	var size=main.players.size()
	for i in range(size):
		var button=_new_player_button()
		button.text=main.players[i].name
		


func _on_Continue_pressed():
	var all_non_empty=len(main.players)>0
	for i in range(main.players.size()):
		if main.players[i].name.strip_edges()=="":
			all_non_empty=false
			print("bad %d"%i)
			break
	if all_non_empty:
		$Error.visible=false
		if(current_index!=-1):
			$Scroll/Container.get_child(current_index).pressed=false
		visible=false
		main._next()
	else:
		$Error.visible=true


func _on_ColorPicker_color_changed(color):
	main.players[current_index].color=color
	colrect.color=color

func _on_Random_pressed():
	var col=DefaultCols.cols[rng.randi_range(0,DefaultCols.cols.size()-1)]
	$Edit/ColorPicker.color=col
	main.players[current_index].color=col
	colrect.color=col


func _on_Name_text_changed():
	main.players[current_index].name=$Edit/Name.text
	$Scroll/Container.get_child(current_index).text=$Edit/Name.text

func _on_Up_pressed():
	if current_index>0:
		$Scroll/Container.move_child($Scroll/Container.get_child(current_index),current_index-1)
		var temp=main.players[current_index-1]
		main.players[current_index-1]=main.players[current_index]
		main.players[current_index]=temp
		current_index-=1


func _on_Down_pressed():
	if current_index<main.players.size()-1:
		$Scroll/Container.move_child($Scroll/Container.get_child(current_index),current_index+1)
		var temp=main.players[current_index+1]
		main.players[current_index+1]=main.players[current_index]
		main.players[current_index]=temp
		current_index+=1

func _on_Bird_item_selected(index:int):
	main.players[current_index].bird=index






func _on_Delete_pressed():
	$Scroll/Container.get_child(current_index).queue_free()
	main.players.remove(current_index)
	current_index=-1
	$Edit.visible=false
	colrect.color=default_col

