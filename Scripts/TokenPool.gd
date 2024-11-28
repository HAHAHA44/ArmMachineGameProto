extends Node

var TokenScene = preload("res://Scenes/Token.tscn")
var JsonLoader = preload("res://Scripts/JsonLoader.gd")
var tokens: Array[CToken] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("token pool is ready")
	
func load_tokens():
	tokens = JsonLoader.serilizeTokens(TokenScene) as Array[CToken]

func getCurrentTokens() -> Array[CToken]:
	print("get current tokens")
	printTokens(tokens)
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
	
func random_update_a_token():
	tokens

func printTokens(inputTokens):
	for token in inputTokens:
		print(token.toString())
	#print(tokens.map(func(token): return token.toString()))

