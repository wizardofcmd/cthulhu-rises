extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	$CollisionShape2D.disabled = false	
	$CthulhuSprite.play(&"idle")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		$CthulhuSprite.play(&"walk")
		velocity.x = direction * SPEED
		if velocity.x < 0:
			$CthulhuSprite.flip_h = true
		else:
			$CthulhuSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$CthulhuSprite.play(&"idle")

	move_and_slide()
