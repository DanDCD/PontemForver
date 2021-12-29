extends Controller

### MOVEMENT ###

var movementBehaviour: Behaviour = null
var movementBody : MovementBodyComponent = null
var playerNetworkAdaptor: PlayerNetworkAdaptor = null
onready var moveInputStateMachine: FiniteStateMachine


# uses input data to update and change movementBehaviour
func processMovementInputs(delta):
	if movementBehaviour == null:
		return
	moveInputStateMachine.runProcess(delta)
	var moveDirection: Vector2 = Vector2.ZERO
	moveDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	moveDirection.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	movementBehaviour.direction = moveDirection
	movementBehaviour.moveBody()
	
	
func changeToSprint():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.RUNMOVEMENTBEHAVIOUR)
	
func changeToIdle():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.IDLEMOVEBEHAVIOUR)

func changeToWalk():
	movementBehaviour = entity.addComponentFromPackedScene(ResourceManager.WALKMOVEMENTBEHAVIOUR)
	
		
	
func setUpController():
	print("controller set up")
	moveInputStateMachine = $MoveInputStateMachine
	moveInputStateMachine.setUpMachine()
	movementBody = get_parent().getComponentsByGroup("MovementBody")[0]
	playerNetworkAdaptor = get_parent().getComponentsByGroup("NetworkAdaptor")[0]
	# initially adds an idle move behaviour to the entity
	changeToIdle()
	


func _physics_process(delta):
	moveInputStateMachine.runProcess(delta)
	processMovementInputs(delta)
	playerNetworkAdaptor.sendMovementBodyData(movementBody)
