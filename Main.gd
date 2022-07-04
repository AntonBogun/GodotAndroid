extends Node2D

class player:
	var name=""
	var color=Color()
	var bird=0#0=not playing, 1=basic rules, 2=input bird names, 3=keep track of resources
	# var eliminated=false
	# var time_remaining=0
	# func _init(_name, _color, _time_remaining):
	# 	name = _name
	# 	color = _color
	# 	time_remaining = _time_remaining

var is_android

func _ready():
	is_android = OS.get_name().to_lower() == "android"
	# print(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS,true))
	# print(OS.get_system_dir(OS.SYSTEM_DIR_DCIM,true))
	# print(var2str(player.new()))
	# print(var2str(Color.yellowgreen))
	print(is_android)
	print(get_viewport().get_visible_rect().size)
	_load_data(0)#Players
	_load_data(1)#Time
	_load_data(2)#Bird

func _physics_process(_delta):
	$Screen/Polygon2D.rotate(0.03)

var players=[]

var time_data={
	"Pool":false,
	"Total":1.0,
	"Extra":false,
	"ExtraLim":1.0,
	"ExtraGain":1.0,
	"Turn":1.0,
	"Known":false,
	"Amount":1,
	"Bleed":false,
	"Lose":false,
	"Transition":false,
	"TransitionTime":1.0
}

var bird_data={}

var current_stage=0




#asv file (ඞsv)
func _save_data(_stage):
	if(not is_android):
		return #don't want to deal with desktop
	var file=File.new()
	var dir=Directory.new()
	dir.open("/storage/emulated/0/Documents/")
	if(not dir.dir_exists("Godot")):
		print("creating dir")								#debug
		dir.make_dir("Godot")
	dir.change_dir("Godot")
	if(_stage==0):
		file.open("%s/Players.txt"%dir.get_current_dir(),File.WRITE)
		for i in players:
			file.store_line("%sඞ%sඞ%d"%[i.name,var2str(i.color),i.bird])
		file.close()
	elif(_stage==1):
		file.open("%s/Time.txt"%dir.get_current_dir(),File.WRITE)
		file.store_string(var2str(time_data))
		file.close()

func _load_data(_stage):
	if(not is_android):
		return
	var file=File.new()
	var dir=Directory.new()
	dir.open("/storage/emulated/0/Documents/")
	if(not dir.dir_exists("./Godot")):
		print("no folder")
		return
	dir.change_dir("Godot")

	if(_stage==0):
		if(not dir.file_exists("%s/Players.txt"%dir.get_current_dir())):
			print("no file")
			return
		file.open("%s/Players.txt"%dir.get_current_dir(),File.READ)
		while(not file.eof_reached()):
			var line=file.get_line().split("ඞ")
			if len(line)!=3: 						#!Change when adding new variables
				continue
			# print(line)									#debug
			players.append(player.new())
			players[-1].name=line[0]
			players[-1].color=str2var(line[1])
			players[-1].bird=int(line[2])
		$Screen/Theme/Players._add_and_sync_player_buttons()
		file.close()
	elif(_stage==1):
		if(not dir.file_exists("%s/Time.txt"%dir.get_current_dir())):
			print("no file")
			return
		file.open("%s/Time.txt"%dir.get_current_dir(),File.READ)
		time_data=str2var(file.get_as_text())
		$Screen/Theme/Time._sync_time_data()
		file.close()

	
#current_stage: 0=Player, 1=Time, 2=Bird, 3=Game, 4=Pause, 5=End

func _next():
	# print("switch") #debug
	if(current_stage==0):
		current_stage=1
		$Screen/Theme/Time.visible=true
		_save_data(0)
	elif(current_stage==1):
		current_stage=2
		$Screen/Theme/Bird.visible=true
		_save_data(1)
	elif(current_stage==2):
		current_stage=3
		$Screen/Theme/Game.visible=true
		_save_data(2)
		$Screen/Theme/Game._init_game()
	elif(current_stage==3):
		current_stage=5
		$Screen/Theme/End.visible=true
	elif(current_stage==4):
		current_stage=3
		$Screen/Theme/Game.visible=true
		$Screen/Theme/Game._resume_game()
	elif(current_stage==5):
		current_stage=0
		$Screen/Theme/Players.visible=true

func _prev():
	# print("switch") #debug
	if(current_stage==1):
		current_stage=0
		$Screen/Theme/Players.visible=true
		_save_data(1)
	elif(current_stage==2):
		current_stage=1
		$Screen/Theme/Time.visible=true
		_save_data(2)
	elif(current_stage==3):
		current_stage=4
		$Screen/Theme/Pause.visible=true
	elif(current_stage==4):
		current_stage=0
		$Screen/Theme/Players.visible=true
