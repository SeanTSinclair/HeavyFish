extends Resource
class_name HighScore

export var scores : Array = []

func add_score(score):
	scores.append(score)
	
func high_score():
	return scores.max() if scores.size() > 0 else 0
