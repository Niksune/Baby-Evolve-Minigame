extends Button

var ID: String

func _init(init_ID : String, init_text : String, init_price : int):
	ID = init_ID
	#text = init_ID + " " + init_text + " : " + str(init_price) + " pts"
	text = init_text + " : " + str(init_price) + " pts"

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed():
	EVENTS.buy_button_pressed.emit(ID)

func try_kill_ID(check_ID):
	if(ID == check_ID):
		queue_free()

