extends Node2D

@onready var rooms_per_floor = 3
@onready var cur_floor = 0
@onready var floors = [
	['f1room1', 'f1room2', 'f1room3', 'f1room4'],
	['f2room1', 'f2room2', 'f2room3'],
	['f3room1', 'f3room2', 'f3room3']
]
var dungeon = []
@onready var room_scenes = []
@onready var last_room = $"Throne Room"

func getRooms(floor):
	var rooms = []
	for x in range(rooms_per_floor): # number of rooms to generate
		if not len(floors[floor]): # check if enough rooms to generate
			print("Not enough rooms in this current floor. Add more rooms on the current floor or decrease the rooms_per_floor. Floor: " + str(floor))
			return rooms
		randomize()
		var rand_index = randi() % len(floors[floor])
		rooms.append(floors[floor].pop_at(rand_index))

	rooms.append("boss_" + str(floor + 1))
	return rooms


func getNextRoom(dungeon_temp):
	if cur_floor > len(dungeon_temp) - 1 or len(dungeon_temp[cur_floor]) == 0: return "Empty"
	var room = dungeon_temp[cur_floor].pop_at(0)
	if len(dungeon_temp[cur_floor]) == 0:
		cur_floor += 1 # increase floor
	
	return room

# gets the layout of the dungeon and preloads scenes
func genRooms(dungeon):
	var room_count = 0
	
	# create room order
	for floor in range(len(floors)):
		room_count += rooms_per_floor + 1 # the +1 is for the boss room
		dungeon.append(getRooms(floor))
	dungeon.append(["final_room"])
	room_count += 1
	
	# preload all rooms as scenes into room_scenes array
	var dungeon_temp = dungeon.duplicate(true)
	for x in range(room_count):
		print(getNextRoom(dungeon_temp))
		#room_scenes.append(preload('res://Assets/Scenes/' + getNextRoom(dungeon_temp) + '.tscn'))
	
	return dungeon

# unloads current room and loads next room
func loadNextRoom():
	if len(room_scenes) == 0: return
	last_room.queue_free() # unload last room
	last_room = room_scenes.pop_at(0).instantiate() # get next scene
	add_child(last_room) # add scene
	last_room.visible = true # show scene
	last_room.door.connect(_on_level_template_door)

# Called when the node enters the scene tree for the first time.
func _ready():
	dungeon = genRooms(dungeon)
	$"Throne Room".door.connect(_on_level_template_door)
	print(dungeon)
	room_scenes.append(load('res://Assets/Scenes/level_template.tscn'))


func _on_level_template_door():
	print("OOIIII")
	loadNextRoom()
