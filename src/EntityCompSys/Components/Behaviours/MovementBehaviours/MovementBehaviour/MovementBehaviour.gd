extends Behaviour
class_name MovementBehaviour

var movementBody: Object = null
var direction: Vector2 = Vector2.ZERO
var speed: int = 0
var velocity: Vector2 = Vector2.ZERO







# sets the new body for the behaviour to focus - will return true if set successfully
# fails if body not in movementbody group
func setMovementBody(newBody: Object)->bool:
	if not newBody.is_in_group("MovementBody"):
		return false
	movementBody = newBody
	return true


func moveBody(custom_velocity = null):
	if movementBody == null:
		return
	if custom_velocity != null:
		direction = direction.normalized()
		velocity = direction * speed
		movementBody.move(velocity)
	else:
		movementBody.move(custom_velocity)
		
func setUpMovementBody():
	pass
		
		
func _ready():
	if get_parent().isSetUp():
		setUpMovementBody()
	else:
		get_parent().connect("EntitySetUp", self, "setUpMovementBody")
		
