extends Label

@export var show_time: float = 2.5
@export var fade_time: float = 0.5

func _ready() -> void:
	show()
	await get_tree().create_timer(show_time).timeout
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_time)  # 透明度变0
	await tween.finished
	hide()
	modulate.a = 1.0
