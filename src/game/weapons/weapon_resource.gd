class_name WeaponResource
extends StoreResource

enum WeaponTypes {
	PRIMARY,
	SECONDARY,
	MELEE,
}

var type = ResourceTypes.WEAPON
@export var weapon_scene: PackedScene
@export var stats: WeaponStats = WeaponStats.new()
@export var weapon_type: WeaponTypes
var weapon_index = get_weapon_index()

func get_weapon_index() -> int:
	if weapon_type == WeaponResource.WeaponTypes.PRIMARY:
		return 1
	elif weapon_type == WeaponResource.WeaponTypes.SECONDARY:
		return 2
	elif weapon_type == WeaponResource.WeaponTypes.MELEE:
		return 3
	else:
		return -1
