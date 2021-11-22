extends Node2D

var trackingNode: Node2D = null
var trackedNode: Node2D = null


func _physics_process(delta):
	
	if not(trackingNode == null or trackedNode == null):
		trackingNode.position = trackedNode.position
		
		
func resetTrackingNode():
	trackingNode = null
	
func resetTrackedNode():
	trackedNode = null



