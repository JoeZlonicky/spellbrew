extends Node2D

const DUNGEON = preload("res://dungeon/dungeon.tscn")

var p1: Player
var p2: Player
var p1_score: int = 0
var p2_score: int = 0

onready var dungeon: Node2D = $Dungeon
onready var score: Label = $Overlay/Score
onready var restart_timer: Timer = $RestartTimer


func _ready():
	update_score()
	setup_game()


func setup_game():
	p1 = dungeon.players[0]
	p2 = dungeon.players[1]
	var _result = p1.connect("died", self, "_on_player_died", [p1])
	_result = p2.connect("died", self, "_on_player_died", [p2])


func _on_player_died(player: Player):
	if not restart_timer.is_stopped():  # Doesn't count if a player has already won
		return
	
	if player == p1:
		p2_score += 1
	elif player == p2:
		p1_score += 1
	update_score()
	restart_timer.start()


func reload_dungeon():
	dungeon.queue_free()
	dungeon = DUNGEON.instance()
	add_child(dungeon)
	move_child(dungeon, 0)


func update_score():
	score.text = "%d : %d" % [p1_score, p2_score]


func _on_RestartTimer_timeout():
	reload_dungeon()
	setup_game()
