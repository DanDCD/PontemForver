extends Node2D
class_name GameWorld

var entityMap = {}


func addEntity(newEntity: Entity):
	add_child(newEntity)
	entityMap[newEntity.entityId] = newEntity
	
func removeEntity(entityID: int):
	entityMap.erase(entityID)

func _ready():
	print("yo")
