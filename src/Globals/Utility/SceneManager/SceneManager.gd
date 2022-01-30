extends Node

var currentWorld: GameWorld = null
var currentMenu: GameMenu = null

func hasWorld():
	return not currentWorld == null

func hasMenu():
	return not currentMenu == null

func clearScenes():
	if hasMenu():
		currentMenu.queue_free()
	if hasWorld():
		currentWorld.queue_free()

func setWorld(newWorld: GameWorld):
	clearScenes()
	currentWorld = newWorld
	get_tree().get_root().call_deferred("add_child", currentWorld)
	NetworkInterface.setSafeToProcessFlag("gameWorldReady", true)
		
func setMenu(newMenu:GameMenu):
	NetworkInterface.setSafeToProcessFlag("gameWorldReady", false)
	clearScenes()
	currentMenu = newMenu
	get_tree().get_root().add_child(currentMenu)
