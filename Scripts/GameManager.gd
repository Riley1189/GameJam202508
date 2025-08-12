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
	#player1的相关roll
	# tool dice
	var dice_node_tools1=dice_roll.instantiate()
	dice_node_tools1.position=Vector2(-5,0) #这些变量需要给他整到上面显示出来，而不是随便赋值
	get_tree().current_scene.add_child(dice_node_tools1)
	#effect dice
	var dice_node_effect1=dice_roll.instantiate()
	dice_node_effect1.position=Vector2(-5,40)
	get_tree().current_scene.add_child(dice_node_effect1)
	
	# dicide roll number
	await get_tree().create_timer(2).timeout
	var tools_number1=randi_range(1,6)
	dice_node_tools1._roll_number(tools_number1)
	
	var effect_number1=randi_range(1,6)
	dice_node_effect1._roll_number(effect_number1)
	
	#$Player1.new_round_change(tools_number1,effect_number1)
	
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#此处处理的是30一轮游戏的流程： ****小心注意这里是时间每轮30s触发的
#1. 生成骰子，角色被告知新的一轮，以及获得tool+随机属性）
#2. 骰子销毁，（角色开始可以移动开始战斗
func one_round() -> void:
	$Player1.is_new_round=true
	
	#player1的相关roll
	# tool dice
	var dice_node_tools1=dice_roll.instantiate()
	dice_node_tools1.position=Vector2(-5,0) #这些变量需要给他整到上面显示出来，而不是随便赋值
	get_tree().current_scene.add_child(dice_node_tools1)
	#effect dice
	var dice_node_effect1=dice_roll.instantiate()
	dice_node_effect1.position=Vector2(-5,40)
	get_tree().current_scene.add_child(dice_node_effect1)
	
	# dicide roll number
	await get_tree().create_timer(2).timeout
	var tools_number1=randi_range(1,6)
	dice_node_tools1._roll_number(tools_number1)
	
	var effect_number1=randi_range(1,6)
	dice_node_effect1._roll_number(effect_number1)
	
	$Player1.new_round_change(tools_number1,effect_number1)
	
