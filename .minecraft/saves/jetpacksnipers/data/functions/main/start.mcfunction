scoreboard teams join 1 @p[tag=!spectator,team=]
scoreboard teams join 2 @p[tag=!spectator,team=]
scoreboard teams join 3 @p[tag=!spectator,team=]
scoreboard teams join 4 @p[tag=!spectator,team=]
scoreboard teams join 5 @p[tag=!spectator,team=]
scoreboard teams join 6 @p[tag=!spectator,team=]
scoreboard teams join 7 @p[tag=!spectator,team=]
scoreboard teams join 8 @p[tag=!spectator,team=]
scoreboard teams join 9 @p[tag=!spectator,team=]
scoreboard teams join 10 @p[tag=!spectator,team=]
scoreboard teams join 11 @p[tag=!spectator,team=]
tellraw @a ["",{"text":"Starting","color":"aqua"},{"text":"!","color":"gold"}]
gamemode spectator @a[tag=spectator] 
scoreboard players tag @a remove lobby
scoreboard players set @a time 0
scoreboard players tag @a[tag=!spectator] add player
replaceitem entity @a[tag=!spectator] slot.hotbar.2 minecraft:bow 1 0 {display:{Name:"Sci-Fi Weapon"},Unbreakable:1,HideFlags:4,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @a[tag=!spectator] slot.hotbar.1 minecraft:stone_sword 1 0 {display:{Name:"Knife"},HideFlags:4,Unbreakable:1}
replaceitem entity @a[tag=!spectator] slot.hotbar.0 minecraft:carrot_on_a_stick 1 0 {display:{Name:"Jetpack"},HideFlags:4,Unbreakable:1,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @a[tag=!spectator] slot.hotbar.3 minecraft:arrow 
tp @a[tag=spectator] 42 40 44

tp @a[tag=!spectator] @r[type=area_effect_cloud,tag=spawn]

#tp @a[team=1] @e[type=area_effect_cloud,tag=1]
#tp @a[team=2] @e[type=area_effect_cloud,tag=2]
#tp @a[team=3] @e[type=area_effect_cloud,tag=3]
#tp @a[team=4] @e[type=area_effect_cloud,tag=4]
#tp @a[team=5] @e[type=area_effect_cloud,tag=5]
#tp @a[team=6] @e[type=area_effect_cloud,tag=6]
#tp @a[team=7] @e[type=area_effect_cloud,tag=7]
#tp @a[team=8] @e[type=area_effect_cloud,tag=8]
#tp @a[team=9] @e[type=area_effect_cloud,tag=9]
#tp @a[team=10] @e[type=area_effect_cloud,tag=10]
#tp @a[team=11] @e[type=area_effect_cloud,tag=11]


fill -1 3 -1 1 3 1 minecraft:lapis_block 0 replace sponge
replaceitem entity @a slot.armor.head minecraft:diamond 1 0 {Unbreakable:1,ench:[{id:10,lvl:1}],HideFlags:63,AttributeModifiers:[{AttributeName:"generic.knockbackResistance",Name:"generic.knockbackResistance",Slot:"head",Amount:100,Operation:0,UUIDMost:27243,UUIDLeast:170173}]}

tellraw @a ["",{"text":"Be the first player to reach","color":"aqua"},{"text":" "},{"selector":"@e[tag=points]","color":"gold"},{"text":" "},{"text":"points","color":"aqua"},{"text":"!","color":"gold"}]


#AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-1,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]

execute @a ~ ~ ~ playsound minecraft:entity.enderdragon.growl master @a ~ ~ ~





