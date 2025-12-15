# Dungeon Rush – My CS50 Final Project
### Video Demo:

---

### Play My Game on Roblox!
(https://www.roblox.com/games/76033410395771/Dungeon-Rush)

---

### Description/Overview:

**Dungeon Rush** is a solo dungeon-style combat game built in Roblox. The player must survive waves of enemies in order to progress through the level. Throughout the game, the player faces enemies they have encountered before, newly introduced enemies, and eventually bosses that combine the statistics and behaviors of previous enemies.

The game focuses heavily on combat and strategy. Players must make tactical decisions about how to approach enemies, how to manage their health, and when to take risks. Since the game is single-player, all decisions are entirely up to the player, encouraging thoughtful gameplay and learning through trial and error. Progression is persistent, meaning players retain their stats and progress between playthroughs.

---

## Why I Made This:

I was inspired by Roblox games with dungeon-style mechanics, such as *Dungeon Quest* and *The Forge*. I wanted to understand how games like these were structured and what knowledge is required to implement systems like enemy generation, combat, and pathfinding. I was especially curious about how enemies could be programmed to behave differently depending on the player’s actions.

Because I already had experience programming in Lua, I wanted to challenge myself by working on more advanced systems, including complex enemy behaviors, pathfinding, player progression, and interactive gameplay systems.

I used **ChatGPT** to help me brainstorm ideas and understand how to structure parts of the project, where to get my resources, and what ideas or improvements I could add to my game.

---

## The Development Process

- **Planning & Design:**
I began the development process by thinking about what I should add first and what some of the core game mechanics are in a dungeon-type game. Using Lua, I coded in a wave system that is capable of generating new waves each time there are no enemies left on the field, some enemy spawning systems that prevented all the enemies planned to spawn from spawning at once, and the database, where if you leave mid-round, die, win, or just join, you can get your data for the first time or get your saved data from your latest playthrough.

**The Player Systems:**

- **Level System:** When I first moved onto the player systems, I tried to make it so that the new players have a balanced playthrough and won't be too weak. At the same time, I wanted the players who won, beat a wave, or simply defeated an enemy to get some kind of an award. To solve this problem, I added a level system that takes XP from killed enemies and cleared waves when you win the game and uses that to boost up the XP bar until it is full. When it's full, the player not only levels up, but their stats, like their speed and HP, also get increased, and that is saved to the database. This way, returning players that had already beaten the game have a reason to play, and the same goes for new players.

- **Damage System:** I also made a click-to-damage kind of mechanic where when you click on something, the script sends an event over to another system that checks if the object is or is part of the enemy. If it is, it does damage, and there is a debounce in order to prevent players from spam clicking or using an auto-clicker.

- **Gameplay Systems:** Later on, I also added a camera system where the camera is faced downward onto the character and a system where the game prevents you from jumping. This way, it provides a more RPG feeling and prevents the player from clicking on the enemy from a far distance, and also prevents jumping onto the enemy’s head to avoid damage. I also added a system where if you die, you don't respawn, and instead, the game resets and you are back at square one. You still keep your data, though, because of the database. This is the same for if you purposely reset your character <sup>(Which I do not know why you would do that)</sup> or when you win the game. I also made it so that when you are at the menu screen, you can't move from spawn unless you press the play button. There is also a part called trigger that, if you step on it, closes the entrance to the room because of an event that was sent from the trigger being touched.

- **Enemy AI:**
I coded the enemies to have different behaviors. Enemies have a roaming behavior, where the enemy roams for a certain range if the player isn't in its range; a chasing behavior, which is when the player is in the range of the mob; and an attacking behavior, where the mob attacks and hurts the player by an amount based on what type the enemy is. Balancing the difficulty required me to test a lot to ensure the game remained challenging but fair to new players and players with high levels in the game.

- **GUI:**
I also created a GUI that has all the stats of the player. There is a health bar for the player with a tween that makes losing health look nicer, an XP bar that captures how much XP the player has, a text label for showing the level of the player, a coin counter for the amount of coins the player has, a wave counter for what wave the player is on, and a mob counter for the number of enemies that are currently alive. There is also a menu GUI where there is a frame that covers the whole screen and a play button that lets players play the game.

---

## The Challenges and Solutions for Them

- **Enemy AI:** When I was making the enemy pathfinding system, some of the enemies got stuck, broke, or behaved during testing. I changed and fixed the enemy scripts to account for players in the range of their set view, attacking if they are and roaming if they aren't. This makes their behavior more reliable.

- **GUI Animations:** When I was playtesting the GUI, the tweens from the GUI would not work the way they are intended to. On top of that, some of the frames were kind of lagging behind or desynced from taking damage. I synced the scripts with events from the server scripts, and that reduced the desync and fixed the breaking GUI problems.

---

## What I Learned

When I started on this project, it helped me see where my programming skills are at in Lua and how different it is to code my own. I learned a lot more about how you can implement systems like the **waves**, **events** that travel between scripts, and the **pathfinding logic** for the enemies and how they work; how to manage and balance the player's stats so that it's fair; and synchronize the GUI animations so they look more satisfying and smoother. Beyond the project, I learned a lot of problem-solving and what I should do if I am ever stuck. I also learned how important it is to plan out a project’s layout, and how I can use debugging skills to solve some of the problems in this game.

---

## Future Improvements

This is just a rough start for the project that I made. In the future, I will add more things to this game that will make it more lively, fun, and challenging to play. For example, some of these ideas are:

- I would add more waves and room generation.
- I would introduce more loot variety, traps, and puzzles for more engaging gameplay.
- I would add more visuals, animations, and sound effects to make the environment more lively.

---
