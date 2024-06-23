class_name EnemyFollowPlayerState
extends State

@export var attack_range: Area2D
@export var hurtbox: Area2D

func enter(_data):
	if attack_range.has_overlapping_areas(): state_transition.emit(self, "attack")
	if(!hurtbox.is_connected("hurt", change_to_knockback)):
		hurtbox.hurt.connect(change_to_knockback)

func physics_update(_delta):
	var direction = actor.global_position.direction_to(Global.player.global_position).normalized()
	actor.velocity = actor.stats.FINAL_SPEED * direction
	print(attack_range.has_overlapping_areas())
	if attack_range.has_overlapping_areas(): state_transition.emit(self, "attack")
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
	
func change_to_knockback(hitbox):
	var knockback = hitbox.knockback - actor.stats.KB_RESISTANCE
	if (knockback > 0 and !actor.stun): 
		state_transition.emit(self, "knockback", hitbox)
