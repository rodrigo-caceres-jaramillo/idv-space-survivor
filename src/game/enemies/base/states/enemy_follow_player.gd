class_name EnemyFollowPlayerState
extends State

@export var attack_range: Area2D
@export var hurtbox: Area2D

func enter(_data):
	print("enter follow")
	if(!attack_range.is_connected("area_entered", change_to_attack)):
		attack_range.area_entered.connect(change_to_attack)
	if(!hurtbox.is_connected("hurt", change_to_knockback)):
		hurtbox.hurt.connect(change_to_knockback)

func physics_update(_delta):
	print("move")
	var direction = actor.global_position.direction_to(Global.player.global_position).normalized()
	actor.velocity = actor.stats.FINAL_SPEED * direction
	actor.move_and_slide()
	update_animation(direction)
	
func update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animation_player.play("move_right")
		else:
			animation_player.play("move_left")
	else:
		if direction.y > 0:
			animation_player.play("move_down")
		else:
			animation_player.play("move_up")

func change_to_attack(_area):
	state_transition.emit(self, "attack")
	
func change_to_knockback(hitbox):
	print("check_KB")
	var knockback = hitbox.knockback - actor.stats.KB_RESISTANCE
	if (knockback > 0 and !actor.stun): 
		state_transition.emit(self, "knockback", hitbox)
