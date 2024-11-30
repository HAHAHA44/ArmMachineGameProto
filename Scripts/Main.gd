extends Node

var tokenPool = preload("res://Scripts/TokenPool.gd").new()
var TokenScene = preload("res://Scenes/Token.tscn")
var panelScene = load("res://Scenes/Panel.tscn")
var ReelScene = load("res://Scenes/Reel.tscn")
var rowNum = 5
var colNum = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	tokenPool.load_tokens()
	initial_panel_randomly()

func initial_panel_randomly():
	var tokens = tokenPool.getCurrentTokens()

	print("got row num: ", rowNum, ",   got col num: ", colNum)
	tokens = fillEmptyTokens(tokens, rowNum, colNum)
	mountTokensOntoPanel(tokens, rowNum, colNum)
	var scored_token_tuples = calculate_score()
	for scored_token_tuple in scored_token_tuples:
		var token_index = scored_token_tuple[0]
		var score = scored_token_tuple[1]
		var token = tokens[token_index]
		token.show_score(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fillEmptyTokens(tokens: Array[CToken], rowNum: int, colNum: int):
	var count = rowNum * colNum
	for i in range(tokens.size(), count):
		var token = TokenScene.instantiate()
		token.initialize("Empty", null)
		tokens.append(token)
		
	tokens.shuffle()
	return tokens

func mountTokensOntoPanel(tokenArrs, rowNum: int, colNum: int):
	print("mount tokens onto panel, ", rowNum, ", ", colNum)
	var count = 0
	for row in range(rowNum):
		var reel = ReelScene.instantiate()
		for col in range(colNum):
			var token = tokenArrs[count]
			reel.add_child(token)
			count += 1
			print("row, ", row, "col, ", col, token.tokenName)
		$Panel.add_child(reel)
	#print_tree_pretty()
	
func _on_hud_start_game():
	reset_panel()
	initial_panel_randomly()

func calculate_score() -> Array:
	var tokens: Array[CToken] = tokenPool.getCurrentTokens()
	var scored_token_tuples = []

	for i in tokens.size():
		# [index, score]
		var curTuple = []
		var token = tokens[i]
		if token.level >= 1:
			curTuple.append(i)
			curTuple.append(token.calc_score(i, tokens, rowNum, colNum))
			scored_token_tuples.append(curTuple)
	return scored_token_tuples

func reset_panel():
	print("reset panel")
	for reel in $Panel.get_children():
		for token in reel.get_children():
			token.reset()
			reel.remove_child(token)
		reel.queue_free()
