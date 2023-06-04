extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -420.0
const bridge = preload("res://scenes/bridge.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_chop: bool = false
var tree_collided: String = ""

func _ready():
	GameManager.player = self
	
func _physics_process(delta):
	if GameManager.player_health <= 0:
		pass
		#get_tree().change_scene_to_file()
		
	move_player(delta)
	build_bridge()
	
func move_player(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("power_up") and GameManager.meat_left > 0:
		GameManager.meat_left -= 1
		velocity.y = JUMP_VELOCITY - 200.0
			
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0: $Sprite2D.flip_h = true
	else: $Sprite2D.flip_h = false
	move_and_slide()


func build_bridge():
	if Input.is_action_just_pressed("build"):
		if GameManager.material_left >= 50:
			print("building bridge")
			
			var new_bridge = bridge.instantiate()
			new_bridge.global_position = get_global_mouse_position()
			get_parent().add_child(new_bridge)
			GameManager.material_left -= 50
		else:
			print("not enough wood")
		
func _on_area_2d_area_entered(area):
		
	if area.get_parent().is_in_group("meat"):
		await(get_tree().create_timer(0.2))
		GameManager.meat_left += 1
		area.get_parent().queue_free()
		
	if area.is_in_group("ladder"):
		position = area.get_node("end").get_global_position()
		
	if area.is_in_group("spike"):
		GameManager.player_health -= 25
		
#		if GameManager.material_left > 0:
#			GameManager.material_left -= 5
			
		get_tree().reload_current_scene()
				
func _on_area_2d_area_exited(area):
	can_chop = false
