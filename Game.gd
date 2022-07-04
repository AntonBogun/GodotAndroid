extends ReferenceRect



var main
var colrect
var default_col=Color(77.0/255,77.0/255,77.0/255)
var player_status_text="Current player:"
var player_button_text="Finish turn"
var player_total_status_str="Turns left:"
var player_bleeding_text="Next turn time:"
var transition_status_text="Pass the phone to player:"
var transition_button_text="Start"
var transition_total_text="Next player time:"
var default_text_color=Color(1.0,1.0,1.0)

func _do_nothing():
	pass
var exec_at_end
var exec_at_force_end

func _ready():
	main=find_parent("Main")
	exec_at_end=funcref(self,"_do_nothing")
	colrect=main.find_node("Color")




var can_end=true
var ticks=0
var label_offset=0 #offset ticks shown on time label
var total_offset=0 #only relevant when not (pool:false, known:false)
var update_total=false
var _default_total_func=funcref(self,"__default_total_func")#god please forgive me
var total_func

func _add_interval(_ticks,_label_offset=0,_can_end=true,_update_total=false,_total_offset=0,_total_func=_default_total_func):
	ticks=_ticks
	label_offset=_label_offset
	can_end=_can_end
	update_total=_update_total
	total_offset=_total_offset
	total_func=_total_func



var active=false

func _physics_process(_delta):
	if not active:
		return
	var valid=_check_tick_valid()
	if not valid:
		return
	_update_labels()
	ticks-=1

func _check_tick_valid():
	if ticks<0 and can_end:
		exec_at_end.call_func()
		return false
	return true

#60 tick = 1 second
func tick_to_str(_tick): #min:sec.ms
	var minus="-" if _tick<0  else ""
	var mins=int(abs(int(_tick/(60.0*60.0))))
	var sec=int(abs(int(_tick/60.0)))%60
	var ms=(int(abs(_tick))%60)*100.0/60.0
	return "%s%d:%d.%.2f"%[minus,mins,sec,ms]

func sec_to_tick(_sec):
	return int(round(_sec*60))


var errcol=Color(255.0/255.0,126.0/255.0,126.0/255.0)

func _should_be_red(_ticks):
	if _ticks<0: #bruhhh was "ticks" before
		return true
	return false


func __default_total_func():
	$TotalTime.text=tick_to_str(ticks+total_offset)
	if _should_be_red(ticks+total_offset):
		$TotalTime.add_color_override("font_color",errcol)
	else:
		$TotalTime.add_color_override("font_color",default_text_color)

func _update_labels():
	$Time.text=tick_to_str(ticks+label_offset)
	if _should_be_red(ticks+label_offset):
		$Time.add_color_override("font_color",errcol)
	else:
		$Time.add_color_override("font_color",default_text_color)
	if(update_total):
		total_func.call_func()




# var time_data={
# 	"Pool":false,
# 	"Total":1.0,
# 	"Extra":false,
# 	"ExtraLim":1.0,
# 	"ExtraGain":1.0,
# 	"Turn":1.0,
# 	"Known":false,
# 	"Amount":1,
# 	"Bleed":false,
# 	"Lose":false,
# 	"Transition":false,
# 	"TransitionTime":1.0
# }

#values supposed to be converted into ticks
var is_pool=false
var total=0
var is_extra=false
var extralim=0
var extragain=0
var turn=0
var is_known=false
var amount=0
var is_bleed=false
var is_lose=false
var is_transition=false
var transition_time=0

func _main_time_to_local():
	is_pool=main.time_data["Pool"]
	total=sec_to_tick(main.time_data["Total"])
	is_extra=main.time_data["Extra"]
	extralim=sec_to_tick(main.time_data["ExtraLim"])
	extragain=sec_to_tick(main.time_data["ExtraGain"])
	turn=sec_to_tick(main.time_data["Turn"])
	is_known=main.time_data["Known"]
	amount=main.time_data["Amount"]
	is_bleed=main.time_data["Bleed"]
	is_lose=main.time_data["Lose"]
	is_transition=main.time_data["Transition"]
	transition_time=sec_to_tick(main.time_data["TransitionTime"])
	
class player:
	var name=""
	var color=Color()
	var bird=0#0=not playing, 1=basic rules, 2=input bird names, 3=keep track of resources
	var ticks_remaining=0 #not used when Pool=false
	var turns_remaining=0 #not used when Pool=true or Known=false
	var bleed=0 #not used when Bleed=false
	var eliminated=false #not used when Lose=false
	func _init(_main_player):
		name = _main_player.name
		color = _main_player.color
		bird = _main_player.bird


