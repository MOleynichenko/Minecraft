#for action bar title
title @a[score_time_min=0,score_time=80,tag=player] actionbar ["",{"text":"▇▇▇▇","color":"dark_red"}]
title @a[score_time_min=20,score_time=39,tag=player] actionbar ["",{"text":"▇","color":"dark_green"},{"text":"▇▇▇","color":"dark_red"}]
title @a[score_time_min=40,score_time=59,tag=player] actionbar ["",{"text":"▇▇","color":"dark_green"},{"text":"▇▇","color":"dark_red"}]
title @a[score_time_min=60,score_time=80,tag=player] actionbar ["",{"text":"▇▇▇","color":"dark_green"},{"text":"▇","color":"dark_red"}]
title @a[score_time_min=81,tag=player] actionbar ["",{"text":"","color":"dark_red"},{"text":"▇▇▇▇","color":"dark_green"}]

#for snowball grenade
execute @e[type=snowball] ~ ~ ~ kill @e[tag=tracker,r=3]
execute @e[tag=tracker] ~ ~ ~ summon creeper ~ ~ ~ {Fuse:0,Invisible:1}
kill @e[tag=tracker]
execute @e[type=snowball] ~ ~ ~ summon area_effect_cloud ~ ~ ~ {Duration:2,Tags:[tracker]}

#wool levitation
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:wool -1 effect @p minecraft:levitation 1 20 true

#effects
effect @a minecraft:saturation 100000 100 true
effect @a minecraft:night_vision 100000 100 true
effect @a minecraft:resistance 100000 100 true
effect @a[tag=lobby] minecraft:weakness 1 1 true

#no fall damage
scoreboard players tag @a add NotFalling {FallDistance:0.0f}
scoreboard players set @a[tag=NotFalling] Falling 0
effect @a[tag=NotFalling] jump_boost 0
effect @a[score_Falling_min=9] jump_boost 1 255 true
scoreboard players tag @a remove NotFalling

#jetpack

scoreboard players add @a[score_time_min=0,score_time=81] time 1
execute @a[score_USEROD_min=1,score_time_min=80] ~ ~ ~ effect @p minecraft:levitation 1 15 true
execute @a[score_USEROD_min=1,score_time_min=80] ~ ~ ~ playsound minecraft:entity.blaze.shoot master @a ~ ~ ~
execute @a[score_time_min=80,score_USEROD_min=1] ~ ~ ~ scoreboard players set @p time 0
execute @a[score_USEROD_min=1,score_time_min=1] ~ ~ ~ scoreboard players reset @p USEROD

#replace item
#replaceitem entity @a[tag=player] slot.hotbar.0 minecraft:carrot_on_a_stick
#replaceitem entity @a[tag=player] slot.hotbar.1 minecraft:stone_sword
#replaceitem entity @a[tag=player] slot.hotbar.2 minecraft:bow

#misc
execute @a[score_out_min=1] ~ ~ ~ tp @s 0 4 0
kill @e[type=item]
scoreboard players tag @e[type=arrow,tag=!kill] add kill {inGround:1b}
kill @e[type=arrow,tag=kill]
#entitydata @e[type=arrow] {NoGravity:1}


#player setup
scoreboard players reset @a out
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 scoreboard players tag @p remove player
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 scoreboard players tag @p remove spectator
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 gamemode adventure @p
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 clear @p
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 effect @p clear
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 scoreboard players reset @p POINTS
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 scoreboard players tag @p add lobby
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 tp @p 27 5 -42
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:sponge 0 scoreboard teams leave @p

#player counter
scoreboard players set * Count 0
execute @a[tag=!spectator] ~ ~ ~ scoreboard players add @a Count 1

#end
#function main:end if @a[tag=spectator,tag=!lobby]
function main:end if @p[tag=player,score_Count=1]
function main:end if @p[tag=player,score_Count=0]

