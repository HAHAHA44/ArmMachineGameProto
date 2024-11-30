extends Node

var TokenScene = preload("res://Scenes/Token.tscn")
var JsonLoader = preload("res://Scripts/JsonLoader.gd")
var tokens: Array[CToken] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("token pool is ready")
	
func load_tokens():
	tokens = JsonLoader.serilizeTokens(TokenScene) as Array[CToken]

# Return the token slice with given 
func getCurrentTokens(len: int) -> Array[CToken]:
	print("get current tokens")
	if tokens.size() < len:
		fillEmptyTokens(len)
	#printTokens(tokens)
	return tokens

func fillEmptyTokens(len: int):
	for i in range(tokens.size(), len):
		var token = TokenScene.instantiate()
		token.initialize("Empty", null)
		tokens.append(token)

	return tokens

func generateToken():
	pass
	
func add():
	pass

func remove():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func get_card_temps_by_level(level: int):
	var cards = JsonLoader.tokenTemplate.filter(func(card): return level == card.level)
	return cards

func draw_a_new_token(level: int):
	var new_token = draw_token()
	print("draw a new token", new_token.toString())
	tokens = tokens.filter(func(token): return token.tokenName != "Empty")
	tokens.append(new_token)

func printTokens(inputTokens):
	for token in inputTokens:
		print(token.toString())
	#print(tokens.map(func(token): return token.toString()))

var card_probability = [
	{ "level": 10, "rate": 0.10 },
	{ "level": 5, "rate": 0.20 },
	#{ "level": 3, "rate": 0.20 },
	{ "level": 2, "rate": 0.30 },
	{ "level": 1, "rate": 0.40 }
]

func calculate_cumulative_probabilities(cumulative_probabilities: Array):
	cumulative_probabilities.clear()
	var total = 0.0
	for pool in card_probability:
		total += pool["rate"]
		cumulative_probabilities.append(total)

func draw_token():
	var random_val = randf()  # [0, 1)
	var cumulative_probabilities = []
	calculate_cumulative_probabilities(cumulative_probabilities)
	for i in range(cumulative_probabilities.size()):
		if random_val < cumulative_probabilities[i]:
			var current_level_cards = get_card_temps_by_level(card_probability[i].level)
			var card_temp = current_level_cards[randi() % current_level_cards.size()]
			return JsonLoader.create_token_by_template(card_temp, TokenScene)
	return null
