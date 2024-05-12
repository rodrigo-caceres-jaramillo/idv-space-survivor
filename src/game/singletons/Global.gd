extends Node

var wave_container = null
var player = null
var money = 10
var wave = 1
var timer = null

func instance_node(node, location):
	var node_instance = node.instance()
	self.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
	
func instance_wave_node(node, location):
	var node_instance = node.instance()
	wave_container.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
