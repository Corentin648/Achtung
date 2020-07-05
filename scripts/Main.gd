extends Node2D
export (PackedScene) var Player

var player
var player2


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
	player = Player.instance()
	player2 = Player.instance()
	player.touche_droite = KEY_RIGHT
	player.points = 3
	add_child(player)
	player2.touche_droite = KEY_Z
	player2.points = 8
	add_child(player2)
	pass # Replace with function body.
	
func _on_Player_hit():
	print(player2.points)
	pass
