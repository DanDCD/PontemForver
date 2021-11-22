extends Controller






func getMovementInputs():
	var movingDirection: Vector2
	movingDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	movingDirection.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	
	
	


func _physics_process(delta):
	pass
