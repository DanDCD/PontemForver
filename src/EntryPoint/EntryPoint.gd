extends Node

export var isServer: bool = false

func _ready():
	if isServer or "--server" in OS.get_cmdline_args():
		ServerHost.setUpServer()
	else:
		ServerGuest.setUpGuest()
		get_tree().change_scene_to(ResourceManager.TESTINGWORLD)
