extends HBoxContainer


@export var player_name: String = "Player":
	set(value):
		player_name = value
		_player_name.text = value
@export var player_id: int = -1:
	set(value):
		player_id = value
		_player_id.text = str(value)

@onready var _player_name: Label = $PlayerName
@onready var _player_id: Label = $PlayerId
