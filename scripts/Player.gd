extends Node
signal hit
export (PackedScene) var Trace


var velocity = Vector2()
var compteurTrous
var aleatoireTrou

var touche_gauche
var touche_droite

func _ready():
	
	# code permettant d'associer les touches au mouvement
	var event = InputEventKey.new()
	event.scancode = touche_droite
	InputMap.add_action("droite")
	InputMap.action_add_event("droite", event)
	
	connect("hit", Global.Main, "_on_Player_hit")
	compteurTrous = 0
	Trace = load("res://scenes/Trace.tscn")
	velocity.x = 100
	$Body.set_position(Vector2(100,100))
	pass


func _physics_process(delta):
	nouveau_trou()
	$Body.set_position($Body.get_position() + velocity*delta)
	if Input.is_action_pressed("ui_left"):
		#print("c'est le drame")
		$Body.rotate(-PI/50)
		velocity = velocity.rotated(-PI/50).normalized()*100
	if Input.is_action_pressed("droite"):
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
