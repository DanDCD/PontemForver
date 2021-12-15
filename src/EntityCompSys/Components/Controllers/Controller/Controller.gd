extends Node
class_name Controller

var entity: Object = null


# virtual
func setUpController():
	pass

# methods

func bootController():
	entity = get_parent()
	setUpController()


func _ready():
	get_parent().connect("EntitySetUp", self,"bootController")
