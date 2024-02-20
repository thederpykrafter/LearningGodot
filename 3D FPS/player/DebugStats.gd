extends Label
	
# onready var OtherNode = get_node("Path/To/Other/Node")

func _process(delta):
	text = ""
	text += "fps: " + str(Performance.get_monitor(Performance.TIME_FPS))
	#text += "other variable: " + str(OtherNode.variable)
