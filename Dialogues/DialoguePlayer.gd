extends CanvasLayer

@export_file("*.json") var d_value: String

# Called when the node enters the scene tree for the first time.
func _ready():
	start() # Replace with function body.

func start():
	var dialogue = loadDialogue()
	
	$Control/RichTextLabel.text = dialogue[0]["name"]
	$Control/RichTextLabel2.text = dialogue[0]["text"]
	

func loadDialogue():
	if FileAccess.file_exists("res://Dialogues/json/gorp_intro.json"): #we have data
		#var save_data = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, 'porbo')
		var save_data = FileAccess.open("res://Dialogues/json/gorp_intro.json", FileAccess.READ)
		var parsed_data = JSON.parse_string(save_data.get_as_text())
		save_data.close()
		if parsed_data is Dictionary:
			return parsed_data
		else:
			print("some kinda system data loading error")
	else:
		print("invalid look text path")
		return {}
		

