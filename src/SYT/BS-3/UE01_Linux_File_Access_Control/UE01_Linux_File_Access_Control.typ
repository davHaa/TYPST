#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "01_Linux_File_Access_Control";



#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

= A~~~ Objective
#v(2mm)

This lab exercise provides an introduction to access control for files and directories in Linux. 
Our setup will utilize users and
groups of an organization called _Gotham City_ as an example! 

_Note:_ You may already have a corresponding script or completed configuration handy from a previous lab.

= B~~~ Platform and process
#v(2mm)

- You will need a Linux-system where you have superuser (root) privileges (with `sudo` oder `su`) -- please use the prepared Kali VM running (the privileged `sudo`-user is called `junioradmin`)!

- Execute all commands in a terminal window using the standard shell and don’t forget to elevate your privileges first using e.g. `sudo su`!

→ Be sure to provide answers to all questions and to document *each and every* shell command line in your lab notes (lab report)!

= C~~~ Refresh: Creating users and groups
#v(2mm)

#count1[Create the following users, groups and directories (and replace _`NN`_ by the last two digits of your login-number!):
]

#v(10mm)

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#table(
  columns: 5,
  table.header(
    [Username],
    [Name],
    [Login Group],
    [Home Directory],
    [Password]
  ),
  [bossNN],
  [Your Name], [hereosNN], [/home/hereos_NN_/boss_NN_], [I!love!linux!],
  [batman],
  [Bruce Wayne], [hereosNN], [/home/hereos_NN_/_batman], [darkknight], 
  [robin],
  [Dick Grayson], [friends], [/home/friends/robin], [nightwing],
  [catwoman],
  [Selina Kyle], [friends], [/home/friends/catwoman],  [meowmeow],
  [gordon],
  [James Gordon], [police], [/home/police/gordon], [law-n-order],
  [joker],
  [The Joker], [villains], [/home/villians/joker], [whysoserious],
  [penguin], 
  [Oswald Cobblepot], [villians], [/home/villains/penguin], [fish!]
    )
#v(10mm)

Use a simple shell script that has one command per line by using the command `useradd`#footnote[Note the mnemonic trick for the important options of `useradd`: *`G`*etting *`s`*omething *`d`*one *`m`*akes *`c`*harts *`g`*reen ;-)]
(you can use the script you developed in lab "Linux User Management" and adapt it according to the table above.)

_Hint:_ If this is a repetition, there may be a shell script _attached_ or provided online!

#count1[
  Comment each line of the shell script and insert the shell script here _after_ finishing this exercise (or at home).
]


= D~~~ File Permissions -- Commands
#v(2mm)

#count1[By either checking your notes, re-reading the provided hand-out, testing in the shell or having a look at the _man pages_ (you can also use the web for that, e.g. a query for `man chmod` will likely help), lookup any needed information on the following commands:

`ls`, `chmod`, `chown`, `chgrp`
]

And then provide answers to the following questions _(shell commands only!)_:

#count1[How can you have the permissions of a file or directory be displayed?
]

#count1[How can you set or change both the `owner` and `group` of a file using a _single_ command line?
]

_Hint:_ Check the manual pages of the corresponding command in order to answer the next two questions! You may do this _after_ finishing this exercise or at home.

#count1[How can you change the owner of a directory, all files in that directory, all sub-folders and all files beneath the directory using a `single` command line?
]

#count1[What does the parameter `-c` imply when used with `chown` respectively with `chgrp`?
]

#count1[How does `chmod` work on symbolic links _(does it change the permissions of the link itself or the permissions of the link target?)_?
]

#count1[
What is the meaning of the _sticky bit_ for _directories_?]

→ You should verify your answers by actually _testing_ the
command lines on some dummy files in your Linux-VM!

= E~~~ File Permissions -- Lab I
#v(2mm)

#count1[
  Explain the permissions for the files `/etc/passwd`,
    `/etc/shadow`, `/bin/passwd` (or
    `/usr/bin/passwd`, if `/bin/passwd` does not exist),
    `/var/log` and the directory `/home` (who is
    permitted to do what?)? Provide the equivalent octal notation for
    each file!

    _Hint_: Please provide the actual (real) user or group names, don't use terms like "owner".
     Example: "junioradmin may read ...", *NOT* "the owner may read ...".
]