var uneliminated=0
var players=[]
var curr_player=0
func _init_game():
	curr_player=0
	players=[]
	active=true
	_main_time_to_local()
	for i in main.players:
		players.append(player.new(i))
		players[-1].ticks_remaining=total
		players[-1].turns_remaining=amount
		players[-1].bleed=turn
	uneliminated=len(players)
	if(is_transition):
		_setup_transition()
	else:
		_setup_player()


func _darken_color(col):
	return Color(col.r*0.8,col.g*0.8,col.b*0.8)

func _setup_transition():
	_add_interval(transition_time)
	colrect.color=_darken_color(players[curr_player].color)
	$Player.text=players[curr_player].name
	$Status.text=transition_status_text
	$Finish.text=transition_button_text
	_set_total_status_and_time(transition_total_text,_magic_curr_player_time())
	exec_at_end=funcref(self,"_setup_player")
	exec_at_force_end=exec_at_end

var day=24*60*60*60 #offset when no lose, i think if you keep playing for a day
#you are fine with it ending// actually nvm just added is_lose into _valid_tick
func _setup_player():
	_hide_total_status_and_time()
	var p=players[curr_player]
	var new_ticks=0
	var new_l_off=0#label offset
	var new_update_total=false
	var new_total_off=0
	var new_total_func=_default_total_func
	if(is_pool):
		new_ticks=p.ticks_remaining
	else:
		if(is_known):
			new_ticks=turn
			_set_total_status_and_time(player_total_status_str,"%d"%(p.turns_remaining-1))
			#"yeah this is a bit hacky" - copilot
		else:
			if(is_bleed):
				new_ticks=p.bleed+turn
				new_l_off=-turn
				_set_total_status_and_time(player_bleeding_text,tick_to_str(turn))
				new_update_total=true
				new_total_func=funcref(self,"_bleed_calc")
			else:
				new_ticks=turn
	
	_add_interval(new_ticks,new_l_off,is_lose,new_update_total,new_total_off,new_total_func)
	colrect.color=players[curr_player].color
	$Player.text=players[curr_player].name
	$Status.text=player_status_text
	$Finish.text=player_button_text
	exec_at_end=funcref(self,"_lose_player")
	exec_at_force_end=funcref(self,"_end_player_turn")

func _bleed_calc():
	$TotalTime.text=tick_to_str(min(ticks,turn))


#note: only for using before _setup_player
func _magic_curr_player_time():#please help i am going insane
	var p=players[curr_player]
	var t=0
	if(is_pool):
		t=p.ticks_remaining
	else:
		if(is_known):
			t=turn
		else:
			if(is_bleed):
				t=p.bleed
			else:
				t=turn
	return tick_to_str(t)



func _set_total_status_and_time(_total,_time):
	$TotalStatus.visible=true
	$TotalTime.visible=true
	$TotalStatus.text=_total
	$TotalTime.text=_time

func _hide_total_status_and_time():
	$TotalStatus.visible=false
	$TotalTime.visible=false

func _lose_player():
	players[curr_player].eliminated=true
	uneliminated-=1
	_end_player_turn()

func find_next_unelim_player():
	curr_player=(curr_player+1)%len(players)
	while(players[curr_player].eliminated):
		curr_player=(curr_player+1)%len(players)	

func _end_player_turn():
	if(uneliminated==1):
		find_next_unelim_player()
		get_node("../End")._set_label(players[curr_player].name)
		colrect.color=players[curr_player].color
		_end_game()
	else:
		_handle_current_player_end()
		find_next_unelim_player()
		if((not is_pool) and is_known and players[curr_player].turns_remaining==0):
			get_node("../End")._set_label("",false)
			colrect.color=default_col
			_end_game()
			return #damn
		if(is_transition):
			_setup_transition()
		else:
			_setup_player()

func _handle_current_player_end():
	if(is_pool):
		players[curr_player].ticks_remaining=ticks+(extragain if is_extra and ticks<extralim else 0)
	else:
		if(is_known):
			players[curr_player].turns_remaining-=1
		else:
			if(is_bleed):
				players[curr_player].bleed=min(turn,ticks)
			else:
				players[curr_player].ticks_remaining=turn


func _on_Finish_pressed():
	exec_at_force_end.call_func()

func _on_Pause_pressed():
	active=false
	visible=false
	colrect.color=_darken_color(players[curr_player].color)
	get_node("../Pause")._set_labels(players[curr_player].name,
	tick_to_str(ticks+label_offset))#not the prettiest
	main._prev()

func _end_game():
	active=false
	visible=false
	main._next()

func _resume_game():
	active=true
	visible=true
	colrect.color=players[curr_player].color


