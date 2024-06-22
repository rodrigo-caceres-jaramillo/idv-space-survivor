class_name EnemyAttackState
extends State

@export var attack_manager: AttackManager
@export var attack_range: Area2D
@export var prep_time: float

func enter(_data):
	actor.velocity = Vector2.ZERO
	if(!attack_range.is_connected("area_exited", change_to_follow)):
		attack_range.area_exited.connect(change_to_follow)
	
func update(_delta):
	attack_manager.attack()

func change_to_follow(_area):
	state_transition.emit(self, "follow")
