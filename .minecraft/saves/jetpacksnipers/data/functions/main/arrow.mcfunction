advancement revoke @a only main_kill:root player_hurt_entity
replaceitem entity @s[tag=!spectator] slot.hotbar.2 minecraft:bow 1 0 {display:{Name:"Sci-Fi Weapon"},Unbreakable:1,HideFlags:4,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @s[tag=!spectator] slot.hotbar.1 minecraft:stone_sword 1 0 {display:{Name:"Knife"},HideFlags:4,Unbreakable:1}
replaceitem entity @s[tag=!spectator] slot.hotbar.0 minecraft:carrot_on_a_stick 1 0 {display:{Name:"Jetpack"},HideFlags:4,Unbreakable:1,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
give @s minecraft:arrow 1 
scoreboard players add @s POINTS 3
tellraw @a ["",{"selector":"@s","color":"aqua"},{"text":" "},{"text":"+3","color":"red"},{"text":" points!"}]
execute @s ~ ~ ~ playsound minecraft:entity.arrow.hit_player master @p ~ ~ ~
