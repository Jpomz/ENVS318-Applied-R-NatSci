---
layout: page
element: notes
title: Project Setup
---

### R Studio Projects

* Way of organizing related scripts, data, etc. 
* Think of it as a giant folder which will contain everything for this course  

  * Other courses would be other projects  
  
  * Gradschool: Each chapter or experiment might be it's own projects  
  
  * Professional: i.e., if you work for the Forest Service, might have a project for wildlife data, one for water quality monitoring, one for timber sales, etc.  
  
* Projects are self-contained and self-referential  

  * Make project stored on your desktop, then move it to your Documents folder: project will still work  

### Create Project

1. Create an ENVS396 folder somewhere on your computer  
  * Could be on Desktop, in your Documents, etc.  
  * Doesn't matter, as long as you know where it is.  
  
2. Open RStudio  
3. Click on `File` --> `New Project` --> `Existing Directory` then `Browse` and select your "ENVS396" Folder.  
4. Check that you can see "ENVS396" in the top right corner of RStudio  

  * When you are taking notes in class, working on homework assignments, etc., **ALWAYS MAKE SURE YOU ARE IN THE CORRECT PROJECT!** i.e., check that is says "ENVS396" in top right corner
  
#### Worskpace save option: Never  
* **Never** save your work space image
* Click on `Tools` --> `Global Options` and select the `General` tab  
* Under the "Save workspace to .Rdata on exit:" option, select `Never`

#### Saving scripts  
* Always manually save the script you're working on by clicking on the floppy disk icon or pressin `Ctrl` + `S` on a laptop or `Cmd` + `S` on a Mac
  
#### Open project  
* Always make sure to open up the *project* (icon is a little blue box with R inside of it, and file extension is `.Rproj`) at the beginning of class or when you're working on it at home  
* If you try to just open up a script, it will open it in "project-none" directory  
  * When you save, it will go to whatever default directory is set up
  * In other words, it may be hard to find, and you would then need to copy/paste your updated document back into your project  
  * Avoid this by always opening up the project

### Organize Project with Subfolders  

* In the "Files" pane, press the `New Folder` button and create the following folders (make sure spelling/capitalization matches exactly):  
  * `Scripts`  
  * `Data `  
  * `Assignments`  
  * `Other_Resources`  

#### Filenames  

* R doesn't always do well with spaces in file names
* avoid potential issues by using "_" or "-" in file names instead of spaces  
* Don't use any other special characters like `.`, `,`, `@`, `!` 
* Don't begin a file name with a number  

* **Do**: 
  * "Other_resources" 
  * "last-name_homework-1"
  * "data-table-notes" 
  
* **Do NOT**: 
  * "Other resources" 
  * "2nd week home work, lastname"
  * "data-table-notes" 
  
### Scripts  
* Take notes and write code live demo'd in class  
* Make a new script by clicking the `New File` button or using the `Ctrl-Shift-N` keyboard shortcut (`Cmd-Shift-N`) on Mac  
  * Add the following code to your script:

```
# my first script
2+2
x = 5
x
```

* save your script by clicking on the floppy disk icon or pressing `Ctrl` + `S` on a laptop or `Cmd` + `S` on a Mac  
* name the file "my-first-script.R' and make sure to save it in your "Scripts" folder  

### Data  
* Save all necessary data files here  
* We will be working with lots of data files in this class  
  * Most files will be comma-separated-value files or plain text files (.csvor .txt file extensions, respectively) 
* Go to the [Datasets]({{ site.baseurl}}/materials/datasets) section of the website and download the "Portal Surveys csv" file  
* Make sure to save the file in the "Data" folder and that the name is "surveys.csv"  
* Go to the "Files" pane in Rstudio and make sure you can see the `surveys.csv` file in the Data folder  

### Assignments  
* Folder to store all of your homework assignment scripts  
* Make a new script in the same way as above 
* Make sure to save it in your "ASsignments" folder and name it accordingly  
  * i.e., "Pomeranz_HW1.R"
  
### Other Resources  
* Optional folder
* Good place to save RStudio cheat sheets and other references 
* Click on `Help` --> `Cheat Sheets` --> `Data Transformation with dplyr` 
  * Should automatically prompt you to save the file  
  * Make sure to save it in your "Other_resources" folder  