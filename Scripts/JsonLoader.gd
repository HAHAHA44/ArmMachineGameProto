extends Node
var TokenScene = preload("res://Scenes/Token.tscn")
var Token
static var tokenTemplate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

static func create_token_by_template(obj, TokenCreator: Resource):
	var tokenInstance = TokenCreator.instantiate()
	tokenInstance.initialize(obj["name"], obj["level"])
	return tokenInstance

static func serilizeTokens(TokenCreator: Resource):
	var TokenArray: Array[CToken] = []
	var file = FileAccess.open("res://Assets/tokens.json", FileAccess.READ)
	
	if file:
		var json_data = file.get_as_text()
		file.close()
		
		if json_data != "":
			var json = JSON.new()  # 创建 JSON 实例
			var json_result = json.parse(json_data)
			
			if json_result == OK:
				print("json result:", json.data)
				var parsed_data = json.data
				
				if typeof(parsed_data) == TYPE_ARRAY:
					tokenTemplate = parsed_data
					for obj in parsed_data:
						var tokenInstance = create_token_by_template(obj, TokenCreator)
						TokenArray.append(tokenInstance)
				else:
					print("Parsed data is not an array")
			else:
				print("Failed to parse JSON:", json.error_string)
	else:
		print("Failed to open file!")
	return TokenArray
