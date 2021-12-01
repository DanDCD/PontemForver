extends Node
class_name Controller

var entity: Object = null



func setUpController():
	pass



func _ready():
	entity = get_parent()
	setUpController()
