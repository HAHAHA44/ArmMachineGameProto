extends Node

var tokenPool = preload("res://Scripts/TokenPool.gd").new()
var TokenScene = preload("res://Scenes/Token.tscn")
var panelScene = load("res://Scenes/Panel.tscn")
var ReelScene = load("res://Scenes/Reel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_panel_randomly()

func initial_panel_randomly():
	var tokens = tokenPool.getCurrentTokens()
	var rowNum = 5
	var colNum = 5
	print("got row num: ", rowNum, ",   got col num: ", colNum)
	var arr = arrangeTokens(tokens, rowNum, colNum)
	print(arr.size(), arr[0].size())
	mountTokensOntoPanel(arr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func arrangeTokens(tokens: Array[CToken], rowNum: int, colNum: int):
	tokens.shuffle()
	var retArr = []
	for i in range(rowNum):
		var row = []
		for j in range(colNum):
			var token = TokenScene.instantiate()
			token.initialize("Empty")
			row.append(token)
		retArr.append(row)
		
	for token in tokens:
		setTokenTo2DArrRandomly(token, retArr, colNum, colNum)
	for rets in retArr:
		tokenPool.printTokens(rets)
	
	return retArr
		
func mountTokensOntoPanel(tokenArrs):
	var r = 0
	var c = 0
	for row in tokenArrs:
		var reel = ReelScene.instantiate()
		r += 1
		c = 0
		for token in row:
			c += 1
			print(r, c)
			reel.add_child(token)
		$Panel.add_child(reel)
		

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
	for child in $Panel.get_children():
		child.queue_free()
