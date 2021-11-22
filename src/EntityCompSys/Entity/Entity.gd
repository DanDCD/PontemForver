extends Node
class_name Entity


signal EntitySetUp
var isSetUp: bool = false setget switchOnIsSetUp # true once the entity has been set up

# unique id for the entity
var entityId: int = -1

# contains ids as keys for specific components
var componentMap = {}



func switchOnIsSetUp(param):
	isSetUp = true


# upon ready, all current children of Entity will be added as components
func collectComponents():
	for child in get_children():
		addComponent(child, false)




# returns a component with given ID -checks componentMap 
func getComponentByID(search_id: int):
	if not componentMap.has(search_id):
		return
	return componentMap[search_id]
	
# returns an array of components in a given group
func getComponentsByGroup(groupName: String)->Array:
	var arrayToReturn: Array = []
	for component in get_children():
		if component.is_in_group(groupName):
			arrayToReturn.append(component)
	return arrayToReturn
	

	
func addComponent(newComponent: Object, addAsChild: bool = true):
	# newComponent must be in component group AND have an IDTag as a child
	if not (newComponent.is_in_group("Component")):
		print()
		ErrorLogger.displayError("Entity:"+ String(entityId)+" cant add "+newComponent.name+ " -not in group component")
		return
	var compID: int = -1 # used to store the id of the component before moving it into the map
	for child in newComponent.get_children():
		if child.is_in_group("IDTag"):
			compID = child.id
	if compID == -1:
		ErrorLogger.displayError("Entity:"+ String(entityId)+" cant add "+newComponent.name+ " -no id tag found")
		return
		
	# if node is in group and id has been found:
	if addAsChild:
		add_child(newComponent)
		ErrorLogger.displayMessage(name+"-id:"+String(entityId)+": Added "+newComponent.name+"-id:"+String(compID)+" as a child")
		
	ErrorLogger.displayMessage(name+"-id:"+String(entityId)+": Added "+newComponent.name+"-id:"+String(compID)+" to components")
	componentMap[compID] = newComponent
	
	
func _ready():
	collectComponents()
	switchOnIsSetUp(true)
	emit_signal("EntitySetUp")
