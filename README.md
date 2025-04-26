<p align="center">
  <img width="200" height="200" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIgExQzqogNdKC7uojGWf0ulHKKUPSAJMB7w&s">
</p>

# MEDS Training Tutorial By Navaal Noshi
###
- [x] Shell Scripting
- [x] Vim Commands
- [x] Git branching
- [x] Markdown File
- [ ] Make File
- [ ] Verilator
- [ ] GTKWave
 

# **What is shell?**

A shell script is a computer program designed to be run by the Unix shell, a command-line interpreter. The various dialects of shell scripts are considered to be scripting languages. A shell usually interprets a single line of input, but we can also create a file containing a number of lines of commands to be interpreted. This file is a program known as a shell script. The program can also contain control structures (if-then, loops). Shell scripts allow a sequence of commands to be executed automatically

## *Type of Shells:*

To view the different types of shells supported by your system, navigate to /etc/shells and press Enter. This will display a list of all the shells available. For example, on my Ubuntu operating system, it supports `sh`, `dash`, `bash`, and `rbash`. Among these, we will focus on **bash (Bourne Again Shell)**.

## What is bash?

**Bash stands for Bourne Again Shell**, an enhanced version of the original Bourne Shell (sh). It is the default shell for most Linux and Unix-based systems, including macOS and Windows 10 (via WSL). Bash is intuitive and flexible, making it a popular choice for scripting.


## *Check Supported Shells*:
To see the shells supported by your system:

1. **Open the terminal (e.g., press Ctrl + Alt + T in Ubuntu)**.

2. **Run: `cat /etc/shells`**

To locate where Bash is installed, type:

```
which  bash
```

# *Creating and Executing a Script*:

1. **Navigate to a directory (e.g., `cd ~/Desktop`)**.

2. **Create a new script file using the touch command:**
```
touch hello.sh
```
While the .sh extension isn't mandatory, it's a good practice for clarity.

3. **Open the script in an editor (e.g., Visual Studio Code, gedit, Vim, Nano)**:
```
code hello.sh
```
4. **Write the following script**:
 ```
 #!bash/bin/bash
 echo "Hello,Navaal!"
 ```
The first line, #!/bin/bash, is the shebang. It tells the interpreter that this is a Bash script.

5. **Save the file and close the editor.**


6. **Make the script executable:**

```
chmod +x hello.sh
```
7. **Execute the script**

```
./hello.sh
```
## **Navigating Directories**:

1. ### **cd (Change Directory):**

- Used to navigate between directories.
Example:

```
cd /home/user/documents  # Go to the documents directory
cd ..                    # Move one level up
cd ~                     # Go to the home directory
cd -                     # Go to the previous directory
```
2. ### **ls (List Files and Directories):**

- Used to display the contents of a directory.
```
ls -l  # Detailed view with permissions, owner, and size.
```

3. ### **mkdir (Make Directory):**

- Used to create a new directory.
```
mkdir my_folder
mkdir -p parent/child  # Create parent and child directories
```

4. ### **rm (Remove Files):**

- Used to delete files or directories.
```
rm file.txt        # Remove a file
rm -r my_folder    # Remove a directory and its contents
```

5. ### **rmdir (Remove Empty Directories):**

- Used to delete empty directories.
```
rmdir empty_folder
```

## **File Manipulation**:
### ***Viewing Files***:

1. ### **cat (Concatenate and Display Files)**:

- Used to display the contents of a file.
```
cat file.txt
```
### **Copying and Moving Files**:

 ### 1. **cp (Copy Files/Directories)**:
```
cp source.txt destination.txt
cp -r source_folder/ destination_folder/  # Copy directories
```

 ### 2. **mv (Move/Rename Files/Directories)**:
```
mv oldname.txt newname.txt  # Rename a file
mv file.txt folder/         # Move a file to a folder
```
# **Working with Text Files**:
### 1.  ***grep (Search for Patterns in Files):***
- Used to search for specific text patterns in a file.

```
grep "pattern" file.txt
grep -i "pattern" file.txt  # Case-insensitive search
grep -r "pattern" folder/   # Search recursively in a directory
```

###  2. ***Cut and paste:***
- cut: Extract specific fields or columns from text.
```
cut -d ',' -f 1 file.csv  # Extract the first column (comma-separated)
```
- paste: Combine lines of files.
```
paste file1.txt file2.txt > combined.txt
````
## **Shell Scripting Basics**:

## ***Writing a Simple Script***:
1. ### ***Create a Script File:***
   https://github.com/navaalnoshi/MEDS-Training/edit/main/README.md#L42


3. ### ***Backup a Directory:***

```
#!/bin/bash
src="/home/user/documents"
dest="/home/user/backup"
cp -r $src $dest
echo "Backup completed successfully!"
```
3. ### **Variables**:

## Types of Variables 

1. ### ***System Variables***:

- Defined and maintained by the operating system.

- Conventionally in uppercase.

- Accessed using $ before the variable name.
Examples:

```
$BASH  #Bash shell name.

$BASH_VERSION  #Bash version.

$HOME #User's home directory.

$PWD # Present working directory.
```

2. ### ***User-Defined Variables***:

-Defined by the user.

-Can store strings, numbers, or other data types.

### *Rules*:

-Start with a letter or _.

-Avoid starting with numbers.

-Case-sensitive.

```
name="Navaal"
echo "The name is $name"
```
4. ## ***Loops***:

- ### *for Loop:*

```
for i in 1 2 3
do
  echo "Number: $i"
done
```

- ### *while Loop:*
```
count=1
while [ $count -le 5 ]
do
  echo "Count: $count"
  count=$((count + 1))
done
```
5. ## ***Conditional Statements***
```
num=10
if [ $num -gt 5 ]
then
  echo "Number is greater than 5"
else
  echo "Number is 5 or less"
fi
```
# **Comments**:
### ***Purpose***: To provide information or documentation within the script that is not executed.

Syntax:
   1. Single-line comments: Start the line with ` #`.
 
 ```
 Example: # This is a comment.
 ```
   2. Inline comments: Add `#` after some code.

```
Example: echo "Hello" # This prints Hello.
```




