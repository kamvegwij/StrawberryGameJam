extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -420.0

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
	chop_tree()
	
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

	move_and_slide()
	
func chop_tree():
	if Input.is_action_just_pressed("chop"):
		if can_chop and tree_collided == "rare":
			GameManager.rare_tree_health -= 20
			
		if can_chop and tree_collided == "common":
			GameManager.common_tree_health -= 40
			
func add_to_inventory(name, img, total, type):
	var item = Inventory.new()
	item.name = name
	item.img = img
	item.total = total
	item.item_type = type
	return item
	
func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("treerare"):
		can_chop = true
		tree_collided = "rare"
		area.get_parent().get_node("health").visible = true
		area.get_parent().get_node("prompt").visible = true

	if area.get_parent().is_in_group("treecommon"):
		can_chop = true
		tree_collided = "common"
		area.get_parent().get_node("health").visible = true
		area.get_parent().get_node("prompt").visible = true
		
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
	tree_collided = ""
	if area.get_parent().is_in_group("treecommon") or area.get_parent().is_in_group("treerare"):
		area.get_parent().get_node("health").visible = false
		area.get_parent().get_node("prompt").visible = false
