extends Control

const PLAYER_INFO = preload("res://player_info.tscn")


var _lobby: Lobby = Lobby
var _timer: Timer

@onready var player_list_box: VBoxContainer = $"."


func _ready() -> void:
	_lobby.player_connected.connect(_on_player_connected)
	_lobby.player_disconnected.connect(_on_player_connected)
	_timer = Timer.new()
	_timer.name = "LobbyUpdateTimer"
	_timer.timeout.connect(_on_timeout)
	_timer.autostart = true
	_timer.one_shot = false
	get_tree().root.add_child.call_deferred(_timer)


func _on_player_connected(id, player_info) -> void:
	prints("Remote sender: ", multiplayer.get_remote_sender_id(), "Player: id: ", id, player_info)
	update_player_list()


func update_player_list() -> void:
	for label in player_list_box.get_children():
		label.queue_free()

	for player_id in _lobby.players.keys():
		var label = PLAYER_INFO.instantiate()
		player_list_box.add_child(label)
		label.player_id = player_id
		label.player_name = _lobby.players[player_id]["name"]


func _on_timeout() -> void:
	update_player_list()
