extends Control
class_name CToken
static  var max_id = 0
var id: int
@export var tokenName: String = "Default Text"
@export var level: String = "1"


# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	$Label.text = tokenName
	$Level.text = level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(p_name):
	print("initialize called", max_id)
	max_id += 1
	id = max_id
	set_token_name(p_name)

func set_level(_level):
	level = _level
	$Level.text = _level
	
func set_token_name(_name):
	$Level.text = _name
	tokenName = _name

func toString():
	return "id:" + str(id) + ", name:" + tokenName
