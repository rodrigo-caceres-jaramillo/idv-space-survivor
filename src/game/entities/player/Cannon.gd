extends Sprite

onready var cannon_tip = $CannonTip
onready var rate_of_fire = $RateOfFire

export (PackedScene) var projectile_scene:PackedScene
var can_shoot = true
var projectile_container

func fire(dmg_mul):
	if(can_shoot):
		var proj_instance = projectile_scene.instance()
		proj_instance.initialize(projectile_container, cannon_tip.global_position, global_position.direction_to(cannon_tip.global_position))
		rate_of_fire.start()
		can_shoot = false

func _on_RateOfFire_timeout():
	can_shoot = true
