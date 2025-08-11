extends CharacterBody2D

@export var move_speed: float=50.0
@export var speed_effect: float=0.0 #+加速-减速

@export var can_left: float = true
@export var can_right: float = true
@export var can_up: float = true
@export var can_down: float = true


@export var animator: AnimatedSprite2D
@export var tool_scene: PackedScene

var is_on_fire: bool = false
var is_game_over: bool = false

var health: float=100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#velocity=Vector2(50,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_over:
		velocity=Input.get_vector("left1","right1","up1","down1")*move_speed*(1+speed_effect)
		if !can_left and velocity.x<0:
			velocity.x=0
		if !can_right and velocity.x>0:
			velocity.x=0
		if !can_up and velocity.y<0:
			velocity.y=0
		if !can_down and velocity.y>0:
			velocity.y=0
			
		if velocity==Vector2.ZERO:
			animator.play("Idle")
		else:
			animator.play("Run") #之后稍微扩展一下动画
		
		move_and_slide()
		
		_on_fire()
		if health<0:
			is_game_over=true
	
#新的一轮重新随机选区，以及重新选择武器；先不随机选区了。
func new_round(area_num: int,tool: PackedScene,speed_e: float) ->void: 
#	随机选区暂时不实现
	tool_scene=tool
	speed_effect=speed_e
	
	
	
 
func game_over():
	is_game_over=true
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
