class_name WeaponResource
extends Resource

enum WeaponTypes {
	PRIMARY,
	SECONDARY,
	MELEE,
}
@export var name: String
@export var icon: Texture
@export var weapon_scene: PackedScene
@export var stats: RangeWeaponsStats
@export var weapon_type: WeaponTypes
