extends Button

var ID: String

func _init(init_ID, init_text):
	ID = init_ID
	text = init_text

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed():
	EVENTS.buy_button_pressed.emit(ID)
	print("Bought : ",ID)

func try_kill_ID(check_ID):
	if(ID == check_ID):
		queue_free()
