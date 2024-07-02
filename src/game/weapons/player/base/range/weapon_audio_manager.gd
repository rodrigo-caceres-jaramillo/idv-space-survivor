extends Node2D

@export var trigger_type: TriggerType
@export var shoot_audio: AudioStream
@export var reload_type: ReloadType
@export var reload_start_audio: AudioStream
@export var reload_finish_audio: AudioStream
@onready var shoot = AudioStreamPlayer2D.new()
@onready var reload_start = AudioStreamPlayer2D.new()
@onready var reload_finish = AudioStreamPlayer2D.new()

func _ready():
	shoot.stream = shoot_audio
	shoot.bus = "sfx"
	add_child(shoot)
	reload_start.stream = reload_start_audio
	reload_start.bus = "sfx"
	add_child(reload_start)
	reload_finish.stream = reload_finish_audio
	reload_finish.bus = "sfx"
	add_child(reload_start)
	trigger_type.attack.connect(play_shoot_sound)
	reload_type.reload_started.connect(play_start_reload_sound)
	reload_type.reload_finished.connect(play_finish_reload_sound)

func play_shoot_sound():
	var new_shoot_player = shoot.duplicate()
	add_child(new_shoot_player)
	new_shoot_player.play()
	new_shoot_player.finished.connect(func():new_shoot_player.queue_free())

func play_start_reload_sound():
	if not reload_start.is_playing():
		reload_start.play()

func play_finish_reload_sound():
	if not reload_finish.is_playing():
		reload_finish.play()
