# Hangman

Welcome to the Hangman Challenge by Enrique Torrendell. General information about the game can be found on https://www.thehangmanchallenge.com/. 

Inside the actual game code you will find comments that explain what each method functionality is. The Hangman was made in Swift and I used Firebase as the back end.

## THE GAME

The game has 3 ways of being played: Single, Challenge and Multiplayer. 

#### Single

To play the single game, just go to single and start playing. Once you finish, the system will show if you won or lost and the amount of points that you earned.

#### Challenge

You can only play the challenge game once per day. Once you finish the word of the day, you will not be able to play the challenge mode until the next day. 

#### Multiplayer

Once you enter multiplayer mode, you can create a game or play an active game. To create a game, just click on "Create Game" and you will be able to set a title and select up to 3 friends. Then pick the amount of words you want to compete. Creating your own multiplayer game will allow you to have a small leaderboard where you can compete against your friends and track how many points and rounds each user did. Eventually in a future update the idea is to include a chat so you can have fun with your friends.

## HOW TO SETUP THE GAME

1) Click the green "Clone or download" button

2) Click in Download ZIP

3) Open the ZIP file

4) Open Hangman.xcworkspace file with Xcode.

5) If you install the game with these instructions you will have to install the Google plist file. 

5) The game works with iPhone SE, iPhone 7 and iPhone 7+. I recommend running the simulator with iPhone 7.

## INSTRUCTIONS (VIEW BY VIEW)

#### Welcome View:

On the welcome view, after the animation, you will be able to login or register. 

#### Register View:

Put your email, your username, a profile picture and a password. Once you click on the register button, it automatically runs the same methods as the login view. 

#### Login View:

On the login view, just enter your email and your password. Once you get in the app, your information gets saved and you don't have to put it in ever again unless you installed the app.

#### Main View:

It has different options - Single, Challenge, Multiplayer, Leaderboards and Settings. Each one segues to the selected view. 

#### Single Game View:

It goes to the Game View (using the type of game "single") where you are going to be able to play the game. Your final score gets recorded and will hit the Single Game Leaderboard.

#### Result View:

Once you finish playing a game, you get a result view showing your score and the status that you won or lost.

#### Challenge Game View:

It goes to the Game View (using the type of game "challenge") where you are going to be able to play the game of the day. Your final score gets recorded and will hit the Single Game Leaderboard. 

#### Message View:

If you try to enter to the Challenge of the day again, you will get the message saying that you already played that day. 

#### Settings View:

It allows you to change the background color of the game, change your profile picture and name, leave feedback, get some help to understand the game and logout.

#### Multiplayer Game:

Once you click in Multiplayer, you are going to be able to see three options. Create Game, Active Games and Finished Games. 

- Create Game allow us to create a new multiplayer game.
- Active Games shows the games that we can still play.
- Finished Games shows the games where we can't play anymore but we can check the score and see if the other players finished too.

#### Create Multiplayer Game View:

It allows you to pick a title for the game, choose up to 3 friends to compete and set the amounts of words you want to compete with. Once done just click on Create Game. 

#### Info Game View: 

In here you are going to be able to see the evolution of your multiplayer game - the players, the points and the amount of rounds they already played. It will also show you the position to see who is winning.

#### Leaderboard View:

It let you pick Single, Challenge, Multiplayer to see the list of the people and their points. It orders them by position. Also, it'll always show your position and score in case there are thousands of players. 

## BUGS

1) The picker in photo album is not showing the Cancel button 

2) The built in dictionary is not showing the go back button 

3) Sometimes the dictionary doesn't have the definition of a word and it will simple do nothing. Need to implement an Alert message to handle that error.

4) When you finished playing a multiplayer game, the view goes back to the Main view instead of the Info View.

5) If the user changes the name or picture from Setting View the app will jump to the Main View instead of staying in the Setting View.

6) If you launch a game very fast it may happen that the dicitonary didn't download yet (very rare ocassion). I should put a closure on Welcome View to fix this. 
