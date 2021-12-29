extends Node

var numberOfGuests: int = 0
var GuestDataScene = preload("res://src/Network/GuestData/GuestData.tscn")

func addGuest(peerID: int, userName: String):
	var newGuestData = GuestDataScene.instance()
	newGuestData.init(peerID, userName)
	add_child(newGuestData)
	numberOfGuests += 1
	
func removeGuest(IpeerID:int):
	for guestdata in get_children():
		if guestdata.peerID == IpeerID:
			guestdata.queue_free()
			numberOfGuests -= 1
