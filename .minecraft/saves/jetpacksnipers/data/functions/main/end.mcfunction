tp @a 0 4 0

execute @e[tag=points,tag=25] ~ ~ ~ tellraw @a ["",{"selector":"@p[tag=player,score_POINTS_min=25]","color":"aqua"},{"text":" won the game!","color":"gold"}]
execute @e[tag=points,tag=50] ~ ~ ~ tellraw @a ["",{"selector":"@p[tag=player,score_POINTS_min=50]","color":"aqua"},{"text":" won the game!","color":"gold"}]
execute @e[tag=points,tag=75] ~ ~ ~ tellraw @a ["",{"selector":"@p[tag=player,score_POINTS_min=75]","color":"aqua"},{"text":" won the game!","color":"gold"}]
execute @e[tag=points,tag=100] ~ ~ ~ tellraw @a ["",{"selector":"@p[tag=player,score_POINTS_min=100]","color":"aqua"},{"text":" won the game!","color":"gold"}]
scoreboard teams empty 1
scoreboard teams empty 2
scoreboard teams empty 3
scoreboard teams empty 4
scoreboard teams empty 5
scoreboard teams empty 6
scoreboard teams empty 7
scoreboard teams empty 8
scoreboard teams empty 9
scoreboard teams empty 10
scoreboard teams empty 11

fill -1 3 -1 1 3 1 minecraft:sponge 0 replace lapis_block

scoreboard players tag @a remove spectator
scoreboard players tag @a remove player
scoreboard players tag @a remove points
scoreboard players reset * POINTS

summon minecraft:fireworks_rocket 27 4 -42 {LifeTime:1,FireworksItem:{id:fireworks,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:0,Trail:0,Colors:[3177764,13740846],FadeColors:[5988715,6844446]}]}}}}

tp @a 0 4 0