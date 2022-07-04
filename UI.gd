extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Button_pressed():
	#var dir=Directory.new()
	#var l=OS.get_system_dir(1)+"/bruh.txt"
	#print(dir.file_exists(l))
	var file = File.new()
	print(File.WRITE)
	# print(file.open("user://bruhhendo.txt", File.WRITE))
	print(file.open("/storage/emulated/0/Documents/hello.txt", File.WRITE))
	file.store_string("ayoo")
	file.close()
	#print(dir.file_exists(l))


func _on_Button2_pressed():
	var file = File.new()
	print(File.READ)
	print(file.open("/storage/emulated/0/Documents/hello.txt",File.READ))
	$Theme/Label3.text=file.get_as_text()
	file.close()
#	var time=OS.get_time()
#	$Label.text=String(time.hour) +":"+String(time.minute)+":"+String(time.second)
	# $Label.text=String(OS.get_unix_time())
	pass # Replace with function body.
