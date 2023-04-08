extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= Vector2(0,1).rotated(rotation) * 1000 * delta


func _on_area_entered(_area):
	queue_free()
