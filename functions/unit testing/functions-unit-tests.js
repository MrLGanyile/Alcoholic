const test = require('firebase-functions-test')({
    // I'm not sure about the below line.
    databaseURL: 'https://alcoholic-expressions.firebaseio.com', 
    storageBucket: 'alcoholic-expressions.appspot.com',
    projectId: 'alcoholic-expressions',
    // The path need to use '\\' instead of '/'.
}, 'C:/Users/Mesul/Desktop/Alcoholic/alcoholic-expressions-433209-03509475cf98.json'); 

// after firebase-functions-test has been initialized
// relative path to functions code
const myFunctions = require('../index.js'); 