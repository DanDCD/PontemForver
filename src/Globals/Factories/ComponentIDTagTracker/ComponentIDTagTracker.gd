extends Node


var currentID: int = 0 setget , getNewID

func getNewID():
	var temp_id: int = currentID
	currentID += 1
	return temp_id
