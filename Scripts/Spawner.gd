extends Node2D

var spawn_time := 5
var spawn_range := 1

onready var NPC = preload("res://Prefabs/Npc.tscn")

func _on_SpawnTimer_timeout():
	$SpawnTimer.wait_time = rand_range(spawn_time - spawn_range, spawn_time + spawn_range)
	
	if len(get_tree().get_nodes_in_group("NPC")) < Global.number_of_bots:
		var npc = NPC.instance()
		npc.global_position = self.global_position
		npc.gender = randi()%2
		get_parent().add_child(npc)
