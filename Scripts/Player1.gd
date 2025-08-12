extends CharacterBody2D

#movement
@export var move_speed: float=100.0
@export var speed_effect: float=0.0 #+加速-减速

@export var can_left: float = true
@export var can_right: float = true
@export var can_up: float = true
@export var can_down: float = true

#animation
@export var animator: AnimatedSprite2D
@export var tool_scene: PackedScene

var is_visible: bool=true

#action
var is_new_round = true
@export var new_round_wait_time=4.0

var is_game_over: bool = false


var is_on_fire: bool = false

var health: float=100
var damage_effect: float=0.0#用于减少/增加伤害的 +暴击buff
var defend_effect: float=0.0#用于减少/增加伤害的 -易伤buff

@export var tool_antique: PackedScene
@export var tool_hydrant: PackedScene
@export var tool_traffic_light: PackedScene
@export var tool_trash_can: PackedScene
#这里是每轮中对应的确定的武器是啥。
var tool_node: ToolBase


#不太确定，要把死亡信息往上传,
signal died(who)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(new_round_wait_time).timeout
	is_new_round=false
	animator.play("Idle")
	
	#velocity=Vector2(50,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_over:
		if is_new_round: #如果说新的一局在开始轮属性和tools，记得等待new_round_wait_time
			await get_tree().create_timer(new_round_wait_time).timeout
			is_new_round=false
			return
			
		#movement
		#if not is_visible:
			#$AnimatedSprite2D.visible=is_visible
		$AnimatedSprite2D.visible=is_visible
		velocity=Input.get_vector("left1","right1","up1","down1")*move_speed*(1+speed_effect)
		if !can_left and velocity.x<0:
			velocity.x=0
		elif !can_right and velocity.x>0:
			velocity.x=0
		elif !can_up and velocity.y<0:
			velocity.y=0
		elif !can_down and velocity.y>0:
			velocity.y=0
			
		if velocity==Vector2.ZERO:
			animator.play("Idle")
		# 四个方向的动画
		elif velocity.x<0:
			animator.play("RunLeft") 
		elif velocity.x>0:
			animator.play("RunRight")
		elif velocity.y>0:
			animator.play("RunDown")
		elif velocity.y<0:
			animator.play("RunUp")
		
		move_and_slide()
		
		#攻击相关
		_on_fire()
		
		if health<0:
			is_game_over=true
	
#新的一轮重新随机选区，以及重新选择武器；先不随机选区了。
#这个需要gamemanager来调用他的函数。把参数属性tool传过来
#只是用于接收属性tool本身，不控制角色的运动（角色的运动本身仍然放在_process中
func new_round_change(tools_number1:int,effect_number1:int) ->void: 
#	随机选区暂时不实现
	#首先是先把基础数值给设置会初始参数
	defend_effect=0
	damage_effect=0
	speed_effect=0
	is_visible=true
	can_left=true
	can_right=true
	can_up=true
	#此处为player分配该轮的武器：
	match tools_number1:
		1:
			tool_node=tool_antique.instantiate()
		2:
			tool_node=tool_hydrant.instantiate()
		3:
			tool_node=tool_traffic_light.instantiate()
		4:
			tool_node=tool_trash_can.instantiate()
		5:
			tool_node=tool_antique.instantiate()
		6:
			tool_node=tool_traffic_light.instantiate()
			
	#=====小心这里后续需要更改为vector从gamemanagement中进行参数传递
	tool_node.setup(self,Vector2(-45,0))
	get_tree().current_scene.add_child(tool_node)
	
	
	#此处是player的effect的变化，具体变化如下：
	#- 增益
	#1：~~防御增加10%~~ 修改为限制防御减少10%易伤buff
	#2：攻击增加10%
	#3：移动速度20%
	#4：隐身（抽象）自己隐藏，敌我不可见，但是武器不隐藏（？
#- 限制
	#5：扣掉一个随机方向键
	#6：移动速度-20%
	match effect_number1:
		1:
			defend_effect=-0.2
		2:
			damage_effect=0.1
		3:
			speed_effect=0.2
		4:
			is_visible=false
		5:
			var rand=randi_range(1,4)
			match rand:
				1:
					can_left=false
				2:
					can_right=false
				3:
					can_up=false
				4:
					can_down=false
		6:
			speed_effect=-0.2
			
	
	
	
 
func game_over():
	#is_game_over=true
	animator.play("Game_over")
	await get_tree().create_timer(3).timeout
	#get_tree().reload_current_scene()

#检测是否按键以及可以攻击，然后
func _on_fire() -> void:
	if Input.is_action_just_pressed("attack1"):
		if velocity!=Vector2.ZERO or is_game_over:
			return
		#var bullet_node=	bullet_scene.instantiate()
		#bullet_node.position=position+Vector2(6,7)
		#get_tree().current_scene.add_child(bullet_node

#func current_tool.destroy() → current_tool = null
#用于扣除伤害的
#func apply_damage()
