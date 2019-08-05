# SnapStudy

## Description & Features

In plain, SnapStudy allows users to take or upload photos of subject text and have the app automatically create a personalized set of Flashcards that come with Keyword, Definition, and the addition of an optional drawn image. SnapStudy comes with an array of features that put an emphasis on personalization, efficiency and accessibility. Click on the '+' icon to create a new Flashset, and upload/take pictures of however many photos in the current session.

The OCR used is an open source [Tesseract](https://github.com/gali8/Tesseract-OCR-iOS) Project for iOS, from which extracted keywords will be generated per page based on a [TextRank](https://www.aclweb.org/anthology/W04-3252) NLP algorithm.

Notable Features Include:
* Keyword/Definition from Merriam Webster Database
* Optional Paint Feature to add depth/personal images to Flashcards
* Audio of Words and Definitions
* Personalized Quiz for Unique set of Flashcards
* Upload/Snap Consecutive Pages for one upload
* Toggle Specific Extracted Words and Add Additional Words to be used in creating Flashset
* Name your Set and Index by Date
* Toggle Dyslexie Friendly Font for Whole App Usage
* Toggle Dark Mode for Study Game

## Installation and Download
Note: make sure that cocoapods is downloaded on your computer to run the Podfile

1. Download/Clone the Repo
2. cd into the Root Repository Folder SnapStudy/ in terminal
3. run the command
```
pod install
```
4. open up the xcworkspace, make sure to run on iPhone Xs template!
5. Enjoy!
