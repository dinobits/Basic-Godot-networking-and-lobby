extends Node2D

const Player = preload("res://player.gd")
const PLAYER = preload("res://player.tscn")


var _lobby: Lobby = Lobby

@onready var players: Node = $Players
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var _player_info: HBoxContainer = $PlayerInfo


func _ready():
	# Preconfigure game.
	_player_info.player_name = _lobby.player_info[&"name"]
	_player_info.player_id = multiplayer.get_unique_id()
	_lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.


# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	_spawn_players()


func _spawn_players() -> void:
	for player_id in _lobby.players.keys():
		var _player = _create_player(player_id, _lobby.players[player_id])
		_player.change_authority.rpc(player_id)


func _create_player(id: int, player_info: Dictionary[StringName, String]) -> RigidBody2D:
	var player := PLAYER.instantiate() as Player
	player.player_name = player_info[&"name"]
	player.player_id = id
	players.add_child(player, true)
	return player
