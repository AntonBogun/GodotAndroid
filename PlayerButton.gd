extends Button

signal toggled_with_reference(button)

func _toggled(_button_pressed):
    emit_signal("toggled_with_reference", self)