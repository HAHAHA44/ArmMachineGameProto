extends Node2D

@onready var label = $Label

func _ready() -> void:
	pass

func setup(value: int, color: Color = Color.WHITE) -> void:
	label.text = "+" + str(value)
	label.modulate = color

func animate(keepTime: int) -> void:
	if keepTime:
		await get_tree().create_timer(keepTime).timeout

	var tween = create_tween()
	tween.set_parallel(true)
	
	# move upwards
	tween.tween_property(self, "position",
		position + Vector2(0, -100), 1.0
	).set_ease(Tween.EASE_OUT)
	
	# fade out
	tween.tween_property(self, "modulate",
		Color(1, 1, 1, 0), 1.0
	).set_ease(Tween.EASE_IN)
	
	await tween.finished
	queue_free()
