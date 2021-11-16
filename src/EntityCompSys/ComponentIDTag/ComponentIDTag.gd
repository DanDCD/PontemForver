extends Node
class_name ComponentIDTag

# unique id set by comp factory
var id: int = -1 setget setId, getId

# only allows id to be set once (by comp factory)
func setId(newID: int):
	if not(id == -1):
		return
	id = newID
	
	
func getId():
	return id

func _ready():
	setId(ComponentIdTagTracker.getNewID())
