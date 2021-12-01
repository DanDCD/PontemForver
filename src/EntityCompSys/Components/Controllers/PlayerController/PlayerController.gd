extends Controller

var movementBehaviour: Object = null
var alreadyWalking: bool = false


func sendMovementInputs():
	if movementBehaviour == null:
		var movementBehaviourArray: Array = get_parent().getComponentsByGroup("MovementComponent")
		if movementBehaviourArray.size() == 0:
			return
		movementBehaviour = movementBehaviourArray[0]
	
	var movingDirection: Vector2
	movingDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	movingDirection.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if not alreadyWalking and movingDirection != Vector2.ZERO:
		entity.addComponentFromPackedScene(ResourceManager)
		
	
	
	
	if(Input.is_action_just_released("sprint")):
		entity.addComponentFromPackedScene(ResourceManager.WALKMOVEMENTBEHAVIOUR)
	
	elif(Input.is_action_just_pressed("sprint")):
		entity.addComponentFromPackedScene(ResourceManager.WALKMOVEMENTBEHAVIOUR)
	
		
	
func setUpController():
	entity.addComponentFromPackedScene(ResourceManager)


func _physics_process(delta):
	pass
