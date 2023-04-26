extends Node

var current_level
var level_one = preload("res://Levels/level_one.tscn")
var level_two = preload("res://Levels/level_two.tscn")
var level_three = preload("res://Levels/level_three.tscn")


func _load_map(which):
	current_level = which
	if which == 1:
		add_sibling.call_deferred(level_one.instantiate())
	elif which == 2:
		add_sibling.call_deferred(level_two.instantiate())
	elif which == 3:
		add_sibling.call_deferred(level_three.instantiate())


	if which == 1 or which == 2:
		GlobalValues.spawnPosition1 = Vector2(136, 504)
		GlobalValues.spawnPosition2 = Vector2(1016, 136)
	elif which == 3:
		GlobalValues.spawnPosition1 = Vector2(224, 448)
		GlobalValues.spawnPosition2 = Vector2(928, 192)

	get_tree().call_group("Players", "_enable_movement")
	
func _delete_old_map():
	$ResetTimer.start()
	await $ResetTimer.timeout
	
	if current_level == 1:
		get_tree().get_root().get_node("LevelOne").queue_free()
	elif current_level == 2:
		get_tree().get_root().get_node("LevelTwo").queue_free()
	elif current_level == 3:
		get_tree().get_root().get_node("LevelThree").queue_free()
