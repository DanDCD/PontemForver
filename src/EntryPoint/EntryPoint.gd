extends Node

export var isServer: bool = false

func _ready():
	pass
	if isServer:
		ServerHost.setUpServer()
	else:
		ServerGuest.setUpGuest()
