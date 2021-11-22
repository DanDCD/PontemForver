extends AnimatedSprite

func _ready():
	get_parent().connect("EntitySetUp", self,"glueToBody")
	
# creates a PositionGluer component and uses it to track
# if id is not provided, glue to first body collected
func glueToBody(id: int = -1):
	var body: MovementBodyComponent = null
	
	if id == -1:
		var bodies: Array = (get_parent().getComponentsByGroup("MovementBody"))
		if bodies.size() > 0:
			body = bodies[0]
	else:
		body = get_parent().getComponentByID(id)
		
	if body == null:
		print("fail")
		return
		
	
	var positionGluer = ResourceManager.POSITIONGLUER.instance()
	print(positionGluer.name)
	get_parent().addComponent(positionGluer)
	
	positionGluer.trackedNode = body
	positionGluer.trackingNode = self
	print("success")
