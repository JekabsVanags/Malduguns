extends Node
#GLOBAL INFO
const GRAVITY = 0.3
var rng = RandomNumberGenerator.new()

#PLAYER INFO
var player_HP = 5
var player_SP = 3
var player_LOC = Vector2(0,0)

var shine = false

func _ready():
	rng.randomize()

func getRandomNr(x,y):
	return rng.randf_range(x,y)
