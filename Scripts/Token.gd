extends Control
class_name CToken
static  var max_id = 0
var id: int
@export var tokenName: String = "Default Text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$Label.text = tokenName


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(p_name):
	print("initialize called", max_id)
	max_id += 1
	id = max_id
	tokenName = p_name

	
func toString():
	return "id:" + str(id) + ", name:" + tokenName
