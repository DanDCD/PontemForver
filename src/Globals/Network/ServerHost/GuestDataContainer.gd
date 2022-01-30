extends Node
class_name GuestDataContainer

var numberOfGuests: int = 0
var GuestDataScene = preload("res://src/Network/GuestData/GuestData.tscn")
signal GuestAdded(peerID)
signal GuestLeft(peerID)



func addGuest(peerID: int, userName: String):
	var newGuestData = GuestDataScene.instance()
	newGuestData.init(peerID, userName)
	add_child(newGuestData)
	emit_signal("GuestAdded", peerID)
	numberOfGuests += 1
	
func removeGuest(IpeerID:int):
	for guestdata in get_children():
		if guestdata.peerID == IpeerID:
			guestdata.queue_free()
			numberOfGuests -= 1
			emit_signal("GuestLeft", IpeerID)
