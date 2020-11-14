extends Node


var scripts_needed_to_start = ["StartGame"]
var scripts_ready = []


func start():
	var rounds = self.get_node("GameBoard").get_node("Rounds")
	var portrait_order = self.get_node("PortraitOrder")
	rounds.sort_turn_order()
	#portrait_order.get_dependencies()
	portrait_order.rearrange_portrait_order()
	


