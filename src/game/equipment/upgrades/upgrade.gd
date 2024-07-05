class_name Upgrade
extends Equipment

enum UpgradeTypes {
	character=1,
	weapon=2,
}

@export var modifiers: Array[Modifier]
@export var upgrade_type: UpgradeTypes

