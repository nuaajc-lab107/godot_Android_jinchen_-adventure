extends Area2D
@onready var zidan: Sprite2D = $Zidan

var linear_velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += linear_velocity * delta  # 持续移动子弹
	# 如果超出屏幕范围，销毁子弹
	if position.x < 0 or position.x > get_viewport().size.x:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# 如果碰撞了物体（比如墙壁），销毁子弹
	queue_free()
