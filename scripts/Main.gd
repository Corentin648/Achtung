extends Node2D
export (PackedScene) var Player

var player1
var player2
var player3

var joueurs = {}

var nombre_joueurs
var nombre_morts

var game_over
var svg


func _ready():
	Global.Main = self
	Player = load("res://scenes/Player.tscn")
	$Mur.hide()
	nombre_morts = 0
	nombre_joueurs = 0
	pass


func _process(delta):
	if nombre_morts >= (nombre_joueurs - 1) && nombre_morts != 0 && !game_over:
		for joueur in joueurs.keys():
			joueur.vivant = false
		game_over = true
		
	if Input.is_action_just_pressed("ui_accept") && game_over:
		var svg = {}
		for joueur in joueurs.keys():
			svg[joueur.nom] = joueurs[joueur]
			joueur.queue_free()
		joueurs.clear()
		nombre_joueurs = 0
		nombre_morts = 0
		_ajout_joueurs()
		for joueur in joueurs.keys():
			for nom_svg in svg.keys():
				if joueur.nom == nom_svg:
					joueurs[joueur] = svg[nom_svg]
		print(joueurs)
		game_over = false
	pass


func _on_Menu_game_started():
	$Mur.show()
	_ajout_joueurs()
	print(joueurs)
	pass
	
func _on_Player_hit(player):
	print("mort")
	#player.vivant = false
	nombre_morts += 1
	for joueur in self.joueurs.keys():
		if joueur != player && joueur.vivant:
			joueurs[joueur] = joueurs[joueur] + 1
	pass
	

func _ajout_joueurs():
	if $Menu/GUI_Joueur_1/JoueurPresent.pressed:
		player1 = Player.instance()
		player1.touche_droite = KEY_RIGHT
		player1.points = 0
		player1.image = load("res://img/trace_rouge.png")
		player1.nom = $Menu/GUI_Joueur_1/NomJoueurEdit.get_text()
		add_child(player1)
		_mouvement_joueur_depart(player1)
		self.joueurs[player1] = 0
		nombre_joueurs += 1
	if $Menu/GUI_Joueur_2/JoueurPresent.pressed:
		player2 = Player.instance()
		player2.touche_droite = KEY_RIGHT
		player2.points = 30
		player2.image = load("res://img/trace_verte.png")
		player2.nom = $Menu/GUI_Joueur_2/NomJoueurEdit.get_text()
		add_child(player2)
		_mouvement_joueur_depart(player2)
		self.joueurs[player2] = 0
		nombre_joueurs += 1
	if $Menu/GUI_Joueur_3/JoueurPresent.pressed:
		player3 = Player.instance()
		player3.touche_droite = KEY_RIGHT
		player3.points = 0
		player3.image = load("res://img/trace_bleue.png")
		player3.nom = $Menu/GUI_Joueur_3/NomJoueurEdit.get_text()
		add_child(player3)
		_mouvement_joueur_depart(player3)
		self.joueurs[player3] = 0
		nombre_joueurs += 1
	pass

	
func _mouvement_joueur_depart(joueur):
	for i in range (20):
		joueur.nouveau_trou()
		joueur.get_node("Body").set_position(joueur.get_node("Body").get_position() + joueur.velocity*joueur.get_process_delta_time())
	pass
