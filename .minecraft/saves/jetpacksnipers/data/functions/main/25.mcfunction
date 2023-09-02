scoreboard players tag @e[tag=points] remove 25
scoreboard players tag @e[tag=points] remove 50
scoreboard players tag @e[tag=points] remove 75
scoreboard players tag @e[tag=points] remove 100
title @a actionbar ["",{"text":"Points set to "},{"text":"25","color":"gold"}]
entitydata @e[tag=points,type=area_effect_cloud] {CustomName:"25"}
playsound minecraft:block.note.bell master @a 27 6 -35