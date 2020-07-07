extends Node2D
export (PackedScene) var Player

var player1
var player2
var player3


func _ready():
	Global.Main = self
	Player = load("res://scenes/Player.tscn")
	$Mur.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Menu_game_started():
	$Mur.show()
	_ajout_joueurs()
	pass
	
func _on_Player_hit():
	#print(player2.points)
	pass
	

func _ajout_joueurs():
	if $Menu/GUI_Joueur_1/JoueurPresent.pressed:
		player1 = Player.instance()
		player1.touche_droite = KEY_RIGHT
		player1.points = 0
		player1.image = load("res://img/trace_rouge.png")
		add_child(player1)
		_mouvement_joueur_depart(player1)
	if $Menu/GUI_Joueur_2/JoueurPresent.pressed:
		player2 = Player.instance()
		player2.touche_droite = KEY_RIGHT
		player2.points = 0
		player2.image = load("res://img/trace_verte.png")
		add_child(player2)
		_mouvement_joueur_depart(player2)
	if $Menu/GUI_Joueur_3/JoueurPresent.pressed:
		player3 = Player.instance()
		player3.touche_droite = KEY_RIGHT
		player3.points = 0
		player3.image = load("res://img/trace_bleue.png")
		add_child(player3)
		_mouvement_joueur_depart(player3)
	pass
	
func _mouvement_joueur_depart(joueur):
	for i in range (20):
		joueur.nouveau_trou()
		joueur.get_node("Body").set_position(joueur.get_node("Body").get_position() + joueur.velocity*joueur.get_process_delta_time())
	pass
