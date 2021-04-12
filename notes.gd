extends Control

onready var text = $Background/Text
onready var config = ConfigFile.new()
const PATH_TO_NOTES_FILE = "user://notes.cfg"
const PASSWORD = "1234"

func _ready():
	if(load_config("notes", "text") != null):
		text.text = load_config("notes", "text")
	pass

func OnSave():
	if(save_config("notes", "text", $Background/Text.text) != -1):
		$Background/Error.hide()
		$Background/Saved.show()
	else:
		$Background/Saved.hide()
		$Background/Error.show()
	pass

func OnRestore():
	if(load_config("notes", "text") != null):
		text.text = load_config("notes", "text")
	else:
		text.text = ""
	pass

func load_config(section, key):
	var status = config.load_encrypted_pass(PATH_TO_NOTES_FILE, PASSWORD)
	if(status == OK):
		return config.get_value(section, key, null)
	else:
		return null
	pass

func save_config(section, key, value):
	config.set_value(section, key, value)
	var status = config.save_encrypted_pass(PATH_TO_NOTES_FILE, PASSWORD)
	if(status != OK):
		return -1
	pass



