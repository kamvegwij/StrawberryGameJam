extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -420.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_chop: bool = false
var tree_collided: String = ""

func _ready():
	GameManager.player = self
	
func _physics_process(delta):
	move_player(delta)
	chop_tree()
	
func move_player(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("power_up") and GameManager.boost_available:
			velocity.y = JUMP_VELOCITY - 200.0
			
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func chop_tree():
	if Input.is_action_just_pressed("chop"):
		if can_chop and tree_collided == "rare":
			GameManager.rare_tree_health -= 20
			
		if can_chop and tree_collided == "common":
			GameManager.common_tree_health -= 40
			
func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("treerare"):
		can_chop = true
		tree_collided = "rare"
		print("rare tree found")

	if area.get_parent().is_in_group("treecommon"):
		can_chop = true
		tree_collided = "common"
		print("common tree found")
		
	if area.get_parent().is_in_group("meat"):
		GameManager.boost_available = true
		await(get_tree().create_timer(0.2))
		area.get_parent().queue_free()
		
	if area.is_in_group("ladder"):
		position = area.get_node("end").get_global_position()
		
func _on_area_2d_area_exited(area):
	can_chop = false
	tree_collided = ""
