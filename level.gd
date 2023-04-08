extends Node

@export var bullet_scene: PackedScene
var bullet_spawn_pos
var bullet_rotation

func _on_player_player_shot(_who):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.rotation = bullet_rotation
	bullet.position = bullet_spawn_pos + Vector2(0, -29).rotated(bullet_rotation)
	

func _on_player_gun_point(where):
	bullet_spawn_pos = where


func _on_player_gun_point_rotate(rotation):
	bullet_rotation = rotation


func _on_player_2_gun_point(where):
	bullet_spawn_pos = where


func _on_player_2_gun_point_rotate(rotation):
	bullet_rotation = rotation


func _on_player_2_player_shot(_who):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.rotation = bullet_rotation
	bullet.position = bullet_spawn_pos + Vector2(0, -29).rotated(bullet_rotation)

func _on_ui_start():
	get_tree().call_group("Players", "_enable_movement")
	

func _on_player_player_died(_who):
	$UI._red_won()
	$ResetTimer.start()
	await $ResetTimer.timeout
	$ResetTimer.stop()
	$Player.show()
	$Player.position = $P1Spawn.position
	$Player.rotation_degrees = 180
	$Player2.show()
	$Player2.position = $P2Spawn.position
	$Player2.rotation_degrees = 0
	$UI._reset_menu()

func _on_player_2_player_died(_who):
	$UI._blue_won()
	$ResetTimer.start()
	await $ResetTimer.timeout
	$ResetTimer.stop()
	$Player.show()
	$Player.position = $P1Spawn.position
	$Player.rotation_degrees = 180
	$Player2.show()
	$Player2.position = $P2Spawn.position
	$Player2.rotation_degrees = 0
	$UI._reset_menu()
