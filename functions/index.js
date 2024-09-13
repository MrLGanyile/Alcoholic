"use strict";

// [START all]
// [START import]
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
import { logger } from "firebase-functions";
import { onRequest } from "firebase-functions/v2/https";
import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";

// The Cloud Functions for Firebase SDK to set up triggers and logging.
import {onSchedule} from "firebase-functions/v2/scheduler";

// The Firebase Admin SDK to access Firestore.
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

initializeApp();

// To be deleted.
export const addmessage = onRequest(async (req, res) => {
  // [END addmessageTrigger]
  // Grab the text parameter.
  const original = req.query.text;
  // [START adminSdkAdd]
  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await getFirestore()
      .collection("messages")
      .add({original: original});
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
  // [END adminSdkAdd]
});

// To be deleted.
export const makeuppercase = onDocumentCreated("/messages/{documentId}", (event) => {
    // [END makeuppercaseTrigger]
    // [START makeUppercaseBody]
    // Grab the current value of what was written to Firestore.
    const original = event.data.data().original;
  
    // Access the parameter `{documentId}` with `event.params`
    logger.log("Uppercasing", event.params.documentId, original);
  
    const uppercase = original.toUpperCase();
  
    // You must return a Promise when performing
    // asynchronous tasks inside a function
    // such as writing to Firestore.
    // Setting an 'uppercase' field in Firestore document returns a Promise.
    return event.data.ref.set({uppercase}, {merge: true});
    // [END makeUppercaseBody]
  });

// To Be Deleted.
export const saveStore = onRequest(async (req, res)=>{
    // [END savestoreTrigger]
    
    // [START adminSdkAdd]
    // Create a document reference in order to associate it id with the stores's id.
    const docReference = getFirestore()
    .collection("stores").doc(storeOwnerPhoneNumber);

    // Grab all parameters, then use them create a store object.
    const store = {
        storeOwnerPhoneNumber:req.query.storeOwnerPhoneNumber ,
        storeName:req.query.storeName,
        storeImageURL:req.query.storeImageURL,
        sectionName:req.query.sectionName,
        
        lastWonPrice:null,
    };

    // Push the new store into Firestore using the Firebase Admin SDK.
    const writeResult = await docReference.set(store);
    // Send back a message that we've successfully written the store
    res.json({result: `Store with ID: ${writeResult.id} ${store.storeOwnerPhoneNumber} added.`});
    // [END adminSdkAdd]
});

/* Each time a new store is created, it has to have a corresponding store 
name info document which is responsible for holding information that users 
will be seeing, like a store's current state(hasNoCompetition, hasUpcommingCompetition, etc.) 
for example.*/
export const createStoreNameInfo = onDocumentCreated("/stores/{storeOwnerPhoneNumber}", async (event) => {

    // Access the parameter `{storeId}` with `event.params`
    logger.log("From Params Store ID", event.params.storeOwnerPhoneNumber, "From Data Store ID", event.data.data().storeOwnerPhoneNumber);

    // Create a document reference in order to associate it id with the stores's id.
    const docReference = getFirestore()
    .collection("stores_names_info").doc();

    // Grab the current values of what was written to the stores collection.
    const storeNameInfo = {
        storeNameInfoId: docReference.id, 
        storeFK: event.data.data().storeOwnerPhoneNumber, // same as event.params.storeOwnerPhoneNumber
        storeName: event.data.data().storeName, 
        storeImageURL: event.data.data().storeImageURL,
        sectionName: event.data.data().sectionName,
        storeState:"Has No Competition",
    };
    
    // Access the parameter `{storeId}` with `event.params`
    logger.log(`About To Add A Store Name Info Object With ID "${storeNameInfo.storeNameInfoId}" To The Database.`);

    // Push the new store into Firestore using the Firebase Admin SDK.
    return await docReference.set(storeNameInfo);
    
});

//http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveAlcoholic?phoneNumber=+27661821261&profileImageURL=../profile.jpg&sectionName=Dunbar-Mayville-Durban-Kwa20%Zulu20%Natal-South20%Africa
// To be deleted.
export const saveAlcoholic = onRequest(async (req, res)=>{

    // Create a document reference in order to associate it id with the stores's id.
    const docReference = getFirestore()
    .collection("alcoholics").doc(req.query.phoneNumber);

    // Grab all parameters, then use them create a alcoholic object.
    const alcoholic = {
        phoneNumber:req.query.phoneNumber,
        profileImageURL:req.query.profileImageURL,
        sectionName:req.query.sectionName,
    };

    // Push the new alcoholic into Firestore using the Firebase Admin SDK.
    const writeResult = await docReference.set(alcoholic);

    // Send back a message that we've successfully written the store
    res.json({result: `Alcoholic with ID: ${writeResult.id} ${alcoholic.phoneNumber} added.`});
});

