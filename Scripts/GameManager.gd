extends Node2D


@export var dice_roll: PackedScene


# Called when the node enters the scene tree for the first time.
#这里的处理逻辑也是同每轮一样，
#1. 生成骰子，角色被告知新的一轮，以及获得tool+随机属性）
#2. 骰子销毁，角色开始可以移动开始战斗
func _ready() -> void:
	var dice_node=dice_roll.instantiate()
	dice_node.position=Vector2(0,0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#此处处理的是30一轮游戏的流程：
#1. 生成骰子，角色被告知新的一轮，以及获得tool+随机属性）
#2. 骰子销毁，（角色开始可以移动开始战斗
func one_round() -> void:
	$player1.is_new_round=true
	var dice_node=dice_roll.instantiate()
	dice_node.position=Vector2(0,0)
	#pass # Replace with function body.
