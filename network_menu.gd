extends Control


const GAME = preload("res://game.tscn")
const GAME_PATH = "res://game.tscn"


var _lobby: Lobby = Lobby

@onready var host_button: Button = $VBoxContainer/HostButton
@onready var join_button: Button = $VBoxContainer/JoinSettings/JoinButton
@onready var host_settings: VBoxContainer = $HostSettings
@onready var player_name: LineEdit = $PlayerName
@onready var start_game: Button = $VBoxContainer/StartGame


func _ready() -> void:
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	start_game.pressed.connect(_on_start_game_pressed)
	_lobby.player_connected.connect(_on_player_joined)
	player_name.text_changed.connect(_on_player_name_changed)
	host_settings.hide()
	start_game.hide()


func _on_host_pressed() -> void:
	host_button.hide()
	_lobby.create_game()
	start_game.show()
	


func _on_join_pressed() -> void:
	_lobby.join_game()


func _on_player_joined(_id: int, _player_info) -> void:
	pass


func _on_player_name_changed(new_text) -> void:
	_lobby.player_info["name"] = new_text


func _on_start_game_pressed() -> void:
	_lobby.load_game.rpc(GAME_PATH)
