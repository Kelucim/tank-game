extends CanvasLayer

signal Start

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerOneHealth.hide()
	$PlayerTwoHealth.hide()

func _on_start_button_pressed():
	Start.emit()
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

func _red_won():
	$MainText.text = "Red Won"
	$MainText.show()

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

func _on_player_got_hit(who):
	$PlayerOneHealth.text = "Blue Health: " + str(who)


func _on_player_2_got_hit(who):
	$PlayerTwoHealth.text = "Red Health: " + str(who)
