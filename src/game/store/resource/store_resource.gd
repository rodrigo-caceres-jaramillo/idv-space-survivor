class_name StoreResource
extends Resource

enum Types {
	WEAPON,
	ITEM,
	UPGRADE
}

@export var name: String
@export var description: String
@export var price: int
@export var icon: Texture2D
@export var type: Types
