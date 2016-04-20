# Homework 06

## Jackpot

Create a single view application that shows a table view as its main interface to the user. Provide a Navigation Controller to handle view transitions (we'll add these later). Add an "add" button to the navigation bar that when tapped, will generate a quick pick lottery number and place it in a cell in the table view.

Quick pick is defined as a lottery number that is randomly generated. A lottery number is 6 integers that are within the range 1 through 53. Picking a number does not preclude it from being picked again for another of the 6 in the sequence.

Create a Class called Ticket that stores the first and last name of the ticket holder as well as the actual lottery ticket. This must be a separate class in your project.

###Objectives
* [ ] Create a UIBarButtonItem "CheckWinners" on the left that creates a winning ticket and compares all of the current tickets to that winner and updates the cells.
* [ ] If a ticket is a winner make the payout text green.
* [ ] If a ticket is not a winner, make the payout text red.
* [ ] Sort the numbers in each ticket so that they are in ascending order.
