extends Node

export var isServer: bool = false

func _ready():
	NetworkInterface.hookUpSafetyDependencies()
	if isServer or "--server" in OS.get_cmdline_args():
		ServerHost.setUpServer()
	else:
		ServerGuest.setUpGuest()
	queue_free()
	

		
		
