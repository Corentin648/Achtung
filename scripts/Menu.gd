extends CanvasLayer
signal game_started


var trace_rouge = load("res://img/trace_rouge.png")
var trace_verte = load("res://img/trace_verte.png")
var trace_bleue = load("res://img/trace_bleue.png")


func _ready():
	$AlerteChampsIncomplets.hide()
	
	$GUI_Joueur_1/CouleurJoueur.set_texture(trace_rouge)
	$GUI_Joueur_2/CouleurJoueur.set_texture(trace_verte)
	$GUI_Joueur_3/CouleurJoueur.set_texture(trace_bleue)
	
	$GUI_Joueur_1/Controls.set_text("L : Left ; R : Right")
	$GUI_Joueur_2/Controls.set_text("L : J ; R : L")
	$GUI_Joueur_3/Controls.set_text("L : A ; R : E")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Appelée quand l'utilisateur appuie sur Start
func _on_StartButton_pressed():
	var pas_de_score = $ValeurGoal.get_text().length() == 0
	var pas_de_nom_1 = $GUI_Joueur_1/JoueurPresent.pressed && $GUI_Joueur_1/NomJoueurEdit.get_text().length() == 0 
	var pas_de_nom_2 = $GUI_Joueur_2/JoueurPresent.pressed && $GUI_Joueur_2/NomJoueurEdit.get_text().length() == 0 
	var pas_de_nom_3 = $GUI_Joueur_3/JoueurPresent.pressed && $GUI_Joueur_3/NomJoueurEdit.get_text().length() == 0  
	if pas_de_nom_1 || pas_de_nom_2 || pas_de_nom_3 || pas_de_score:
		$AlerteChampsIncomplets.show()
	else:
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
	
