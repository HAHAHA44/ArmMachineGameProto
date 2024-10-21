extends Node

var TokenScene = preload("res://Scenes/Token.tscn")
var JsonLoader = preload("res://Scripts/JsonLoader.gd")
var tokens: Array[CToken] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getCurrentTokens() -> Array[CToken]:
	tokens = JsonLoader.serilizeTokens(TokenScene) as Array[CToken]
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

func printTokens(inputTokens):
	for token in inputTokens:
		print(token.toString())
	#print(tokens.map(func(token): return token.toString()))

