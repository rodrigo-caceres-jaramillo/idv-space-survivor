class_name Upgrade
extends Equipment

enum UpgradeTypes {
	character,
	weapon,
}

@export var modifiers: Array[Modifier]
@export var upgrade_type: UpgradeTypes

