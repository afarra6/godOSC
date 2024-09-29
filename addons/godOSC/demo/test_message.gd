extends "res://addons/godOSC/demo/demo_message.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	update_message(get_parent().value)
	pass
