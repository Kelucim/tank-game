extends CharacterBody2D

@export var playernumber = 1
var reloading_p1 = false
var reloading_p2 = false
var tank2 = preload("res://Player/tank2.png")
@export var can_move = false

var health = 5

var bullet_scene = preload("res://Bullet/bullet.tscn")

func _ready():
	if playernumber == 2:
		$Sprite2D.texture = tank2

func _physics_process(delta):
	if playernumber == 1 && can_move:
		_player_one(delta)
	if playernumber == 2 && can_move:
		_player_two(delta)

func _player_one(delta):
	if Input.is_action_pressed("p1_forward"):
		move_and_collide(Vector2(0, -1).rotated(rotation))
	if Input.is_action_pressed("p1_back"):
		move_and_collide(Vector2(0, 1).rotated(rotation))
	if Input.is_action_pressed("p1_left"):
		rotation_degrees -= 80 * delta
		move_and_collide(Vector2(0, 0))
	if Input.is_action_pressed("p1_right"):
		rotation_degrees += 80 * delta
		move_and_collide(Vector2(0, 0))
	if Input.is_action_just_pressed("p1_shoot") && !reloading_p1:
		_shoot()
		reloading_p1 = true
		$ReloadTimer.start()
		await $ReloadTimer.timeout
		$ReloadTimer.stop()
		reloading_p1 = false

func _player_two(delta):
	if Input.is_action_pressed("p2_forward"):
		move_and_collide(Vector2(0, -1).rotated(rotation))
	if Input.is_action_pressed("p2_back"):
		move_and_collide(Vector2(0, 1).rotated(rotation))
	if Input.is_action_pressed("p2_left"):
		rotation_degrees -= 80 * delta
		move_and_collide(Vector2(0, 0))
	if Input.is_action_pressed("p2_right"):
		rotation_degrees += 80 * delta
		move_and_collide(Vector2(0, 0))
	if Input.is_action_just_pressed("p2_shoot") && !reloading_p2:
		_shoot()
		reloading_p2 = true
		$ReloadTimer.start()
		await $ReloadTimer.timeout
		$ReloadTimer.stop()
		reloading_p2 = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullets"):
		health -= 1
		get_parent().get_node("UI")._got_hit(playernumber, health)
	if health <= 0:
		GlobalValues.player_died(playernumber)
		hide()
		$Area2D/CollisionPolygon2D.set_deferred("disabled",true)
		$CollisionPolygon2D.set_deferred("disabled",true)
		get_tree().call_group("Players","_disable_movement")

func _enable_movement():
	if playernumber == 1:
		position = GlobalValues.spawnPosition1
		rotation_degrees = 180
	elif playernumber == 2:
		position = GlobalValues.spawnPosition2
		rotation_degrees = 0

	can_move = true
	health = 5
	show()
	$Area2D/CollisionPolygon2D.disabled = false
	$CollisionPolygon2D.disabled = false
	
func _disable_movement():
	can_move = false

func _shoot():
	var bullet = bullet_scene.instantiate()
	add_sibling(bullet)
	bullet.rotation = rotation
	bullet.position = position + Vector2(0, -29).rotated(rotation)
