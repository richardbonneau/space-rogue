extends Node



func _ready():
	pass 

func get_movement_cost_to_destination(var tileA, var tileB):
	#Get H value
	var dstX = abs(tileA.x - tileB.x)
	var dstZ = abs(tileA.z - tileB.z)
	print("dstX ",dstX," dstZ ",dstZ, " tileA.x ",tileA," tileB ",tileB)
	
	if dstX > dstZ:
		return 14 * dstZ + 10 * (dstX - dstZ)
	else:
		return 14 * dstX + 10 * (dstZ - dstX)
	


