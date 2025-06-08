#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "00_Linux_User_Mgmt";



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

This lab develops the skills to add and manage users and groups with the
Linux operating systems using shell commands. Further, the lab will look
behind the scenes of user management in Linux by analyzing the content
of the corresponding configuration files. In the second part of this
lab, as a more real-world example, we will create the users of a small
company called _Gotham City_!

= B~~~ Platform and process
#v(2mm)

- You will need a Linux-system where you have superuser (root) privileges (with `sudo` or `su`) -- employ one of the prepared VMs running e.g. Kali Linux (the privileged user is called kali or junioradmin)!

- Execute all commands in a terminal window using the standard shell and don’t forget to elevate your privileges first using e.g. `sudo su`!

→ Be sure to provide answers to all questions and to document *each and every* shell command line in your lab notes (lab report)!

= C~~~ Existing users
#v(2mm)

#count6[
A _regular_ linux user belongs to many groups.

+ Which group(s) are you in the (virtual machine) in? _Hint_: use the `id` command.

+ Why are there so many groups?
]

= D~~~ Creating a new user
#v(2mm)

#count[Create a new group called `heroes`_`NN`_ ! Note: replace _`NN`_ by the last two digits of your login-number! Which (simple) command line did you use to create the new user group?
]

#count6[Changes

+ Which (text) file in `/etc` received a new entry as a consequence to step (2)?

+ List the corresponding line from the `group` file using the command `grep`!  

  Command: 

  Result:


+ What is the `group id` of the group `heroes`_`NN`_?

+ Try the following command lines -- what is the purpose of each?
       
      ```bash
      getent passwd 
      getent group 
      ```
]

#count6[Create a new user with the following specs -- use only _one single_ shell command line:

- User name: `max`
- Full name: `Max Headroom`
- Home directory:`/home/max`
- Shell: `/bin/bash`
- "Main" group (= _Login Group_): `heroes`_`NN`_

+ What command line did you use to create the user#footnote[note the mnemonic trick for the important options of `useradd`: *`G`*etting *`s`*omething *`d`*one *`m`*akes *`c`*harts *`g`*reen ;-)] 

+ What (text) system files consequently received new entries - enter the absolute path?
    List the corresponding lines from the `passwd` file using the command `grep`!

+ What is the (numerical) user id of user `max`?

+ Is it already possible for the user `max` to login?
]

#count6[Configure a _secure_ password for user `max`!

+ How did you do that?

+ What text file in `/etc` was changed when adding the password? List the corresponding line with `grep`!
    Which command did you use?
]

#count6[Try to login with user name `max` -- does it work? _(If not, what error message do you receive? See (7) )_
 
+ … with the command `su - ` _` username`_. What does the command `su` stand for?

    Does it work?

      
+ … via the network using `ssh`#footnote[you may need to install & activate an SSH-Server first, you can do this using `sudo apt-get install openssh-server` and `sudo systemctl start sshd`]: `ssh ` _` username`_`@localhost`

        Does it work?

+ If a) and/or b) work, try to login by using the graphical user interface (GUI)!

        Does it work?
]

#count6[
  *Only if (6) did not work (couldn’t login):* Check if perhaps the home directory of `max` does not exist at all _(how do you check this?)_ or if maybe the password has not been set _(where would you check this?)_

- If the home directory does not exist (you may have missed to pass the correct option to `useradd`), you will need to create it using `mkdir`. The _owner_ should be `max` -- and `max` should have all permissions to his own directory -- does the login work now?

- So what was the cause of the problem?

Does it work?
]

= E~~~ Creating multiple users

#count6[Create the following users, groups and directories on the system:

+ … with the help of a simple _Shell Script_ (include it in your lab report -- you will need it again later!): 

        _Hint 1_: It is easiest to create the script file with an _editor_ (`vi`, `nano`, `gedit`...). For each
        new user, enter a `useradd` command per line. You can
        execute the script with `sudo sh scriptfile`, you don't need `sudo` in
        front of each line in your script!

        _Hint 2_: It is a good idea to create both the groups
          (`friends`, `heroes`_`NN`_, …) and the higher-level
          folders (`/home/friends`, `/home/heroes`_`NN`_, …)
          _first_, before adding the users!

        _Hint 3_: You may want to automate adding passwords by entering
          them directly in the script file _(what is the potential problem
          here?)_ -- to achieve this, you _cannot_ use the `passwd`
          command, as it expects input directly from the console. Use the
          command `chpasswd` (which reads from standard input, which
          in turn can be redirected from a pipe) instead, e.g.:

           `echo ` _`username`_:_`password`_ ` | chpasswd`

        _Hint 4_:
            It would be smart to make backup copies of all three
            (important) user management files in `/etc` before
            creating the groups and users -- _how do you do that?_

+ List of users: Note: replace NN by the last two digits of your login-number!
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

#count6[
+ Ensure that all users (including their home directories) have been successfully created -- you can test this by logging in via the GUI or directly in the terminal using `su - ` *`username`*!

+ How secure are above passwords?

+ Your script to create the users

+ Write and test a second script file that _deletes_ all the users, groups and directories again! Insert your script as text here:

]

#count[
  _Bonus_ ;-): Who is/was Max Headroom? Where does his name come from?
]

_Have fun!_