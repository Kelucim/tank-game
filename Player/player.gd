extends CharacterBody2D

@export var playernumber = 1
var reloading_p1 = false
var reloading_p2 = false
var tank2 = preload("res://Player/tank2.png")
var can_move = false

signal player_shot(who)
signal gun_point(where)
signal gun_point_rotate(rotation)
signal player_died(who)
signal got_hit(who)

var health = 5

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
		gun_point.emit(position)
		gun_point_rotate.emit(rotation)
		player_shot.emit(playernumber)
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
		gun_point.emit(position)
		gun_point_rotate.emit(rotation)
		player_shot.emit(playernumber)
		reloading_p2 = true
		$ReloadTimer.start()
		await $ReloadTimer.timeout
		$ReloadTimer.stop()
		reloading_p2 = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullets"):
		health -= 1
		got_hit.emit(health)
	
	if health <= 0:
		player_died.emit(playernumber)
		hide()
		$Area2D/CollisionPolygon2D.set_deferred("disabled",true)
		$CollisionPolygon2D.set_deferred("disabled",true)
		get_tree().call_group("Players","_disable_movement")

func _enable_movement():
	can_move = true
	health = 5
	$Area2D/CollisionPolygon2D.disabled = false
	$CollisionPolygon2D.disabled = false
	
func _disable_movement():
	can_move = false
