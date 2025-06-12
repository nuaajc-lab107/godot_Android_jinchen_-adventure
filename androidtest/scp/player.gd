extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const JUMP_X_VELOCITY = 150.0  # 控制跳跃时水平方向的速度
var move_direction = 0  # -1 为左，1 为右，0 为不移动
const ZIDAN = preload("res://snce/zidan.tscn")
const BULLET_SPEED = 400.0  # 子弹速度

@onready var jump: AudioStreamPlayer = $music/jump
@onready var run: AudioStreamPlayer = $music/run
@onready var shot: AudioStreamPlayer = $music/shot
@onready var gun: AudioStreamPlayer = $music/gun



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# If there's a left or right input from the buttons, apply that direction.
	if move_direction == -1:
		velocity.x = -SPEED
	elif move_direction == 1:
		velocity.x = SPEED
	else:
		# No movement, decelerate
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle jump with buttons (left or right and jump)
	if move_direction != 0 and Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = move_direction * JUMP_X_VELOCITY  # Add horizontal speed to the jump
	move_and_slide()

func _on_jump_pressed() -> void:
	if is_on_floor():  # Only allow jump if the player is on the floor.
		velocity.y = JUMP_VELOCITY
		velocity.x = move_direction * JUMP_X_VELOCITY  # Apply jump direction based on current movement
		animated_sprite_2d.play("jump")
		jump.play()
func _on_jump_released() -> void:
	animated_sprite_2d.play("kong")
	
func _on_right_pressed() -> void:
	move_direction = 1  # Move right
	animated_sprite_2d.flip_h=false
	animated_sprite_2d.play("run")
	run.play()
func _on_right_released() -> void:
	move_direction = 0  # Stop movement when button is released
	animated_sprite_2d.play("kong")

func _on_leght_pressed() -> void:
	move_direction = -1  # Move left
	animated_sprite_2d.flip_h=true
	animated_sprite_2d.play("run")
	
func _on_leght_released() -> void:
	move_direction = 0  # Stop movement when button is released
	animated_sprite_2d.play("kong")
	run.play()
	
func _on_gun_pressed() -> void:
	var bullet_instance = ZIDAN.instantiate()  # 实例化子弹
	get_parent().add_child(bullet_instance)  # 将子弹添加到当前场景
	# 设置子弹的位置为玩家当前的位置
	bullet_instance.position.y = position.y+5
	bullet_instance.position.x=position.x
	# 根据角色朝向确定子弹的方向
	var bullet_direction: Vector2
	if not animated_sprite_2d.flip_h:
		bullet_direction = Vector2(BULLET_SPEED, 0)  # 向右发射
	else:
		bullet_direction = Vector2(-BULLET_SPEED, 0)  # 向左发射	# 设置子弹的速度
	bullet_instance.linear_velocity = bullet_direction
	shot.play()
func _on_gundong_pressed() -> void:
	animated_sprite_2d.play("gun")
	if not animated_sprite_2d.flip_h:
		move_direction = 1  # Move right
	else:
		move_direction = -1  # Move left
	gun.play()
func _on_gundong_released() -> void:
	timer.start()
	animated_sprite_2d.play("kong")
	gun.stop()
func _on_timer_timeout() -> void:
	move_direction = 0  # Stop movement when button is released
