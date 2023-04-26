extends Node

var spawnPosition1 = Vector2()
var spawnPosition2 = Vector2()

func player_died(who):
	if who == 1:
		get_tree().call_group("UI", "_red_won")
		get_tree().get_root().get_node("Level")._delete_old_map()
	elif who == 2:
		get_tree().call_group("UI", "_blue_won")
		get_tree().get_root().get_node("Level")._delete_old_map()
