extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_osc_server_message_received(address, value, time):
	text = address + " " + str(value) + " " + str(time)
	pass # Replace with function body.
