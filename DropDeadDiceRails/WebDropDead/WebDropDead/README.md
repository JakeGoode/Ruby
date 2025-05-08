# README

To get the server running:

* rails server -d -p 33123 -b 0.0.0.0

Webpage:

http://cis3260.socs.uoguelph.ca:33123/page_name

http://cis3260.socs.uoguelph.ca:33123

As a full flow of the webpages:

When first ariving at the site, "Hello World!" is display along with a button to sign-in/sign-up. After clicking the button, you are presented with the "Sign-In" page where you are able to either sign-in or sign-up. After signing in or signing up, the user is provided the "User" page with three buttons to play a new game, view the game history (not implemented) and to go back to the "Sign-In" page. When the play new play button is clicked, the user is able to enter the number of players, dice, and dice sides and click the submit button to play the game with those values. The game is ran and displayed on the web page along with the options the play the game again the with original values entered, change the values, or go back to the "User" page.

The details provided on the assignment 2 document have been implemented. The following pages have been implemented:

* "Hello" Page

    * The root page displaying "Hello World!"

    * Provides a button to move onto the "Sign-In" Page


* "Sign-In" Page

    * Provides full funtionality to either sign in or sign up. Error handling has been implemented to user names and email's are unique for each account and emails need to be formatted correctly "using @" to be able to sign in.

    * If the user sign in without signing up first, an error is displayed notifying them to sign up first.

* "User" Page

    * The three buttons outlined on the assignment doc are fully functional and mvoe to the correct pages when selected.

* "Play Game" Page

    * The user is able to provide the number of players, dice, and dice sides with correct error handling if there are less than 2 players and dice, and less than 6 sides on the dice. These errors are displayed on the webpage.

    * When the user submits the filled out fields once everything is correct, the fields are replaced by the played out game alogn with three buttons to play the same game again, change the settings of the game, and to go back to the "User" Page.

    * The game are not stored into the game history page as this has not been implemented.

* "Game History" Page

    * The full implementation has not been created for this. A landing page has been created so the user can move between pages when they click the "View Game History" button on the "User" page.

    * A button on this page has been created to move back into the "User" Page.
