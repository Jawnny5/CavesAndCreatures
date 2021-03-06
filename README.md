Mod1 Project - Caves And Creatures Character Creator
 Jason Easterly and William Neal

**Caves and Creatures Character Creator** is a CLI application that mimics the process of building a character in a "Dungeons and Dragons" like game. Dynamic choices at nearly every step of the process create a user experience that is engaging and unique.


<h1>How to Install and run</h1>

Visit [Caves and Creatures]https://github.com/Jawnny5/CavesAndCreatures and clone the repository down into a local directory. Navigate to the directory and enter the command. Once inside the directory, run the command `bundle install` to install the necessary gems to execute file. Once that is complete run `rake db:seed` to generate new seed data. Lastly run the command `ruby runner.rb` to start the Character Creator.

 Caves and Creatures frees the user of needing to enter commands while playing, only requiring simple user input at times, but mostly allowing the user to make their choices through robust menus.

   **Create New Player** will determine whether or not the user is new to the game and already has created characters. If the user is new, there is a profile created for the user that will save all of the users created characters. If the user has created characters he is forwarded to the main menu.

<h1> How to naviagte the app </h1>
   **Main Menu**
   The main menu contains many options for the user. A quick overview of the options.

   **Create an Avatar** 
   Here the user is able to assign an avatar a name, a race, a gender, a job, and stats including hit points, strength and various otther attributes are randomly     assigned.

   **View and Edit Avatar**
   This menu furthers the user experience with the ability to level up an avatar with stats auto-increased per their job's model, assign their avatar a spell and assign their avatar a weapon. Here you are also able to view all of your avatar's information including level, spells,weapons and stats. You are able to rename your avatar through this menu. The user is provided an option to return to main menu.

   **Delete an Avatar**
   Through this menu the user is able to delete an Avatar.
   
   **Delete User Profile**
   Through this menu the user is able to delete User Profile.
   
   
   <h2>Technologies used</h2>
    <li> Ruby - version 2.6.1 </li>
    <li> Active Record - version 6.0 </li>
    <li> Sinatra-activerecord - version 2.0 </li>
    <li> Rake - version 13.0 </li>
    <li> SQLite3 - version 1.4 </li>
    <li> Rest-client - version 2.1 </li>
    <li> JSON - version 2.3 </li>
    <li> tty-prompt - version 11.1 </li>
    <li> Colorize - version 0.8.1 </li>
    <li> figlet - version 1.1 </li>
    <li> artii version 2.1 </li>
   <br>
   
   <img src="https://i.ibb.co/P46JyKq/Screen-Shot-2020-10-02-at-11-11-25-AM.png" alt="CnC3">
   <img src="https://i.ibb.co/fqc0tqt/Screen-Shot-2020-10-02-at-11-10-55-AM.png" alt="CnC2">
   <img src="https://i.ibb.co/g9xxC04/Screen-Shot-2020-10-02-at-11-10-35-AM.png" alt="CnC1">
  
**Api Reference**
<br>
[D&D 5th Edition SRD API](https://www.dnd5eapi.co/)
