extends CanvasLayer
signal game_started


var trace_rouge = load("res://img/trace_rouge.png")
var trace_verte = load("res://img/trace_verte.png")
var trace_bleue = load("res://img/trace_bleue.png")


func _ready():	
	var event = InputEventKey.new()
	event.scancode = KEY_T
	InputMap.add_action('test')
	InputMap.action_add_event('test', event)
	
	$GUI_Joueur_1/CouleurJoueur.set_texture(trace_rouge)
	$GUI_Joueur_2/CouleurJoueur.set_texture(trace_verte)
	$GUI_Joueur_3/CouleurJoueur.set_texture(trace_bleue)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Appelée quand l'utilisateur appuie sur Start
func _on_StartButton_pressed():
	self.hide()
	emit_signal("game_started")
	pass
	
func hide():
	for child in get_children():
		if child is CanvasLayer:
			for grandchild in child.get_children():
				grandchild.hide()
		else:
			child.hide()
	pass
	
func show():
	for child in get_children():
		if child is CanvasLayer:
			for grandchild in child.get_children():
				grandchild.show()
		else:
			child.show()
	pass
	
	
	
func _input(event):
	if event.is_action_pressed('test'):
		print('Test Worked!')
