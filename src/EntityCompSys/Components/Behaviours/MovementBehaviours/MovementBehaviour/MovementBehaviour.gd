extends Behaviour
class_name MovementBehaviour

var movementBody: Object = null
var direction: Vector2 = Vector2.ZERO
export var speed: int = 0
var velocity: Vector2 = Vector2.ZERO
export var deleteSibilingMoveBehaviour: bool = true

# sets the new body for the behaviour to focus - will return true if set successfully
# fails if body not in movementbody group
func setMovementBody(newBody: Object)->bool:
	if not newBody.is_in_group("MovementBody"):
		return false
	movementBody = newBody
	return true


func moveBehaviourSetUp():
	pass

func preMoveBehaviour():
	pass

func postMoveBehaviour():
	pass




func findMovementBody():
	var movementBodyArray:Array = get_parent().getComponentsByGroup("MovementBody")
	if movementBodyArray.size() != 0 :
		return movementBodyArray[0]



# moves the movement body by a velocity
# velocity will be calculated using direction and speed members
# if a custom velocity is provided as an argument, this will be used instead
func moveBody(custom_velocity = null):
	preMoveBehaviour()
	if movementBody == null:
		return
	if custom_velocity == null:
		direction = direction.normalized()
		velocity = direction * speed
		movementBody.moveBody(velocity)
		postMoveBehaviour()
	else:
		movementBody.moveBody(custom_velocity)
		postMoveBehaviour()
		
func setUp():
	if movementBody == null:
		if deleteSibilingMoveBehaviour:
			get_parent().removeComponentsByGroup("MovementBehaviour", get_parent().getComponentID(self))
		setMovementBody(findMovementBody())
		moveBehaviourSetUp()

		
func setUpBehaviour():
	if get_parent().isSetUp:
		setUp()
	else:
		get_parent().connect("EntitySetUp", self, "setUp")
		
