# tp23-statistical-illusions# 
[<img src="https://github.com/fgoepp/tp23-statistical-illusions/raw/new_readme_getstarted/main_app/www/illusion.jpeg" width="200" height="133"/>](https://github.com/fgoepp/tp23-statistical-illusions)


# Introduction
bla bli blup
# Getting Started

## 1. Installing R

- Download and install R by going to https://cloud.r-project.org/.
- Windows: Click on “Download R for Windows”, then click on “base”, then click on the Download link.
- MacOS: Click on “Download R for (Mac) OS X”, then under “Latest release:” click on R-X.X.X.pkg, where R-X.X.X is the version number.
- Linux: Click on “Download R for Linux” and choose your distribution for more information on installing R for your setup.
  
## 2. Installing RStudio

- Download and install RStudio by going to https://www.rstudio.com/products/rstudio/download/.
- Scroll down to “Installers for Supported Platforms” near the bottom of the page.
- Click on the download link corresponding to your computer’s operating system.

## 3. Setup Repository 

### Download with git:
- Open your Terminal/Console and enter:
```sh
   git clone git@github.com:fgoepp/tp23-statistical-illusions.git
```

### Download Repository manually:
- Click on <> Code (green Button).
- Select Local.
- Click Download Zip.

## 4. Open Repository in RStudio
- Open RStudio
- ......
## 5. Installing packages for Illusion App
- Open xxxx.R in RStudio
- Click Run App

# Adding your own Illusion

## 1. Adding to UI
Add your illusion to the `menuItem`
```r
# Illusions submenu
menuItem(
...
menuSubItem(
          "Your Illusion",
          tabName = "your_illusion_tab",
          icon = icon("chart-area")
        ),
expand = TRUE # Make the submenu expandable
```
Add your illusion to `tabItems`

Be careful with the String in your UI. 
This String should not be equal to any other String
in the UIs.
This is because of Modules in shiny.
```r
# Tab items
tabItems(
...
      # Your Illusion tab item
      tabItem(
        tabName = "your_illusion_tab",
        tabPanel(
          "Your Illusion",
          h4("Your Illusion"),
          your_illusionUI("your_illusion")
        )
      ),
```
## 2. Adding your illusion to server
add
```r
server <- function(input, output) {
  birthdayServer("birthday")
  lindleyServer("lindley")
  sbServer("sleepingbeauty")
  your_illusionServer("your_illusion")
}
```
be careful that this String needs to be the same as in `your_illusionUI("your_illusion")`
## 3. Adding your illusion modules
now you need to create 2 `.R` files (your `server` and `ui` modules).
As a convention we would recommend to add a new folder at
`tp23-statistical-illusions\main_app\illusions`
let's call it `your_illusion`. 
Create 2 files called `your_illusionUI.R` and `your_illusionServer.R`. 

In `your_illusionServer.R` add
```r
your_illusionServer <- function(id) {
  moduleServer(id, function(input, output, session) {
   
  })
}
```

and in `your_illusionUI.R` add (tagList is just a filler)
```r
your_illusionUI <- function(id) {
  ns <- NS(id)
  tagList(
    h4("Your Illusion"),
    p("This is the UI for Your Illusion tab.")
  )
}
```
you may want to use the layout, but you don't have to
We recommend naming these methods this way so everyone knows what they do (for example in `ui.R` where you already added one of the methods we will add - `your_illusionUI("your_illusion")`).

Be sure to add 
```r
source("illusions/your_illusion/your_illusionUI.R")
```
in the `ui.R`
and 
```r
source("illusions/your_illusion/your_illusionServer.R")
```
in the server
