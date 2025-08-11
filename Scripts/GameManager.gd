extends Node2D


@export var dice_roll: PackedScene


# Called when the node enters the scene tree for the first time.
#这里的处理逻辑也是同每轮一样，
#1. 生成骰子，角色被告知新的一轮，以及获得tool+随机属性）
#2. 骰子销毁（骰子自带的3s消失的属性），角色开始可以移动开始战斗
func _ready() -> void:
	randomize() #使得每次的随机都不一样
	#var dice_node1=dice_roll.instantiate()
	#dice_node1.position=Vector2(-5,0)
	var dice_node_tools1=dice_roll.instantiate()
	dice_node_tools1.position=Vector2(-5,0)
	get_tree().current_scene.add_child(dice_node_tools1)
	
	await get_tree().create_timer(2).timeout
	var tools_number1=randi_range(1,6)
	dice_node_tools1._roll_number(tools_number1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#此处处理的是30一轮游戏的流程：
#1. 生成骰子，角色被告知新的一轮，以及获得tool+随机属性）
#2. 骰子销毁，（角色开始可以移动开始战斗
func one_round() -> void:
	$player1.is_new_round=true
	var dice_node_tools=dice_roll.instantiate()
	dice_node_tools.position=Vector2(0,0)
	dice_node_tools._roll_number(randi_range(1,6))
	#pass # Replace with function body.
