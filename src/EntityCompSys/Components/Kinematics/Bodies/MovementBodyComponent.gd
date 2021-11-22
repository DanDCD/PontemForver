extends KinematicBody2D
class_name MovementBodyComponent

var direction:Vector2 = Vector2(0,0)


func moveBody(moveDirection:Vector2):
	direction = moveDirection;
	move_and_collide(direction)

