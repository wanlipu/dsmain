# Dunder Data Precourse Assignment
This repository contains a precourse assignment that is intended to get everyone on the same page upon entering the class so we can quickly dig into the material. It will cover installation and basics of git/github, installation of Anaconda and intro to jupyter notebooks and a quick review of the python programming language.

# Installing Anaconda
We will be using the excellent and free Anaconda python distribution to install all the popular data exploration libraries (along with hundreds more other popular ones). Python has been undergoing an agonizingly slow change from python 2 to 3 though python 3 came out more than 7 years ago. Currently, nearly all major libraries have python 3 support so please [download Anaconda for python 3.5](https://www.continuum.io/downloads). Use command `conda install <packagename>` to get new packages and `conda update --all` to update all packages. There is of course plenty more you can do [with conda](http://conda.pydata.org/docs/using/using.html) including setting up different environments for python 2 and 3 separately.

# Git
Since you have access to this repository you have already successfully created a github account. To get the most out of this course you will need to install [git](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics), a very popular open-source version control system that takes snapshots in time of what your current project looks like. Git itself can be very complex and there are many books written on just how to use git but we don't need anything except the very basics for our purposes. 

## Git vs Github 
Github is a private company that hosts your git repositories online for others to view and collaborate with. Git is your local version control system that keeps track of all local file changes. In this course you will be using github to bring our online repositories to your local machines where you will make changes(i.e. complete the assignments) and push those changes back to us where we will be able view and comment on your assignments.  

### Let's get started with git!
1. [Download git.](https://git-scm.com/download) I believe both mac and linux machines should have git pre-installed.
1. If you've never set-up git before, you need to set your username and email. [Go here](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#Your-Identity) and follow the short instructions if this is the first time you have ever used git.
1. Fork this repository by going to the top right corner of this page and clicking fork.
1. Clone this repository to your local computer. Above the file listings towards the top of this page you will see a small text box with the url of this repo with .git appended to it. Click the little clipboard icon to copy the url.
1. Open a terminal and go into a directory that you'd like to save all your work for this class. Perhaps call it `Dunder Data Python Class`
1. Once in that directory, type in `git clone https://github.com/<your username>/precourse-assignment.git`. This will pull all the files down into your local file system. You now have an exact replica of what you are reading here on github.

### Submitting your first assignment on github

1. For this precourse assignment, you will be modifying exactly one file. The `precourse.ipynb` file.
1. As your are making changes to this file locally, it is a good idea to be continually committing your changes and pushing them to github.
1. Run `git add precourse.ipynb` to tell git this is the file you would like to be committing
1. Run `git commit -m "I have finished the section on lists"` to commit your file locally and 'take a snapshot'. Always add messages to your commits with `-m "<your message here>"`
1. Run `git push origin master` to push your changes to your remote repository on github. Check github to make sure the remote file precourse.ipynb has your changes
1. repeat steps 3-5 several times during the precourse assignment to ensure you don't lose your changes
1. When you have finished the assignment and are ready to submit it, go to the top of this page and click the green button `New pull request`
1. Add a message to your pull request and click `Create pull request` to submit your assignment
1. The instructors will then be able to view your changs and make comments

# The Actual Assignment!
OK, so you've installed Anaconda and git and are ready for your precourse assignment. As you can see at the top of this page, there are only two files in this repository. The README file that your are reading right now and the `precourse.ipynb` where the magic happens. To begin your assignment, open a terminal and cd into the directory where this file is and run `jupyter notebook`. Click on the precourse notebook link and a notebook will open that will walk you through the entire assignment.

Remember to always be committing and make a pull request when you are done. Please finish the assignment by Wednesday so the instructors can give you feedback.

