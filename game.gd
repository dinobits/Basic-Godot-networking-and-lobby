extends Node2D

const Player = preload("res://player.gd")
const PlayerInfo = preload("res://player_info.gd")
const PLAYER = preload("res://player.tscn")


var _lobby: Lobby = Lobby

@onready var players: Node = $Players


func _ready():
	# Preconfigure game.
	_spawn_players()
	_lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.


# Called only on the server.
func start_game():
	print("Start")
	# All peers are ready to receive RPCs in this scene.


func _spawn_players() -> void:
	#players
	for player_id in _lobby.players.keys():
		var player = _create_player(player_id, _lobby.players[player_id])


func _create_player(id: int, player_info: Dictionary[StringName, String]) -> RigidBody2D:
	var player := PLAYER.instantiate() as Player
	players.add_child(player)
	var info := player.player_info as PlayerInfo
	info.player_name = player_info[&"name"]
	info.player_id = id
	return player
