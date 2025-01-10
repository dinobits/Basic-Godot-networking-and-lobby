extends HBoxContainer


@export var player_name: String = "Player":
	set(value):
		player_name = value
		if _player_name:
			_player_name.text = value
@export var player_id: int = -1:
	set(value):
		player_id = value
		if _player_id:
			_player_id.text = str(value)

@onready var _player_name: Label = $PlayerName
@onready var _player_id: Label = $PlayerId


func _ready() -> void:
	_player_name.text = player_name
	_player_id.text = str(player_id)
