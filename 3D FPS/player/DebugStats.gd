extends Label
	
# onready var OtherNode = get_node("Path/To/Other/Node")
# onready var OtherNode = get_node(%Node)
func _process(delta):
	text = "Debug Stats\n"
	text += "fps: " + str(Performance.get_monitor(Performance.TIME_FPS)) + "\n"
	