// Each time a new alcoholic is saved in the database it has to have a corresponding relationship documents.
// Basically this documents contains a relationship between the current user a all stores he/she has joined so far.
// Initially an alcoholic has an empty list of joined stores.
export const createRelationship = onDocumentCreated("/alcoholics/{phoneNumber}", async (event)=>{

    // Access the parameter `{storeId}` with `event.params`
    logger.log("From Params Alcoholic ID", event.params.phoneNumber, "From Data Alcoholic ID", event.data.data().phoneNumber);

    // Create a document reference in order to associate it id with the alcoholic's id.
    const docReference = getFirestore()
    .collection("relationships").doc(event.data.data().phoneNumber);

    const choices = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    var user3DigitToken = '';

    user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
    user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
    user3DigitToken += choices[Math.floor(Math.random()*choices.length)];

    const relationship = {
        userFK: event.data.data().phoneNumber, 
        user3DigitToken: user3DigitToken, 
        joinedStoresFKs: [], 
        
    };
    
    // Access the parameter `{storeId}` with `event.params`
    logger.log(`About To Add A Relationship Object With ID "${relationship.userFK}" To The Database.`);

    // Push the new store into Firestore using the Firebase Admin SDK.
    return await docReference.set(relationship);
});

// Every hour of the days some store draws may be needed to created competitions that are about to start.
export const createCompetitions = onSchedule("every day 08:55", async (event) => {
    
    // 1. Read all stores
    // 2. For each store use it storeId to read all store draws for that particular store.
    // 3. Now retrieve store draws that have a competition starting in the next 5 minute.
    // 4. Finally, create corresponding competitions for all the above stored store draws.
});

// Everytime the competition finish playing, the won price summary has to be created.
export const saveWonPriceSummary = onRequest(async (req, res)=>{
    /*
    // Also update the storeState attribute of the current storeNameInfo object.

    const storeOwnerPhoneNumber = req.params.data.phoneNumber;
    const storeName = req.params.data.storeName;
    const storeSection = req.params.data.storeSection;
    const winnerUsername = req.params.data.competitorToken.username;
    const winnerImageURL = req.params.data.competitorToken.competitionCompetitorImageLocation;
    const wonPriceDescription = req.params.data.grandPriceToken.description;

    var docReference = getFirestore()
    .collection("won_price_summaries").doc();

    const wonPriceSummaryId = docReference.id;

    const wonPriceSummary = {
        'Won Price Summary Id': wonPriceSummaryId,
        'Store FK': storeOwnerPhoneNumber,
        'Winner Image URL': winnerImageURL,
        'Winner Username': winnerUsername,
        'Grand Price Description': wonPriceDescription,
        'Store Image URL': storeImageURL,
        'Store Name': storeName,
        'Store Section': storeSection,
        'Won Date': DateTime.now(),
    };

    // Push the new won price summary into Firestore using the Firebase Admin SDK.
    var writeResult = await docReference.set(wonPriceSummary);

    logger.log(`Won Price Summary with ID: ${writeResult.id} Save Successfully.`);
  

    // Save recent won price
    docReference = getFirestore()
    .collection("recent_wins").doc();

    const recentWin = {
        'Recent Win Id': docReference.id,
        'Won Price Summary FK': wonPriceSummaryId,
        'Winner Image URL': winnerImageURL,
        'Winner Username': winnerUsername,
    };

    // Push the recent win into Firestore using the Firebase Admin SDK.
    writeResult = await docReference.set(recentWin);

    logger.log(`Recent Win with ID: ${writeResult.id} Save Successfully.`);

    // Send back a message that we've successfully written the store
    res.json({result: `Won Price Summary And Recent Win Are Both Saved Successfully.`});*/
    
});

/* Everytime a competition ends all of the grand prices for it are assigned a 
same value which is a total number of competitors for that particular competition.
*/
export const createGrandPricesStatus = onRequest(async (req, res)=>{

});

// Invoked whenever a relationship document is updated.
// Contains a boolean parameter which determines whether a remove or add operation should be perfomed.
export const addOrRemoveCustomer = onDocumentUpdated("/relationships/{relationId}", async (event)=>{

});

/* Immediately the remaining time for a competition to beging 
is 10 seconds, execute this function every seconds. Then stop
when a grand price is picked.*/
export const keepUpdatingIndexOfPointedGrandPrice = onSchedule("every day 08:55", async (event) => {
    // Multi threading is applied here I assume.
});

/* Immediately the remaining time for a picking a grand price to be won
is 10 seconds, execute this function every seconds. Then stop
when a competitor/winner is picked. The competitor is picked immedietely 
the competition time ends.*/
export const keepUpdatingIndexOfPointedCompetitor = onSchedule("every day 08:55", async (event) => {
    // Multi threading is applied here I assume.

    // minute hour dayOfMont month dayOfWeek
    // *	any value
    // ,	value list separator
    // -	range of values
    // /	step values
    // Example 1 - “At 00:05 in August.” -> 5  0 * 8 *
    //             next  at 2025-08-01 00:05:00
    //             then at 2025-08-02 00:05:00
    //             then at 2025-08-03 00:05:00
    //             then at 2025-08-04 00:05:00
    //             then at 2025-08-05 00:05:00
    // Set Time And Check With crontab guru

});

