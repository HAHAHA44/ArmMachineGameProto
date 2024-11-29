extends Control
class_name CToken
static  var max_id = 0
var id: int

@export var tokenName: String = "Default Text"
@export var level: int = 0

const FloatingText = preload("res://scenes/floating_text.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	$Label.text = tokenName
	$Level.text = str(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(p_name, _level):
	if !p_name:
		p_name = "Empty"
	if _level:
		level = _level
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
	
func show_score(value: int, pos: Vector2) -> void:
	var floating_text = FloatingText.instantiate()
	add_child(floating_text)
	floating_text.position = pos
	
	# 根据分数设置不同颜色
	var color = Color.WHITE
	if value >= 1:
		color = Color(1, 0.5, 0)  # 橙色
	elif value <= 1:
		color = Color(1, 1, 0)    # 黄色
		
	floating_text.setup(value, color)
	floating_text.animate()
