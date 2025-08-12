extends Area2D
class_name ToolBase

@export var duration: float=31.0
var player_owner: CharacterBody2D=null
var following: bool=false
var follow_velocity: Vector2=Vector2.ZERO
#这个是用于，比方说我这个武器是否跟着角色的转向而转向的，目前也就是只有这个信号灯是
#只要一攻击之后就开始自主的顺时针360的转跟角色朝向没有任何关系了。
var is_followed: bool=true

@export var tool_speed: float=100.0

#防止速度为0的乱翻，没有体验到有啥作用
var last_facing_right:=true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_owner==null:return
	
	if global_position.distance_to(player_owner.global_position)<5:
		global_position=player_owner.global_position
	else:
		global_position+=(player_owner.global_position-global_position)*delta #
	if is_followed and "velocity" in player_owner:
		if player_owner.velocity.x<0:
			if last_facing_right:
				scale.x=-scale.x
				last_facing_right=false
		elif player_owner.velocity.x>0:
			if not last_facing_right:
				scale.x=-scale.x
				last_facing_right=true
			
		

func setup(owner: CharacterBody2D)->void:
	player_owner=owner

#子类复写
func attack()->void: pass
func defend() ->void: pass
