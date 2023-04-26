extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerOneHealth.hide()
	$PlayerTwoHealth.hide()

func _on_start_button_pressed():
	var map = randi_range(1,3)
	get_parent()._load_map(map)
	$Backg.hide()
	$PlayerOneHealth.show()
	$PlayerTwoHealth.show()
	$MainText.hide()
	$StartButton.hide()
	$QuitButton.hide()

func _on_quit_button_pressed():
	get_tree().quit()

func _blue_won():
	$MainText.text = "Blue Won"
	$MainText.show()
	$ResetTimer.start()
	await $ResetTimer.timeout
	_reset_menu()

func _red_won():
	$MainText.text = "Red Won"
	$MainText.show()
	$ResetTimer.start()
	await $ResetTimer.timeout
	_reset_menu()

func _reset_menu():
	$Backg.show()
	$MainText.text = "Tanky Boys"
	$PlayerOneHealth.hide()
	$PlayerTwoHealth.hide()
	$MainText.show()
	$StartButton.show()
	$QuitButton.show()
	$PlayerTwoHealth.text = "Red Health: 5"
	$PlayerOneHealth.text = "Blue Health: 5"

func _got_hit(who, newHealth):
	if who == 1:
		$PlayerOneHealth.text = "Blue Health: " + str(newHealth)
	elif who == 2:
		$PlayerTwoHealth.text = "Red Health: " + str(newHealth)