#count1[Review the permissions of the *home directories* created earlier:

+ Who is the owner _(e.g. of _`/home/friends/robin`_)_? What is the name of the corresponding group?

+ What rights have been granted -- "who is allowed to do what" in these directories?
    
    _Important_: (Again) Pls. provide names, e.g. "Robin may..." and not "the owner may...”.
]

#count1[Change the group of the folders above the home directories as follows _(be sure to note down the command lines you used!)_:
]



#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center }
    else { center } 
  )
)

#table(
  columns: 2,
  table.header(
    [Directory],
    [Group]
  ),
  [`/home/friends` ], [`friends`],
  [`/home/villains` ], [`villains`],  
  [`/home/police`], [`police`], 
  [`/home/heroes`_`NN`_], [`heroes`_`NN`_]
    )

= F~~~ File Permissions -- Lab II
#v(2mm)

_(Be sure to take note of the command lines you used!)_

#count1[We want to create shared folders for the work documents of the individual groups of our fictive organization:

+ Create a directory `/data__YY__/friends` (Owner should be `root`), where all members of `friends` can have read and write permissions (so they can work on their documents), but everybody else (except `root`) _has no rights_ whatsoever (all entitled users should of course be able to read the contents of the directory and be permitted to enter the directory).

+ Create the directories `/data__YY__/villains` and `/data__YY__/police`, that feature equivalent rights for the corresponding groups (read/write only for the group, all rights for `root`, group members can use the directory normally, all others have _no rights_)

+ `batman` should be able to use and write to _all_ directories _(owner must still be `root` -- how do you do that?)_!
]

#count1[_IMPORTANT:_ Now comes the critical part of your security setup → _TEST_ your security:

For each of the following operations, consider if the type of access attempted should be possible in theory (if correct permission settings should permit it) and take a note. Then execute the corresponding command and check if the operation succeeds or not, documenting the results as you go! So the task is to write a _test log_ stating -- in a structured manner -- if the operation should succeed, if it worked out or not and if this result is ok (as desired)! 	

+ As user `robin`, create a the file `robin`_`NN`_ in `/data__YY__/friends`. The file shall contain the text "_Robin was here!_".

+ As user `gordon`, create a file in `/data__YY__/police`.

+ Create a new directory called `stuff` in `/data__YY__/villains` as user `joker`.

+ As user `joker`, create a file in `/data__YY__/police`.

+ Working as user `gordon`, list all files in `/data__YY__/friends`.

+ Have `penguin` delete a file in `/data__YY__/friends`.

+ Logged-in as `batman`, list all files in `/data__YY__/friends`,` /data__YY__/police` and `/data__YY__/villains`.

+ Create a file in `/data__YY__/villains` as user `batman`.

+ Can `batman` append the text "_Batman was here as well!_" to file `robin`_`NN`_ in `/data__YY__/friends`? Why/Why not?

+ Now try to delete the file `robin`_`NN`_ in `/data__YY__/friends` as user `batman`! Does `batman` need to have write permissions on the file? Why/why not?

+ With `root`-permissions: Create a directory `/data__YY__/gotham`, that is owned by `batman`, who may create, delete and rename files in this folder. All other users should only have _read_ access (that is, be permitted to `cd` to this directory and list the contents)!

_Hint_: Again, you can easily switch users on the command line by entering `su - ` _`someuser`_ (check with `whoami`),
 executing the command(s) and then leaving the user shell with `exit`. Or just keep a terminal open for each user.

_Recommendation_: Create a _table_ to document your tests! _Example:_
	
#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#table(
  columns: 4,
  table.header(
    [Command],
    [Should succeed?],
    [Did Succeed?],
    [Ok?]
  ),
  [a. su - robin; > /data__YY__/friends], [Yes], [No], [No],  
  [...], [...], [...], [...]
    )

]

_(Obviously, in above example, if real result is not equal to expected result, something's wrong and you need to check
and correct your configuration)_.

_Have fun!_

