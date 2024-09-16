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

  //http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveStore?storeOwnerPhoneNumber=+27661824333&storeName=Modos&storeImageURL=../modos_store.jpg&sectionName=Dunbar-Mayville-Durban-Kwa20%Zulu20%Natal-South20%Africa
// To Be Deleted.
export const saveStore = onRequest(async (req, res)=>{
    // [END savestoreTrigger]
    
    // [START adminSdkAdd]
    // Create a document reference in order to associate it id with the stores's id.
    const docReference = getFirestore()
    .collection("stores").doc(req.query.storeOwnerPhoneNumber);

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
    .collection("stores_names_info").doc(event.params.storeOwnerPhoneNumber);

    // Grab the current values of what was written to the stores collection.
    const storeNameInfo = {
        storeNameInfoId: event.data.data().storeOwnerPhoneNumber, // same as event.params.storeOwnerPhoneNumber
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

function tokensCreationCloudFunction(storeDraw, grandPriceGridId, competitorsGridId){

    // To be used when saving both grand price tokens and competitor tokens into the database.
    let reference;

    // Query a collection of draw grand prices by getting draw grand prices for this particular StoreDraw.
    const drawGrandPricesQuery = getFirestore()
        .collection(
            `store/${storeDraw.storeFK}/store_draws/${storeDraw.storeDrawId}/draw_grand_prices`)
        .where('Store Draw Id', {isEqualTo: storeDraw.storeDrawId});

    // Store all the retrieved draw grand prices as a list.
    const drawGrandPrices =
        drawGrandPricesQuery.snapshots().map((snapshot) =>{
      return snapshot.docs.map((doc) =>{
        const drawGrandPrice = {
            'Grand Price Id': doc.data['Grand Price Id'],
            'Store Draw FK': doc.data['Store Draw FK'],
            'Description': doc.data['Description'],
            'Image URL': doc.data['Image URL'],
            'Grand Price Index': doc.data['Grand Price Index'],
        };
       
        return drawGrandPrice;
      }).toList();
    });

    // Convert each drawGrandPrice into a grandPriceToken and save it.
    drawGrandPrices.forEach(async (list) => {
      for (var i = 0; i < list.length; i++) {
        const drawGrandPrice = list[i];
        reference = getFirestore()
            .collection(
                `competitions/${storeDraw.storeDrawId}grand_prices_grid/${grandPriceGridId}/grand_price_tokens`)
            .doc(drawGrandPrice.grandPriceId);

        const grandPriceToken ={
            'Grand Price Token Id': drawGrandPrice.grandPriceId,
            'Token Index': drawGrandPrice.grandPriceIndex,
            'Is Pointed':drawGrandPrice.grandPriceIndex==0,
            'Grand Price Image URL': drawGrandPrice.imageURL,
            'Description': drawGrandPrice.description,
        };

        await reference.set(grandPriceToken);
      }
    });

    // Query a collection of draw competitors by getting draw competitors for this particular StoreDraw.
    const drawCompetitorsQuery = getFirestore()
        .collection(
            `store/${storeDraw.storeFK}/store_draws/${storeDraw.storeDrawId}/draw_competitors`)
        .where('Store Draw Id', {isEqualTo: storeDraw.storeDrawId});

    // Store all the retrieved draw competitors as a list.
    const drawCompetitors =
        drawCompetitorsQuery.snapshots().map((snapshot) =>{
      return snapshot.docs.map((doc) =>{
        const drawCompetitor = {
            'Competitor Id': doc.data['Competitor Id'],
            'Image URL': doc.data['Image URL'],
            'Store Draw FK': doc.data['Store Draw FK'],
            'Username': doc.data['Username'],
            'Competitor Number': doc.data['Competitor Number'],
            'Alcoholic 3 Digit Token': doc.data['Alcoholic 3 Digit Token'],
        };
        
        return drawCompetitor;
      }).toList();
    });

    // Convert each drawCompetitor into a competitorToken and save it.
    drawCompetitors.forEach(async (list) =>{
      for (var i = 0; i < list.length; i++) {
        const drawCompetitor = list[i];
        reference = getFirestore()
            .collection(
                `competitions/${storeDraw.storeDrawId}/competitors_grids/${competitorsGridId}/competitors_tokens`)
            .doc(drawCompetitor.competitorId);

            const competitorToken = {
                'Competitor Token Id': drawCompetitor.competitorId,
                'Competitors Grid FK': competitorsGridId,
                'Token Index': drawCompetitor.competitorNumber,
                'Is Pointed': drawCompetitor.competitorNumber==0,
                'Competitor Image Location': drawCompetitor.imageURL,
                'User Name': drawCompetitor.username,
            };

        await reference.set(competitorToken);
      }
    });
}

// http://127.0.0.1:5001/alcoholic-expressions/us-central1/createFakeStoresAndDraws
export const createFakeStoresAndDraws = onRequest(async (req,res)=>{

    // Create Fake Section Names.
    const storeSectionNames = [
        'Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa',
        'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    ];

    let store;
    let storeReference;
    // Create Fake Store Names.
    const storeNames = [
        'Gomora', 'Nomusa', 'Zoba', 'Viyokazi', 'Nkuxa',
        'Mashimane', 'Ndala', 'Mathayini', 'Maythanqaze',
        'Ka Mgazi',
    ];
    // Create Fake Store images.
    const storeImages = [
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$1.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$2.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$3.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$4.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$5.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$6.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$7.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$8.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$9.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\stores\\$10.jpg',
    ];
    // Create Fake Store Owner Phone Numbers.
    const storeOwnersPhoneNumbers = [
        '+27674533323', '+27674563542', '+27674563542', '+27674563542', '+27675099012',
        '+27787653542', '+27674511121', '+27674567777', '+27690900542', '+27832121223',
    ];

    const possibleNoOfGrandPrices = [4,5,6,7,8];
    let storeDraw;
    let storeDrawReference;

    let drawGrandPrice;
    let drawGrandPriceReference;
    // Create Fake Grand Prices Images
    const grandPricesImages = [
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$1.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$2.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$3.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$4.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$5.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$6.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$7.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$8.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$9.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\grand prices\\$10.jpg',
    ];
    // Create Fake Grand Prices Descriptions
    const descriptions = [
        'Savana 6x330ml',
        'Castle 12x330ml',
        'Sminnorf 12x750ml',
        'Castle Milk Stout 6x500ml',
        'Amstel Light 6x330ml',
        'Heineken 12x750ml',
        'Castle 6x330ml',
        'Castle 24x330ml',
        'Wines',
        'Savana 24x360ml',
    ];
    let imageAndDescriptionIndex;

    let drawCompetitor;
    let drawCompetitorReference;
    const competitorsImages = [
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$1.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$2.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$3.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$4.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$5.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$6.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$7.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$8.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$9.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$10.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$11.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$12.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$13.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$14.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$15.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$16.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$17.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$18.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$19.jpg',
        'C:\\Users\\Lwandile-Ganyile\\Documents\\Lwandile Ganyile\\Alcoholic\\alcoholic\\assets\\users\\alcoholics\\$20.jpg',
    ];
    const competitorsUsernames = [
        'Snathi', 'Thami', 'Mbuso', 'Mdu', 'Sam', 'Vusi', 'Sadam',
        'Toto', 'Javas', 'Mlimi', 'Maliyeqolo', 'Sihle', 'Mtho',
        'Mazweni', 'Yninini', 'Sphiwe', 'Mazeze', 'Theniza', 'Jam Jam',
        'Radebe'
    ];
    

    // Create ten fake stores.
    for(var storeNo = 0; storeNo<10;storeNo++){

        // Create single store.
        store = {
            'Is Fake': 'Yes',
            'Store Name': storeNames[storeNo],
            'Store Owner Phone Number': storeOwnersPhoneNumbers[storeNo],
            'Store Image URL': storeImages[storeNo],
            'Section Name': storeSectionNames[storeNo%2],
            'Last Won Price Summary': null,
        };

        // Point where to save a store.
        storeReference = getFirestore()
        .collection('/stores/')
        .doc(`${store['Store Owner Phone Number']}`);

         // Save store to the database.
        await storeReference.set(store);
        
        // Generate a random number of store draws for the current store.
        var randomNoOfStoreDraws = Math.floor(Math.random()*10);

        // Create a certain number of store draws.
        for(var storeDrawNo = 0; storeDrawNo < randomNoOfStoreDraws;storeDrawNo++){

            // Create a single store draw.
            storeDraw = {
                'Is Fake': 'Yes',
                'Store Draw Id': `Store ${storeNo} Draw ${storeDrawNo}`,
                'Store FK': storeOwnersPhoneNumbers[storeNo],
                'Draw Date & Time': {'year':2024, 'month':9,'day':16, 'hour':storeNo*2,'minute':5},
                'Joining Fee': Math.floor(Math.random()*2),
                'Number Of Grand Prices': possibleNoOfGrandPrices[Math.floor(Math.random()*possibleNoOfGrandPrices.length)],
                'Number of Competitors So Far': Math.floor(Math.random()*20),
                'Is Open': false,
                'Store Name': storeNames[storeNo],
                'Store Image URL': storeImages[storeNo],
                'Section Name': storeSectionNames[storeNo%2],
            };

            // Point where to save a store draw.
            storeDrawReference = getFirestore()
            .collection(`/stores/${storeDraw['Store FK']}/store_draws/`)
            .doc(`${storeDraw['Store Draw Id']}`);

            // Save a store draw into the database.
            await storeDrawReference.set(storeDraw);

            // Create grand prices for a particular store draw.
            for(var grandPriceNo = 0; grandPriceNo < storeDraw['Number Of Grand Prices'];grandPriceNo++){
                imageAndDescriptionIndex = Math.floor(Math.random()*grandPricesImages.length);

                // Point where to save a store draw grand price.
                drawGrandPriceReference = getFirestore()
                .collection(`/stores/${storeDraw['Store FK']}/store_draws/
                ${storeDraw['Store Draw Id']}/draw_grand_prices/`)
                .doc();

                // Create a grand price
                drawGrandPrice = {
                    'Is Fake': 'Yes',
                    'Grand Price Id': drawGrandPriceReference.id,
                    'Store Draw FK': storeDraw["Store Draw Id"],
                    'Description': descriptions[imageAndDescriptionIndex],
                    'Image URL': grandPricesImages[imageAndDescriptionIndex],
                    'Grand Price Index': grandPriceNo,
                };

                // Save a draw grand price
                await drawGrandPriceReference.set(drawGrandPrice);
            }

            // Create draw competitors for a particular store draw.
            for(var competitorNo = 0; competitorNo < storeDraw["Number of Competitors So Far"];competitorNo++){


                // Point where to save a store draw competitor.
                drawCompetitorReference = getFirestore()
                .collection(`/stores/${storeDraw['Store FK']}/store_draws/
                ${storeDraw['Store Draw Id']}/draw_competitors/`)
                .doc();

                // Make sure we not only get the first 'noOfComp' competitors only.
                competitorsImages.shuffle(); 

                // Create a unique 3 digit token for a draw competitor.
                const choices = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                var user3DigitToken = '';
                user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
                user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
                user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
                
                // Create a draw competitor;
                drawCompetitor = {
                    'Is Fake': 'Yes',
                    'Competitor Id': drawCompetitorReference.id,
                    'Image URL': competitorsImages[competitorNo],
                    'Store Draw FK': storeDraw["Store Draw Id"],
                    'Username': competitorsUsernames[competitorNo],
                    'Competitor Number': competitorNo,
                    'Alcoholic 3 Digit Token': user3DigitToken,
                };

                // Save draw competitor into the database.
                await drawCompetitorReference.set(drawCompetitor);
            }
        }
    }
});

// Every hour of the days some store draws may be needed to created competitions that are about to start.
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
export const createCompetitions = onSchedule("* * * * * *", async (event) => {
    
    const justNow = Date.now(); // Retrieve Current Time.    

    // #Plan
    // Step 1. Retrieve all stores in order to check their store draws.
    // Step 2. For each store use it storeId to read all store draws for that particular store.
    // Step 3. Now retrieve store draws that have a competition starting in the next 5 minute.
    // Step 4. Finally, create corresponding competitions for all the above stored store draws.

    // Step 1
    const allStores =  getFirestore()
    .collection('stores')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) =>{

            return {
                'Is Fake': doc.data['Is Fake'],
                'Store Name': doc.data['Store Name'],
                'Store Owner Phone Number': doc.data['Store Owner Phone Number'],
                'Store Image URL': doc.data['Store Image URL'],
                'Section Name': doc.data['Section Name'],
                'Last Won Price Summary': doc.data['Last Won Price Summary'],

            };
        })
    .toList());

    allStores.forEach((list) =>{
        // Step 2
        for (var i = 0; i < list.length; i++) {
            const store = list[i];
            
            // Step 3
            // Query the store draws that will be playing in the next 5 minutes.
            const storeDrawsQuery = getFirestore()
            .collection(`store/${store.storeOwnerPhoneNumber}/store_draws`)
            .where(['Draw Date & Time']['year'], {
                isEqualTo: justNow.getYear()
            })
            .where(['Draw Date & Time']['month'], {
                isEqualTo: justNow.getMonth()
            })
            .where(['Draw Date & Time']['day'], {
                isEqualTo: justNow.getDay()
            })
            .where(['Draw Date & Time']['hour'], {
                isEqualTo: justNow.getHour()
            })
            // Can Be A Bit Tricky If You Think About It.
            // As a result competitions shouldn't start at o'clock.
            .where(['Draw Date & Time']['minute'], {
                isLessThanOrEqualTo: justNow.getMinute() + 5,
                isGreaterThanOrEqualTo: justNow.getMinute()
            });
  
            // Create store draw objects from the query.
            const storeDraws = storeDrawsQuery.snapshots().map((snapshot)=> {
                return snapshot.docs.map((doc) =>{
              
                    // Create a single storeDraw
                    const storeDraw = {
                        'Is Fake': doc.data['Is Fake'],
                        'Store Draw Id': doc.data['Store Draw Id'],
                        'Store FK': doc.data['Store FK'],
                        'Draw Date & Time': doc.data['Draw Date & Time'],
                        'Joining Fee': doc.data['Joining Fee'],
                        'Number Of Grand Prices': doc.data['Number Of Grand Prices'],
                        'Number of Competitors So Far': doc.data['Number of Competitors So Far'],
                        'Is Open': doc.data['Is Open'],
                        'Store Name': doc.data['Store Name'],
                        'Store Image URL': doc.data['Store Image URL'],
                        'Section Name': doc.data['Section Name'],
                    };

                    // Close Store Draw -> No more updates are allowed on a store draw.
                    const docReference = getFirestore().collection(`store/${store.storeOwnerPhoneNumber}
                    /store_draws/${storeDraw["Store Draw Id"]}`).doc();
                    docReference.update({'Is Open': false});

                    return storeDraw;
                }).toList();
            });
  
            // Step 4
            storeDraws.forEach(async (list) => {
                for (var i = 0; i < list.length; i++) {
                    const storeDraw = list[i];
                    // Used to create the number of iterations when picking grand price to be won and a winner.
                    var randomNoOfRepeataions = 3 + Math.floor(Math.random()*3);;
                    // Time it would take to pick a grand price to be won.
                    let durationInSeconds = storeDraw.numberOfGrandPrices * randomNoOfRepeataions;
        
                    // The order of visiting the grand prices, the last one is the one to be given to the winner.
                    var grandPricesOrder = [];
        
                    // Create the order with which grand prices will be visited.
                    var index;
                    // Make sure all grand prices are visited.
                    for (index = 0; index < storeDraw.numberOfGrandPrices; index++) {
                        grandPricesOrder.add(index);
                    }
        
                    // Create additional way to visit grand prices.
                    for (index = storeDraw.numberOfGrandPrices;
                        index < durationInSeconds;
                        index++) {
                        grandPricesOrder
                            .add(Math.floor(Math.random()*storeDraw.numberOfGrandPrices));
                    }
        
                    // Suffle the list to make sure the order is random.
                    grandPricesOrder.shuffle();
  
                    const grandPricesGridReference = getFirestore()
                    .collection(
                    `competitions/${storeDraw.storeDrawId}/grand_prices_grids/`)
                    .doc();
        
                    const grandPricesGrid = {

                        'Grand Prices Grid Id': grandPricesGridReference.id,
                        'Competition FK': storeDraw.storeDrawId,
                        'Number Of Grand Prices': storeDraw.numberOfGrandPrices,
                        'Currently Pointed Token Index': 0,
                        'Grand Prices Order': grandPricesOrder,
                        'Duration': durationInSeconds,
                        'Has Started': false,
                        'Has Stopped': false,
                    };
  
                    // Time it would take to pick a winner.
                    durationInSeconds = storeDraw.numberOfCompetitorsSoFar * randomNoOfRepeataions;
                    // The order of visiting competitors are kept here.
                    var competitorsOrder = [];
        
                    // Make sure all competitors are visited.
                    for (index = 0;
                        index < storeDraw.numberOfCompetitorsSoFar;
                        index++) {
                        competitorsOrder.add(index);
                    }
        
                    // Create additional way of visiting competitors.
                    for (index = storeDraw.numberOfCompetitorsSoFar;
                        index < durationInSeconds;
                        index++) {
                        competitorsOrder
                            .add(Math.floor(Math.random()*storeDraw.numberOfCompetitorsSoFar));
                    }
        
                    // Make sure competitors are visited randomly.
                    competitorsOrder.shuffle();
  
                    // Create a duration it takes to pick a winner.
                    if (storeDraw.numberOfCompetitorsSoFar <= 20) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar * 6;
                    } else if (storeDraw.numberOfCompetitorsSoFar <= 50) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar * 5;
                    } else if (storeDraw.numberOfCompetitorsSoFar <= 100) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar + 20;
                    } else if (storeDraw.numberOfCompetitorsSoFar <= 200) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar + 30;
                    } else if (storeDraw.numberOfCompetitorsSoFar <= 500) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar + 50;
                    } else if (storeDraw.numberOfCompetitorsSoFar <= 1000) {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar + 30;
                    } else {
                        durationInSeconds = storeDraw.numberOfCompetitorsSoFar + 60;
                    }
    
                    const competitorsGridReference = getFirestore().collection(
                    `competitions/${storeDraw.storeDrawId}/competitors_grids/`)
                    .doc();
        
                    const competitorsGrid = {

                        'Competitors Grid Id': competitorsGridReference.id,
                        'Competition FK': storeDraw.storeDrawId,
                        'Number Of Competitors': storeDraw.numberOfCompetitorsSoFar,
                        'Currently Pointed Token Index': 0,
                        'Competitors Order': competitorsOrder,
                        'Duration': durationInSeconds,
                        'Has Started': false,
                        'Has Stopped': false,
                    };
  
                    tokensCreationCloudFunction(
                        storeDraw,
                        grandPricesGrid.competitionPricesGridId,
                        competitorsGrid["Competitors Grid Id"]
                    );
  
                    const competitionReference = getFirestore()
                    .collection('competitions/')
                    .doc(storeDraw.storeDrawId);
  
                    const competition = {
                        'Competition Id': competitionReference.id,
                        'Store FK': storeDraw.storeFK,
                        'Store Image Location': storeDraw.storeImageURL,
                        'Store Name': storeDraw.storeName,
                        'Store Section Name': storeDraw.sectionName,
                        'Is Live': true,
                        'Date Time': storeDraw.drawDateAndTime,
                        'Joining Fee': storeDraw.joiningFee,
                        'Is Over': false,
                        'Grand Prices Grid': grandPricesGrid,
                        'Competitors Grid': competitorsGrid,
                    };
    
                    await grandPricesGridReference.set(grandPricesGrid.toJson());
                    await competitionReference.set(competitorsGrid.toJson());
                    await competitionReference.set(competition.toJson());
                }
            });
        }
    });
});


/* Immediately the remaining time for a competition to beging 
is 10 seconds, execute this function every seconds. Then stop
when a grand price is picked.*/
export const keepUpdatingIndexOfPointedGrandPrice = onSchedule("every day 08:55", async (event) => {
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

