extends Node
var scorecard: Dictionary = {
	"left": 0, 
	"right": 0, 
	"up": 0, 
	"down": 0, 
	"primary action": 0, 
	"secondary action": 0
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func increment_action_count(action_name: String):
	if action_name in scorecard:
		scorecard[action_name] += 1
		#print(action_name + " has been used %d times" %scorecard[action_name])
'''haahaaahaaaaa'''
