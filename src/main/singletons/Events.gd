extends Node

# Player
signal player_ready()
signal current_weapon_changed(weapon: PackedScene)
signal weapon_reload_start(reload_time: int)
signal weapon_ammo_changed(ammo_amount: int)
signal projectile_impacted(position, direction)
# Wave Signals
signal start_next_wave()
signal wave_started(wave_number)
signal wave_finished(wave_number)
signal game_finish()
