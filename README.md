# WT Geography Play

Game to play with topics of interest from a geography perspective.

The idea was to build a map component that made it easy to build map related games.
- there is a canvas with a map on it, that can be zoomed, panned and made to fit screen.
- there is a title bar at the top to prompt for actions to be done.
- there is a footer bar that can git the user options to select
- there are overlay panels that can be hidden, to display game state and scores.

This game was built as a hobby project with my daughter, over the cause of a few days, as a
proof of concept.

It is designed for the iPad aspect ration, so when running in the web, you may need to resize 
the window to make things layout nicely.

## Explore Map

Hover over countries to be told what they are and toggle their selection.

## Navigate Between

When the refresh button is clicked (top right), two random countries are selected, buttons are
created in the bottom bar, and a goal is displayed in the top left to navigate between the countries.
The user selects the buttons at the button to pick the next country to select, which causes the country 
to be highlighted and the buttons are updated with the new country's bordering countries.

## Find Country

A country is randomly chosen for the user to find and click on. The app keeps score and displays 
in an info panel at the bottom.

## Guess Country

This is a work in progress.

## Find Dinosaurs

Select a country, and buttons appear at the bottom of all of the dinosaurs that have been 
found in that country. Selecting the button will open up a browser tab, with information
about that dinosaur. 

A panel on the right also keeps track of all of the dinosaurs that have been found.