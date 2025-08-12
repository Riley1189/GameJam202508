extends Label

func _ready() -> void:
	hide()   # 场景加载时先隐藏
	await get_tree().create_timer(3.0).timeout
	show() 