execute @e[tag=points,tag=25] ~ ~ ~ function main:end if @p[tag=player,score_POINTS_min=25]
execute @e[tag=points,tag=50] ~ ~ ~ function main:end if @p[tag=player,score_POINTS_min=50]
execute @e[tag=points,tag=75] ~ ~ ~ function main:end if @p[tag=player,score_POINTS_min=75]
execute @e[tag=points,tag=100] ~ ~ ~ function main:end if @p[tag=player,score_POINTS_min=100]

#setup after game starts
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 scoreboard players tag @p remove player
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 scoreboard players tag @p add spectator
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 gamemode spectator @p
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 clear @p
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 effect @p clear
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 scoreboard players reset @p POINTS
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 tp @p 42 40 44
execute @a ~ ~ ~ detect ~ ~-1 ~ minecraft:lapis_block 0 scoreboard teams leave @p

#replace items if dropped


scoreboard players tag @a[tag=carrot] remove carrot
scoreboard players tag @a[tag=sword] remove sword
scoreboard players tag @a[tag=bow] remove bow {Inventory:[{Slot:2b,id:""}]}


scoreboard players tag @a add bow {Inventory:[{Slot:2b,id:"minecraft:bow"}]}
scoreboard players tag @a add sword {Inventory:[{Slot:1b,id:"minecraft:stone_sword"}]}
scoreboard players tag @a add carrot {Inventory:[{Slot:0b,id:"minecraft:carrot_on_a_stick"}]}


replaceitem entity @a[tag=!carrot,tag=player] slot.hotbar.0 carrot_on_a_stick 1 0 {display:{Name:"Jetpack"},customTag:1b,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @a[tag=!sword,tag=player] slot.hotbar.1 minecraft:stone_sword 1 0 {display:{Name:"Knife"},HideFlags:4,Unbreakable:1}
#replaceitem entity @a[tag=!bow,tag=player] slot.hotbar.2 minecraft:bow 1 0 {display:{Name:"Sci-Fi Weapon"},HideFlags:4,Unbreakable:1,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}


#air replaceitem
replaceitem entity @a slot.inventory.0 minecraft:air
replaceitem entity @a slot.inventory.1 minecraft:air
replaceitem entity @a slot.inventory.2 minecraft:air
replaceitem entity @a slot.inventory.3 minecraft:air
replaceitem entity @a slot.inventory.4 minecraft:air
replaceitem entity @a slot.inventory.5 minecraft:air
replaceitem entity @a slot.inventory.6 minecraft:air
replaceitem entity @a slot.inventory.7 minecraft:air
replaceitem entity @a slot.inventory.8 minecraft:air
replaceitem entity @a slot.inventory.9 minecraft:air
replaceitem entity @a slot.inventory.10 minecraft:air
replaceitem entity @a slot.inventory.11 minecraft:air
replaceitem entity @a slot.inventory.12 minecraft:air
replaceitem entity @a slot.inventory.13 minecraft:air
replaceitem entity @a slot.inventory.14 minecraft:air
replaceitem entity @a slot.inventory.15 minecraft:air
replaceitem entity @a slot.inventory.16 minecraft:air
replaceitem entity @a slot.inventory.17 minecraft:air
replaceitem entity @a slot.inventory.18 minecraft:air
replaceitem entity @a slot.inventory.19 minecraft:air
replaceitem entity @a slot.inventory.20 minecraft:air
replaceitem entity @a slot.inventory.21 minecraft:air
replaceitem entity @a slot.inventory.22 minecraft:air
replaceitem entity @a slot.inventory.23 minecraft:air
replaceitem entity @a slot.inventory.24 minecraft:air
replaceitem entity @a slot.inventory.25 minecraft:air
replaceitem entity @a slot.inventory.26 minecraft:air

replaceitem entity @a slot.hotbar.4 minecraft:air
replaceitem entity @a slot.hotbar.5 minecraft:air
replaceitem entity @a slot.hotbar.6 minecraft:air
replaceitem entity @a slot.hotbar.7 minecraft:air
replaceitem entity @a slot.hotbar.8 minecraft:air

replaceitem entity @a slot.weapon.offhand minecraft:air






