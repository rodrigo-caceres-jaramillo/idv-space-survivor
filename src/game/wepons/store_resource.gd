class_name StoreResource
extends Resource

enum Types {
	WEAPON,
	ITEM
}

@export var name: String
@export var description: String
@export var price: int
@export var icon: Texture2D
@export var type: Types
@export var scene: PackedScene
