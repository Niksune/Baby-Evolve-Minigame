extends Node

var lang = "fr"


func repeat_string(_str:String, count:int) -> String:
	var str:String = ""
	for i in range(count):
		str += _str
	return str
