extends CanvasLayer
signal game_started


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var event = InputEventKey.new()
	event.scancode = KEY_T
	InputMap.add_action('test')
	InputMap.action_add_event('test', event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Appelée quand l'utilisateur appuie sur Start
func _on_StartButton_pressed():
	for child in get_children():
		child.hide()
#	$NomJeuLabel.hide()
#	$StartButton.hide()
#	$NombreJoueursEdit.hide()
#	$NombreJoueursLabel.hide()
	emit_signal("game_started")
	pass


# Appelée quand l'utilisateur valide le nombre de joueurs
func _on_NombreJoueursEdit_text_entered(new_text):
	print("ça marche du cul")
	pass # Replace with function body.
	
	
func _input(event):
	if event.is_action_pressed('test'):
		print('Test Worked!')
