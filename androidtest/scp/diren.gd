extends Node2D
const SPEED=60
var dir=1
@onready var light: RayCast2D = $light
@onready var right: RayCast2D = $right
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if right.is_colliding():
		animated_sprite_2d.flip_h=true
		dir=-1
	if light.is_colliding():
		animated_sprite_2d.flip_h=false
		dir=1
	position.x+=delta*dir*SPEED


func _on_bar_area_entered(area: Area2D) -> void:
	print("被击中了")
	queue_free()
