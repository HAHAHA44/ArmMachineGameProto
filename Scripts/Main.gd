extends Node

var tokenPool = preload("res://Scripts/TokenPool.gd").new()
var TokenScene = preload("res://Scenes/Token.tscn")
var panelScene = load("res://Scenes/Panel.tscn")
var ReelScene = load("res://Scenes/Reel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	tokenPool.load_tokens()
	initial_panel_randomly()

func initial_panel_randomly():
	var tokens = tokenPool.getCurrentTokens()
	var rowNum = 5
	var colNum = 5
	print("got row num: ", rowNum, ",   got col num: ", colNum)
	arrangeTokens(tokens, rowNum, colNum)
	mountTokensOntoPanel(tokens, rowNum, colNum)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func arrangeTokens(tokens: Array[CToken], rowNum: int, colNum: int):
	#var retArr = []
	
	var count = rowNum * colNum
	for i in range(tokens.size(), count):
		var token = TokenScene.instantiate()
		token.initialize("Empty")
		tokens.append(token)
		
	tokens.shuffle()
	
	#for i in range(rowNum):
		#var row = []
		#retArr.append(row)
		#
	#for token in tokens:
		#setTokenTo2DArrRandomly(token, retArr, colNum, colNum)
	#for rets in retArr:
		#tokenPool.printTokens(rets)
	
	#return retArr
		
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

func setTokenTo2DArrRandomly(token, arr, row, col):
	var randRow = randi() % row
	var randCol = randi() % col
	if arr[randRow][randCol].tokenName == "Empty":
		arr[randRow][randCol] = token
	else:
		setTokenTo2DArrRandomly(token, arr, row, col)
	
func _on_hud_start_game():
	reset_panel()
	initial_panel_randomly()

func reset_panel():
	print("reset panel")
	for reel in $Panel.get_children():
		for token in reel.get_children():
			reel.remove_child(token)
		reel.queue_free()
