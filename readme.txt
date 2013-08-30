Author:  J. Pedone (jpedone@flash.net)

Copyright:  This program is provided free as is with no warranty whatsoever under the terms of the GPL.  Basically that means you can use it, modify it and distribute it.  If you do modify or distribute it, the new source must accompany the distribution.  Plus, I would appreciate a copy of any changes.

What it does:
Run.exe is a simple program launcher simliar to the win9x run dialog.  It will store the last 10 commands you ran.  It is set up to open a file with the default association or to run a program if a program is passed.  If the browsers are entered, it will also launch your browser and try to connect to a URL if http, www., ftp: or ftp. are the first four characters entered.  

Note 1: Here's neat trick to make the program appear in your warpcenter but not on your desktop:
After a program object is created, open the desktop properties and go to the "Include" tab.
From there you can add a rule to exclude the object you created.  This will make it "disappear" from the desktop but still be available to the warpcenter.

Requirements:
Requires OS/2 REXX to be installed.  

Usage:
Click on the icon.  This is meant to be a simple CLI for when you want to quickly run a program or open a file/location.  I personally keep it on my desktop so that it shows up in my warpcenter.

Usage options:
None

Installation:
Unzip the file into a directory and make a program object. Or, if you would like the program objects created for you, type 'install' at the command line.

Additional programs/files:
run.ini - A standard OS/2 ini file that contains the browser info and the last 10 commands used.  This file also contains any saved preferences.

Known problems:
1.  The task list sometimes pops up momentarily when launching a PM program.  The longer a program takes to launch, the more likely this will happen. (i.e. count on it with netscape.exe)  A longer delay can be added to correct this but may not be desireable.

History (changes from original version):
1.  Changed the dialog box to select the last program ran.
2.  Changed the file-open filter to look for all files
3.  Added a check for a blank program entry to avoid a syntax error.  Run will now exit with rc=1.
4.  Added the ability to open a file by association as well as open a URL. (Thanks to Wayne Swanson <psoft@tech-center.com>)
5.  Fixed a delay problem when opening web pages where the run dialog would stay up after clicking OK.
6.  Changed the syntax to run under classic rexx as well as object rexx after my E-mail box was flooded :-)
7.  Squashed a bug that prevented it from being run properly from a root directory. (Many thanks to Mark Davidson for his patience).
8.  Increased the browser file name length. (Thanks go to Michael Taylor for reporting this.)
9.  Allowed a parameter to be passed to the called program.
10. It will now search the path for exe, com, cmd and bat files (in that order) if no path or extension info is given.
11. Added some intelligence to the history sort.  
12. Added the ability to launch the browser if www. or ftp. are entered.
{For 11 and 12 - Many thanks to the gentleman that helped suggest and debug these features.  Unfortunately, I did something stooopid and lost all of the e-mails pertaining to those changes.  If it was you - please let me know so I can give you credit. .}
13. Added the ability to specify a working directory for the ini files other than the working directory.  The user can optionally put a working directory into the program object PARAMETERS field.
14. Fixed a bug that was introduced when I did number 11.  =8-o  (Thanks to Mike Reichel for reporting these two)
15. Changed the history and browser info to use a regular ini file.
16. Added the ability to use parameters with the browser info.
17. Hid the dialog as soon as a program tries to run.
18. Fixed a bug when using <wp_nowhere>
19. Fixed an object rexx/classic rexx syntax bug when using casless syntax (Thanks to Thomas Ludewig for reporting this)
20. Added some menu items and updated the ini file structure.
21. Mode the dialog system modal so it stays on top.

- Wow, this list is getting long 8-/  Thanks to everyone for the testing help!

22.  I caved and added a default browser - it is now x:\Netscape\Program\Netscape.exe (x is your bootdrive)
23.  Found another reason to hate modal dialogs and undid number 21.  The system modal setting was causing the dialog to get stuck (and lock up the system) when it was minimized.
24.  Corrected some focus problems.
25.  Fixed a bug that stopped parameters from being passed (Reported by Duncan Way)
26.  Made the dialog smaller and finally added a cancel/exit button.  Thanks to Thomas Ludewig for the suggestion.
27.  Added version numbers after suggesting the sme to Keith Cotroneo.  
     Keith BTW is making a real kick butt FTP program - Keep an eye out for Dragen FTP !
28.  Fixed a file extension and minimize problem reported by Sergey Posokhov.
30.  Added the ability to save the window position - just because.