extends Controller

var movementBehaviour: Object = null




func sendMovementInputs():
	if movementBehaviour == null:
		var movementBehaviourArray: Array = get_parent().getComponentsByGroup("MovementComponent")
		if movementBehaviourArray.size() == 0:
			return
		movementBehaviour = movementBehaviourArray[0]
	
	if(Input.is_action_just_pressed("sprint")):
		pass
		
			
	var movingDirection: Vector2
	movingDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	movingDirection.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	
	
	


func _physics_process(delta):
	pass
