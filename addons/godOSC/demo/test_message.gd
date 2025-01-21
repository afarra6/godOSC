extends "res://addons/godOSC/demo/demo_message.gd"
var new_val = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Only send a new OSC message if the value has changed
	if new_val != get_parent().value:
		send_message(get_parent().value)
		new_val = get_parent().value
	
	
	pass
