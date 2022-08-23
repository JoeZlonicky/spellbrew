extends Node

enum INGREDIENT_LIST {EYE_OF_NEWT, PURE_LIGHTNING, SLIME_BALL}

const INGREDIENTS = {
	INGREDIENT_LIST.EYE_OF_NEWT: preload("res://ingredient/ingredients/eye_of_newt.tres"),
	INGREDIENT_LIST.PURE_LIGHTNING: preload("res://ingredient/ingredients/pure_lightning.tres"),
	INGREDIENT_LIST.SLIME_BALL: preload("res://ingredient/ingredients/slime_ball.tres")
}
