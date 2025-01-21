extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gate_on_button_down():
	$"OSCClient - OUT".send_message("/synth1/gate", [1])
	pass # Replace with function body.


func _on_gate_off_button_down():
	$"OSCClient - OUT".send_message("/synth1/gate", [0])
	pass # Replace with function body.
