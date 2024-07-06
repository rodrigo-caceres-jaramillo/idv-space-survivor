class_name Weapon
extends Equipment

enum WeaponTypes {
	PRIMARY=1,
	SECONDARY=2,
}

var type = Types.WEAPON
@export var weapon_scene: PackedScene
@export var stats: RangeWeaponsStats
@export var weapon_type: WeaponTypes
