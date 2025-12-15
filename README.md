# Dungeon Rush – My CS50 Final Project
### Video Demo:  <URL HERE>

---

### Play My game on Roblox!
(https://www.roblox.com/games/76033410395771/Dungeon-Rush)

---

### Description/Overview:

**Dungeon Rush** Dungeon Rush is a game where you fight multiple variations of enemies to beat the level. You face enemies you have faced before, new enemies, and even bosses that has all the stats of the enemies yo have faced combined.

The game combines combat and strategy. Players must make tactical decisions about how to fight each enemies, how to stay alive, and to prioritize loot. This solo player game allows you to be in charge of your decisions, so that you can think about what is best for you.

---

## Why I Made This:

I was interested by games on roblox that had dungeon like features such as *Dungeon Quest* and *The Forge*. I wanted to try and see for myself how easy and what knowledge you would need to make a kind of a dungeon game like incorporating the enemies generating, their pathfinding and the combat features. Additionally, since I had some knowledge and already coded in Lua, I wanted to challenge myself with learning the scripting complex of enemy behaviors and pathfinding, player progression systems, and interactive objects.

I used **ChatGPT** to to help me brainstorm ideas and understand how to structure parts of the project, where to get my resources, and what ideas or imporvements I could add to my game.


---

## The Development Process

**Planning & Design:**
I begun the develpoment process by thinking about what I should add first and what are some of the core game mechanics in a dungeon type of game. Using Lua, I coded in a wave system that is capable of generating new waves each time there are no enemies left on the field, some enemy spawning systems that prevented all the enemies planned to spawn all spawing at once, and the database, where if you leave midround, die, win, or just joined, you can get your data for the first time or get your saved data from you latest playtrhough.

**The Player Systems:**

**Level System:** When I first moved onto the player systems, I tried to make it so that the new players have a balanced playthrough and won't be too weak. At the same time, I wanted the players who won, beated a wave, or just stright up defeated an enemy, to get some kind of an award. To solve this problem, I added a level system that takes Xp from killed enemies, waves cleared, when you win the game, and use that to boost up the exp bar until it is full. When it's full, the player not only levels up, but their stats, like their walkspeed and hp, gets increased and that is saved to the database. This way, returning players that had already beaten the game have a reason to play and the same goes for new players.

**Damage System:** I also made a click to damage kind of mechanic where when you click on something, the script sends a event over to another system that checks if the object is or is part of the enemy. If it is, it does damage and there is a debounce in order to prevent the effectiveness the players from just spam clicking or using a autoclicker.

**Gameplay Systems:** Later on, I also added a camera system where the camera is faced downward, onto the character and a system where the game prevents you from jumping. This way, it provides a more rpg feeling, at least to me, and preventes the player from click on the mob from a far away distance and you can't just jump onto the enemy's head and prevent damage being applied to you. I also added a system where if you die, you don't respawn and instead, the game resets and you are back at square one. You still keep your data though because of the database. This is the same for if you purposely reset your character <sup>(Which I do not know why you wold do that),</sup> or when you win the game. I also made it so that when you are at the menu screen, you can't move from spawn unless you press the play button.

**Enemy AI:**
I coded the enemies to have different behaviors. The enmies has a roaming behavior, were the enemy roams for a certain range if the player isn't in it's range, a chasing behavior, which is when the player is in the range of the mob, and a attacking behavior, where the mob attacks and hurts the player by a amount based on what type the enemy is. Balancing the difficulty required me testing alot to ensure the game remained challenging but fair to new players and players with high level in the game.

**GUI:**
I created a GUI that has all the stats of the player. There is a health bar of the player with tween that makes losing health look more smooth, a level bar, which captures how much exp the player has, a textLabel for showing the level of the player, a coins counter for the amount of coins the player has, a wave counter for what wave the player is on, and a mob counter for the amount of enemies that are currently alive. There is also a menu GUI where there is a frame that covers the whole screen and a play button that lets players play the game.

---

## The Challenges and Solutions For Them

- **Enemy AI:** When I was making the enemy pathfinding system, some of the enemies got stuck, broke or behaved during testing. I changed and fixed the enemy scripts to account for players in the range of their set view, attacking if they are, and roam if they aren't. This makes their behavior more reliable.

- **GUI Animations:** When I wasnmaking the GUI, the tweens between some frames like the level bar would not work the way they are intended to. On top of that, some of the frames were kind of lagging behind or desynced from taking damage. I synced the scripts with events from the server scripts and that reduced the desync and fixed the breaking GUI problems.

---

## What I Learned

This project helped me learn more about my programming skills in Lua, my understanding of Roblox Studio, and how well I code on my own. I learned how to implement systems, events, pathfinding, manage player stats, and synchronize GUI animations. Beyond the project, I learned a lot of problem-solving, project planning, and debugging skills.

---

## Future Improvements

- I would add more waves and room generation
- I wouldI introduce more loot variety, traps, and puzzles for higher entertainment.
- I would add more visuals, animations, and sound effects to make the environment more lively.
