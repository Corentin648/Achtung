extends Node2D
export (PackedScene) var Player

var player1
var player2
var player3
var gagnant

var joueurs = {}

var nombre_joueurs
var nombre_morts

var game_over
var svg


func _ready():
	Global.Main = self
	Player = load("res://scenes/Player.tscn")
	$Mur.hide()
	$TableauScores.hide()
	nombre_morts = 0
	nombre_joueurs = 0
	pass


func _process(delta):
	if nombre_morts >= (nombre_joueurs - 1) && nombre_morts != 0 && !game_over:
		for joueur in joueurs.keys():
			joueur.vivant = false
		game_over = true
		if _fin_jeu():
			$TableauScores/Gagnant.show()
			$TableauScores/LeGagnant.set_text(self.gagnant.nom)
			$TableauScores/LeGagnant.show()
		
	if Input.is_action_just_pressed("ui_accept") && game_over:
		if !_fin_jeu():
			var svg = {}
			for joueur in joueurs.keys():
				svg[joueur.couleur] = joueurs[joueur]
				joueur.queue_free()
			joueurs.clear()
			nombre_joueurs = 0
			nombre_morts = 0
			_ajout_joueurs()
			for joueur in joueurs.keys():
				for couleur_svg in svg.keys():
					if joueur.couleur == couleur_svg:
						joueurs[joueur] = svg[couleur_svg]
			game_over = false
		elif _fin_jeu():
			$Mur.hide()
			$TableauScores.hide()
			$Menu.show()
			$Menu/ChampsIncomplets.hide()
			for joueur in joueurs.keys():
				joueur.queue_free()
			joueurs.clear()
			nombre_joueurs = 0
			nombre_morts = 0
			game_over = false
			for child in $TableauScores.get_children():
				if child is CanvasLayer:
					child.get_node("LeScore").set_text("0")
	pass


func _on_Menu_game_started():
	$Mur.show()
	$TableauScores/Goal.show()
	$TableauScores/ValeurGoal.set_text($Menu/ValeurGoal.get_text())
	$TableauScores/ValeurGoal.show()
	_ajout_joueurs()
	
func _on_Player_hit(player):
	nombre_morts += 1
	
	for joueur in self.joueurs.keys():
		if joueur.vivant:
			for child in $TableauScores.get_children():
				if child is CanvasLayer:
					if child.get_node("NomJoueur").get_text() == joueur.nom :
						self.joueurs[joueur] = self.joueurs[joueur] + 1
						child.get_node("LeScore").set_text(String(int(child.get_node("LeScore").get_text()) + 1))
	pass
	

func _ajout_joueurs():
	if $Menu/GUI_Joueur_1/JoueurPresent.pressed:
		player1 = Player.instance()
		player1.touche_gauche = KEY_LEFT
		player1.touche_droite = KEY_RIGHT
		player1.points = 0
		player1.image = load("res://img/trace_rouge.png")
		player1.nom = $Menu/GUI_Joueur_1/NomJoueurEdit.get_text()
		player1.couleur = "rouge"
		add_child(player1)
		_mouvement_joueur_depart(player1)
		self.joueurs[player1] = 0
		nombre_joueurs += 1
		$TableauScores/Joueur1/NomJoueur.set_text(player1.nom)
		$TableauScores/Joueur1/Couleur.set_texture(player1.image)
		$TableauScores/Joueur1.show()
	if $Menu/GUI_Joueur_2/JoueurPresent.pressed:
		player2 = Player.instance()
		player2.touche_gauche = KEY_J
		player2.touche_droite = KEY_L
		player2.points = 30
		player2.image = load("res://img/trace_verte.png")
		player2.nom = $Menu/GUI_Joueur_2/NomJoueurEdit.get_text()
		player2.couleur = "vert"
		add_child(player2)
		_mouvement_joueur_depart(player2)
		self.joueurs[player2] = 0
		nombre_joueurs += 1
		$TableauScores/Joueur2/NomJoueur.set_text(player2.nom)
		$TableauScores/Joueur2/Couleur.set_texture(player2.image)
		$TableauScores/Joueur2.show()
	if $Menu/GUI_Joueur_3/JoueurPresent.pressed:
		player3 = Player.instance()
		player3.touche_gauche = KEY_A
		player3.touche_droite = KEY_E
		player3.points = 0
		player3.image = load("res://img/trace_bleue.png")
		player3.nom = $Menu/GUI_Joueur_3/NomJoueurEdit.get_text()
		player3.couleur = "bleu"
		add_child(player3)
		_mouvement_joueur_depart(player3)
		self.joueurs[player3] = 0
		nombre_joueurs += 1
		$TableauScores/Joueur3/NomJoueur.set_text(player3.nom)
		$TableauScores/Joueur3/Couleur.set_texture(player3.image)
		$TableauScores/Joueur3.show()
	pass

	
func _mouvement_joueur_depart(joueur):
	for i in range (20):
		joueur.nouveau_trou()
		joueur.get_node("Body").set_position(joueur.get_node("Body").get_position() + joueur.velocity*joueur.get_process_delta_time())
	pass
	

func _fin_jeu():
	var max_points = 0
	for joueur in joueurs.keys():
		if joueurs[joueur] > max_points + 1:
			max_points = joueurs[joueur]
			self.gagnant = joueur
	return max_points >= int($TableauScores/ValeurGoal.get_text())
	pass
