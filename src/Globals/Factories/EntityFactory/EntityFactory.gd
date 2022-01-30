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
	


func createPlayer(toAdd:bool):
	var player = ResourceManager.PLAYER.instance()
	var controller = ResourceManager.PLAYERCONTROLLER.instance()
	player.addComponent(controller)
	assignEntity(player)
	addToWorld(toAdd, player)
	return player
	
func createPlayerDummy(toAdd:bool):
	var player = ResourceManager.PLAYER.instance()
	assignEntity(player)
	addToWorld(toAdd, player)
	return player


func addToWorld(toAdd:bool, entity: Entity):
	if toAdd and SceneManager.hasWorld():
		SceneManager.currentWorld.addEntity(entity)
