extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	await $MessageTimer.timeout
	
func show_game_over():
	await show_message("Game Over")
	
	$MessageLabel.text = "Arm Machine!"
	$MessageLabel.show()
	# Make a one-show timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	get_tree().create_tween()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$MessageLabel.hide()
