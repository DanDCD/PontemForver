extends Controller

var movementBehaviour: Object = null
onready var moveInputStateMachine: Object

# uses input data to update and change movementBehaviour
func sendMovementInputs(delta):
	moveInputStateMachine.runProcess(delta)
	var moveDirection: Vector2 = Vector2.ZERO
	moveDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	moveDirection.x = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	movementBehaviour.direction = moveDirection
	movementBehaviour.moveBody()
	
	
	
	
func changeToSprint():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.RUNMOVEMENTBEHAVIOUR)
	
func changeToIdle():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.IDLEMOVEBEHAVIOUR)

func changeToWalk():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.WALKMOVEMENTBEHAVIOUR)
	
	
		
	
func setUpController():
	moveInputStateMachine = $MoveInputStateMachine
	moveInputStateMachine.Boot()
	# initially adds an idle move behaviour to the entity
	changeToIdle()
	


func _physics_process(delta):
	sendMovementInputs(delta)
