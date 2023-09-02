execute @s ~ ~ ~ particle angryVillager ~ ~ ~ 0.5 1 0.5 0 100 force @a
tp @s @r[tag=spawn,type=area_effect_cloud]
effect @p minecraft:invisibility 3 1 true
advancement revoke @s only main_died:root entity_hurt_player
replaceitem entity @s slot.hotbar.0 minecraft:carrot_on_a_stick 1 0 {display:{Name:"Jetpack"},HideFlags:4,Unbreakable:1,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @s slot.hotbar.1 minecraft:stone_sword 1 0 {display:{Name:"Knife"},HideFlags:4,Unbreakable:1}
replaceitem entity @s slot.hotbar.2 minecraft:bow 1 0 {display:{Name:"Sci-Fi Weapon"},HideFlags:4,Unbreakable:1,AttributeModifiers:[{AttributeName:"generic.attackDamage",Name:"generic.attackDamage",Amount:-100,Operation:2,UUIDLeast:213777,UUIDMost:234224,Slot:"mainhand"}]}
replaceitem entity @s slot.hotbar.3 minecraft:arrow 
