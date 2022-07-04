extends ReferenceRect

var goodcol=Color.green
var badcol=Color.red
var noinputcol=Color(44.0/255,44.0/255,44.0/255)
var main

func _ready():
	main=find_parent("Main")


func _update_isfloat_positive(textedit,colorrect):
	if textedit.readonly:
		colorrect.color=noinputcol
		return false
	if textedit.text.is_valid_float() and float(textedit.text)>0:
		colorrect.color=goodcol
		return true
	else:
		colorrect.color=badcol
		return false

func _update_isint_positive(textedit,colorrect):
	if textedit.readonly:
		colorrect.color=noinputcol
		return false
	if textedit.text.is_valid_integer() and int(textedit.text)>0:
		colorrect.color=goodcol
		return true
	else:
		colorrect.color=badcol
		return false


func _on_Pool_toggled(button_pressed):
	main.time_data["Pool"]=button_pressed
	if button_pressed:
		$PoolTrue.visible=true
		$PoolFalse.visible=false
	else:
		$PoolTrue.visible=false
		$PoolFalse.visible=true





func _on_Lose_toggled(button_pressed):
	main.time_data["Lose"]=button_pressed

func _on_Transition_toggled(button_pressed):
	main.time_data["Transition"]=button_pressed
	if button_pressed:
		$TransitionTime.readonly=false
		_update_isfloat_positive($TransitionTime,$TTIsFloat)
	else:
		$TransitionTime.readonly=true
		$TTIsFloat.color=noinputcol
func _on_TransitionTime_text_changed():
	var valid=_update_isfloat_positive($TransitionTime,$TTIsFloat)
	if valid:
		main.time_data["TransitionTime"]=float($TransitionTime.text)



func _on_Total_text_changed():
	var valid=_update_isfloat_positive($PoolTrue/Total,$PoolTrue/TotalIsFloat)
	if valid:
		main.time_data["Total"]=float($PoolTrue/Total.text)


func _on_ExtraLim_text_changed():
	var valid=_update_isfloat_positive($PoolTrue/ExtraLim,$PoolTrue/LimitIsFloat)
	if valid:
		main.time_data["ExtraLim"]=float($PoolTrue/ExtraLim.text)


func _on_ExtraGain_text_changed():
	var valid=_update_isfloat_positive($PoolTrue/ExtraGain,$PoolTrue/GainIsFloat)
	if valid:
		main.time_data["ExtraGain"]=float($PoolTrue/ExtraGain.text)


func _on_Extra_toggled(button_pressed):
	main.time_data["Extra"]=button_pressed
	if button_pressed:
		$PoolTrue/ExtraLim.readonly=false
		$PoolTrue/ExtraGain.readonly=false
		_update_isfloat_positive($PoolTrue/ExtraLim,$PoolTrue/LimitIsFloat)
		_update_isfloat_positive($PoolTrue/ExtraGain,$PoolTrue/GainIsFloat)
	else:
		$PoolTrue/ExtraLim.readonly=true
		$PoolTrue/ExtraGain.readonly=true
		$PoolTrue/LimitIsFloat.color=noinputcol
		$PoolTrue/GainIsFloat.color=noinputcol


func _on_Turn_text_changed():
	var valid=_update_isfloat_positive($PoolFalse/Turn,$PoolFalse/TurnIsFloat)
	if valid:
		main.time_data["Turn"]=float($PoolFalse/Turn.text)

	

func _on_Amount_text_changed():
	var valid=_update_isint_positive($PoolFalse/Amount,$PoolFalse/AmountIsInt)
	if valid:
		main.time_data["Amount"]=int($PoolFalse/Amount.text)

func _on_Known_toggled(button_pressed):
	main.time_data["Known"]=button_pressed
	if button_pressed:
		$PoolFalse/Amount.readonly=false
		$PoolFalse/Bleed.disabled=true
		_update_isint_positive($PoolFalse/Amount,$PoolFalse/AmountIsInt)
	else:
		$PoolFalse/Amount.readonly=true
		$PoolFalse/Bleed.disabled=false
		$PoolFalse/AmountIsInt.color=noinputcol


func _on_Bleed_toggled(button_pressed):
	main.time_data["Bleed"]=button_pressed

func _floatposvalid(textedit):
	if textedit.readonly:
		return true
	if textedit.text.is_valid_float() and float(textedit.text)>0:
		return true
	else:
		return false

func _intposvalid(textedit):
	if textedit.readonly:
		return true
	if textedit.text.is_valid_integer() and int(textedit.text)>0:
		return true
	else:
		return false


func _check_valid_input():
	if not _floatposvalid($TransitionTime):
		return false
	if main.time_data["Pool"]:
		if (_floatposvalid($PoolTrue/Total) and 
			_floatposvalid($PoolTrue/ExtraLim) and 
			_floatposvalid($PoolTrue/ExtraGain)):
			return true
		else:
			return false
	else:
		if _floatposvalid($PoolFalse/Turn) and _intposvalid($PoolFalse/Amount):
			return true
		else:
			return false



func _on_Continue_pressed():
	if _check_valid_input():
		$Error.visible=false
		visible=false
		main._next()
	else:
		$Error.visible=true

func _on_Back_pressed():
	if _check_valid_input():
		$Error.visible=false
		visible=false
		main._prev()
	else:
		$Error.visible=true

func _sync_time_data():
	$Pool.pressed=main.time_data["Pool"]
	$Lose.pressed=main.time_data["Lose"]
	$Transition.pressed=main.time_data["Transition"]
	$TransitionTime.text=str(main.time_data["TransitionTime"])
	$PoolTrue/Total.text=str(main.time_data["Total"])
	$PoolTrue/Extra.pressed=main.time_data["Extra"]
	$PoolTrue/ExtraLim.text=str(main.time_data["ExtraLim"])
	$PoolTrue/ExtraGain.text=str(main.time_data["ExtraGain"])
	$PoolFalse/Turn.text=str(main.time_data["Turn"])
	$PoolFalse/Known.pressed=main.time_data["Known"]
	$PoolFalse/Amount.text=str(main.time_data["Amount"])
	$PoolFalse/Bleed.pressed=main.time_data["Bleed"]




