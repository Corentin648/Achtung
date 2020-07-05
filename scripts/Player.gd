extends Node
signal hit
export (PackedScene) var Trace


var velocity = Vector2()
var compteurTrous
var aleatoireTrou

var touche_gauche
var touche_droite
var points

func _ready():
	
	var screen_width = ProjectSettings.get_setting("display/window/size/width")
	var screen_height = ProjectSettings.get_setting("display/window/size/height")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# code permettant d'associer les touches au mouvement
	var event_droite = InputEventKey.new()
	event_droite.scancode = touche_droite
	print(String(touche_droite))
	InputMap.add_action(String(touche_droite))
	InputMap.action_add_event(String(touche_droite), event_droite)
	
	connect("hit", Global.Main, "_on_Player_hit")
	compteurTrous = 0
	Trace = load("res://scenes/Trace.tscn")
	velocity.x = 100
	
	# TODO : adapter à la taille de l'écran réel (bords jaunes)
	$Body.set_position(Vector2(round(rng.randf_range(0.05, 0.95)*screen_width), round(rng.randf_range(0.05, 0.95)*screen_height)))
	pass


func _physics_process(delta):
	nouveau_trou()
	$Body.set_position($Body.get_position() + velocity*delta)
	if Input.is_action_pressed("ui_left"):
		$Body.rotate(-PI/50)
		velocity = velocity.rotated(-PI/50).normalized()*100
	if Input.is_action_pressed(String(touche_droite)):
		$Body.rotate(PI/50)
		velocity = velocity.rotated(PI/50).normalized()*100
	pass
	

func nouveau_trou():
	if compteurTrous == 0:
		aleatoireTrou = randf()
		if aleatoireTrou <= 0.995:
			var trace = Trace.instance()
			var image = load("res://img/trace_rouge.png")
			trace.get_node("Sprite").set_texture(image)
			add_child(trace)
			trace.position = Vector2($Body.get_position().x,$Body.get_position().y)
		else:
			compteurTrous = 1
	elif compteurTrous == 30:
		compteurTrous = 0
	else:
		compteurTrous += 1
	pass

func _on_Area2D_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	emit_signal("hit")
	pass
