extends Node




var entityContainer = {}
var currentEntityID: int = 0

func assignEntity(entity: Entity):
	entity.entityId = currentEntityID
	entityContainer[currentEntityID] = entity
	currentEntityID +=1
	
func getEntity(id: int)->Entity:
	if entityContainer.has(id):
		return entityContainer[id]
	else:
		return null
	





