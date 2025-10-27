// Here we can create a external JavaScript file and link it to our HTML file
// This file is named script.js

// In JS when we should use const and let keywords to declare variables instead of var keyword
// We can write any JavaScript code here
// Declare an aray of Famous cities 

//What is an array?
// An array is a special variable, which can hold more than one value at a time.
// If you have a list of items (a list of cities, for example), storing the cities in single variables could look like this:

const famousCities = ["Indore", "Ujjain", "Bhopal", "Pune", "Mumbai"];

// Function to display the cities in the console
function displayCities() {
    console.log("Famous Cities:");
    famousCities.forEach(city => {
        console.log("-" + city);
    }
    );
}
// Call the function to display the cities
displayCities();

// End of script.js file.