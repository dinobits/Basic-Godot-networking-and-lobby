extends RigidBody2D


@export var player_name: String = "":
	set(value):
		player_name = value
		if _player_info:
			_player_info.player_name = player_name
@export var player_id: int = -1:
	set(value):
		player_id = value
		if _player_info:
			_player_info.player_id = value

@onready var _player_info: HBoxContainer = $PlayerInfo


func _ready() -> void:
	_player_info.player_name = player_name
	_player_info.player_id = player_id


func _unhandled_input(event: InputEvent) -> void:
	if is_multiplayer_authority() && event.is_action("ui_accept"):
		apply_impulse(Vector2.UP * 100)


@rpc("any_peer", "call_local")
func change_authority(new_authority: int) -> void:
	if multiplayer.get_remote_sender_id() == 1:
		set_multiplayer_authority(new_authority, true)
