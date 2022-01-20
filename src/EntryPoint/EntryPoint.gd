extends Node

export var isServer: bool = false

func _ready():
	NetworkInterface.connect("processSafetyChanged", self, "startGame")
	if isServer or "--server" in OS.get_cmdline_args():
		ServerHost.setUpServer()
	else:
		ServerGuest.setUpGuest()
	
	
func startGame(safe:bool):
	if safe:
		print("starting game")
		NetworkInterface.disconnect("processSafetyChanged", self, "startGame")
		get_tree().change_scene_to(ResourceManager.TESTINGWORLD)
