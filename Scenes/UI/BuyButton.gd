extends Button

var ID: String

func _init(init_ID : String, init_text : String, init_price : int):
	ID = init_ID
	text = to_5_char(init_price) + " : " + init_text

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed():
	EVENTS.buy_button_pressed.emit(ID)
	print("Bought : ",ID)

func try_kill_ID(check_ID):
	if(ID == check_ID):
		queue_free()
		
func to_5_char(price : int):
	var nb_digit = str(price).length()
	return str(price) + GLOBAL.repeat_string("*", 5 - nb_digit)

