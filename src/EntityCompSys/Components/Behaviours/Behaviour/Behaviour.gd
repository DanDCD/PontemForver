extends Node
class_name Behaviour


# ABSTRACT METHOD - subclasses can use to create custom setup behavoir (called on ready after body implimented)
func setUpBehaviour():
	pass


func cleanUpBehaviour():
	pass




func _ready():
	setUpBehaviour()



func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		cleanUpBehaviour()
