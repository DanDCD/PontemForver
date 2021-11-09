extends Node

export var isServer: bool = false

func _ready():
	if isServer:
		ServerHost.setUpServer()
	else:
		ServerGuest.setUpGuest()
