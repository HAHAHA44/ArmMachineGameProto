extends Control
class_name CToken
static  var max_id = 0
var id: int
var floating_score_text

@export var tokenName: String = "Default Text"
@export var level: int = 0

const FloatingText = preload("res://scenes/floating_text.tscn")
	
static func getCoordinateByIndex(index: int, rowNum: int, colNum: int):
	var row = index / colNum
	var col = index % colNum
	return [row, col]

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
	$Label.text = _name
	tokenName = _name

func toString():
	return "[id:" + str(id) + ", name:" + tokenName + ",level:" + str(level) + "]"
	
func calc_score(index: int, tokens: Array[CToken], rowNum: int, colNum: int):
	var offsets_8 = [
		Vector2(-1, -1), Vector2(-1, 0), Vector2(-1, 1),
		Vector2(0, -1), Vector2(0, 1),
		Vector2(1, -1), Vector2(1, 0), Vector2(1, 1)
	]

	var score = 1
	var coordinates = CToken.getCoordinateByIndex(index, rowNum, colNum)
	var row = coordinates[0]
	var col = coordinates[1]
	#var offsets_4 = [
		#Vector2(-1, 0),
		#Vector2(0, -1), Vector2(0, 1),
		#Vector2(1, 0)
	#]
	var neighbors = []
	for offset in offsets_8:
		var neighbor_row = row + offset.x
		var neighbor_col = col + offset.y

		# Check edge
		if neighbor_row >= 0 and neighbor_row < rowNum and neighbor_col >= 0 and neighbor_col < colNum:
			var neighbor_index = neighbor_row * colNum + neighbor_col
			var neghbor_token = tokens[neighbor_index]
			if neghbor_token.tokenName == tokenName:
				score += 1
			neighbors.append(neighbor_index)

	return score
	
	
func show_score(value: int, pos: Vector2 = Vector2(10,10)) -> void:
	if !pos:
		pos = Vector2(10, 10)
	floating_score_text = FloatingText.instantiate()
	add_child(floating_score_text)
	floating_score_text.position = pos
	
	var color = Color.WHITE
	if value >= 1:
		color = Color(1, 0.5, 0)  # Orange
	elif value <= 1:
		color = Color(1, 1, 0)    # Yellow
		
	floating_score_text.setup(value, color)
	floating_score_text.animate(5)

func reset():
	if floating_score_text != null:
		floating_score_text.queue_free()
		floating_score_text = null
