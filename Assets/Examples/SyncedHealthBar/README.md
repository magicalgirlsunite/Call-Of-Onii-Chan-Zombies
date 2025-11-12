# HealthBar Example

## Description
A simple Health Bar which uses a PlayerObject to sync and persist players' health amounts.

## Inspector Parameters

### HealthBar
* `float` **MaxHealth** - The maximum health a player has.
* `Vector3` **Offset Above Head** - The offset that the health bar needs to have above a players head
* `Slider` **Health Bar Slider** - The slider that is being used to show the health

### Lava
* `float` **Damage per second** - The damage that is dealt to the player per second while touching lava

---
## How to Use This Example
1. Open the HealthBar_ExampleScene.
2. Run it in the Editor or Build & Test.
3. Walk over to the red 'lava' and stand in it.
4. Look directly up to see your health bar, which will be shrinking as you continue to stand in the lava.
5. Exit the lava, take note of your health bar, and rejoin the world.
6. Your health will be restored to its previous level. Note that if you let your health bar run out entirely, you will respawn and your health will be restored to its full amount.