extends Node2D

@onready var sprite = %AnimatedSprite2D  

func play_walk():
	%AnimatedSprite2D.play("walk")

func play_hurt():
	%AnimatedSprite2D.play("hurt")
	await sprite.animation_finished  
	%AnimatedSprite2D.play("walk")  
