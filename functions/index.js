"use strict";

// [START all]
// [START import]
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
import {logger} from "firebase-functions";

import {onDocumentCreated} from "firebase-functions/v2/firestore";
import {onRequest} from "firebase-functions/v2/https";

// The Firebase Admin SDK to access Firestore.
import {initializeApp} from "firebase-admin/app";
import {getFirestore} from "firebase-admin/firestore";

import {onSchedule} from "firebase-functions/v2/scheduler";

/* const runtimeOpts = {
  timeoutSeconds: 360,
  memory: "1GB",
};*/

const queriedStoreDraws = [];

initializeApp();


// ###################Production Functions [Start]########################

/* Each time a new alcoholic is saved in the database it has to have a correspo
nding relationship documents. Basically this documents contains a relationsh
ip between the current user a all stores he/she has joined so far. Initially -
an alcoholic has an empty list of joined stores. */
export const createRelationship = onDocumentCreated(
    "/alcoholics/{phoneNumber}", async (event)=>{
      // Access the parameter `{storeId}` with `event.params`
      logger.log(`From Params Alcoholic ID, ${event.params.phoneNumber}
        , "From Data Alcoholic ID`, event.data.data().phoneNumber);

      /* Create a document reference in order to associate it id with the alcoho
      lic's id.*/
      const docReference = getFirestore()
          .collection("relationships").doc(event.data.data().phoneNumber);

      const choices = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

      let user3DigitToken = "";

      user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
      user3DigitToken += choices[Math.floor(Math.random()*choices.length)];
      user3DigitToken += choices[Math.floor(Math.random()*choices.length)];

      const relationship = {
        userFK: event.data.data().phoneNumber, user3DigitToken: user3DigitToken,
        joinedStoresFKs: [],
      };

      logger.log(`About To Add A Relationship Object With ID 
        ${relationship.userFK} To The Database.`);

      // Push the new store into Firestore using the Firebase Admin SDK.
      return await docReference.set(relationship);
    },
);

/* Each time a new store is created, it has to have a corresponding store name
info document which is responsible for holding information that users
will be seeing, like a store's current state(hasNoCompetition,
hasUpcommingCompetition, etc.) for example. */
export const createStoreNameInfo = onDocumentCreated("/stores/" +
  "{storeOwnerPhoneNumber}", async (event) => {
  // Access the parameter `{storeId}` with `event.params`
  logger.log("From Params Store ID", event.params.storeOwnerPhoneNumber,
      "From Data Store ID", event.data.data().storeOwnerPhoneNumber);

  /* Create a document reference in order to associate it id with the
  stores's id.*/
  const docReference = getFirestore()
      .collection("stores_names_info").doc(event.params.storeOwnerPhoneNumber);

  // Grab the current values of what was written to the stores collection.
  const storeNameInfo = {
    isFake: event.data.data().isFake,
    storeNameInfoId: event.data.data().storeOwnerPhoneNumber,
    storeName: event.data.data().storeName,
    storeImageURL: event.data.data().storeImageURL,
    sectionName: event.data.data().sectionName,
    storeState: "Has No Competition",
  };
  logger.log(`About To Add A Store Name Info Object With ID
    ${storeNameInfo.storeNameInfoId} To The Database.`);

  // Push the new store into Firestore using the Firebase Admin SDK.
  return await docReference.set(storeNameInfo);
});


// declare the function
const shuffle = (array) => {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
};

/* Do not modify application state inside of your transaction functions.
Doing so will introduce concurrency issues, because transaction functions
can run multiple times and are not guaranteed to run on the UI thread.
Instead, pass information you need out of your transaction functions.
onSchedule("25 8 * * SUN", async (event) => {*/
// http://127.0.0.1:5001/alcoholic-expressions/us-central1/fromDrawsToCompetitionsTransaction
export const fromDrawsToCompetitionsTransaction =
onRequest(async (req, res)=>{
  try {
    const justNow = new Date(); // Retrieve Current Time.

    // Use the get() method for a read and the onSnapshot() for real time read.
    getFirestore().collectionGroup("store_draws").orderBy("storeName")
        .where("drawDateAndTime.year",
            "==", justNow.getFullYear(),
        )
        .where("drawDateAndTime.month",
            "==", justNow.getMonth() + 1, // 1-12
        )
        .where("drawDateAndTime.day",
            "==", justNow.getDate(),
        )
        .where("drawDateAndTime.hour",
            "==", justNow.getHours() + 2, // GTM
        )
        // Can Be A Bit Tricky If You Think About It.
        // As a result competitions shouldn't start at o'clock.
        .where("drawDateAndTime.minute",
            "<=", justNow.getMinutes() + 5,
        )
        .where("drawDateAndTime.minute",
            ">=", justNow.getMinutes()-5,
        )
        .onSnapshot(async (storeDrawsSnapshot)=>{
          if (storeDrawsSnapshot.size) {
            storeDrawsSnapshot.forEach(async (storeDrawDoc)=>{
              storeDrawDoc.ref.update({isOpen: false,
                isRemainingTimeVisible: true});
              const storeDrawId = storeDrawDoc.data()["storeDrawId"];

              const storeDraw = {
                isFake: storeDrawDoc.data()["isFake"],
                storeDrawId: storeDrawDoc.data()["storeDrawId"],
                storeFK: storeDrawDoc.data()["storeFK"],
                drawDateAndTime:
                storeDrawDoc.data()["drawDateAndTime"],
                joiningFee: storeDrawDoc.data()["joiningFee"],
                numberOfGrandPrices:
                storeDrawDoc.data()["numberOfGrandPrices"],
                numberOfGroupCompetitorsSoFar:
                storeDrawDoc.data()["numberOfGroupCompetitorsSoFar"],
                isOpen: storeDrawDoc.data()["isOpen"],
                storeName: storeDrawDoc.data()["storeName"],
                storeImageURL:
                storeDrawDoc.data()["storeImageURL"],
                sectionName:
                storeDrawDoc.data()["sectionName"],
                remainingTime:
                storeDrawDoc.data()["remainingTime"],
                isRemainingTimeVisible:
                storeDrawDoc.data()["isRemainingTimeVisible"],
              };

              queriedStoreDraws.push(storeDraw);

              let reference = getFirestore()
                  .collection("competitions")
                  .doc(storeDraw.storeDrawId);

              const competition = {
                competitionId: reference.id,
                storeFK: storeDraw.storeFK,
                storeImageLocation: storeDraw.storeImageURL,
                storeName: storeDraw.storeName,
                storeSectionName: storeDraw.sectionName,
                isLive: true,
                dateTime: storeDraw.drawDateAndTime,
                joiningFee: storeDraw.joiningFee,
                isOver: false,
              };

              await reference.set(competition);

              /* Convert each drawGrandPrice into a
              grandPriceToken and save it.*/
              reference = getFirestore()
                  .collection("competitions")
                  .doc(storeDrawId)
                  .collection("grand_prices_grids")
                  .doc();

              const grandPriceGridId = reference.id;

              // Step 4
              /* Used to create the number of iterations
              when picking grand price to be won and a winner.*/
              const randomNoOfRepeataions = 3 +
              Math.floor(Math.random()*3);
              /* Time it would take to pick a grand price
              to be won.*/
              let durationInSeconds = storeDraw.numberOfGrandPrices*
              randomNoOfRepeataions;
              /* The order of visiting the grand prices,
              the last one is the one to be given to the
              winner.*/
              let grandPricesOrder = [];
              /* Create the order with which grand prices
              will be visited.*/
              let index;
              // Make sure all grand prices are visited.
              for (index = 0; index < storeDraw.numberOfGrandPrices;
                index++) {
                grandPricesOrder.push(index);
              }
              // Create additional way to visit grand prices.
              for (index = storeDraw.numberOfGrandPrices;
                index < durationInSeconds; index++) {
                grandPricesOrder
                    .push(Math.floor(Math.random()*
                      storeDraw.numberOfGrandPrices),
                    );
              }

              // Suffle the list to make sure the order is random.
              grandPricesOrder = shuffle(grandPricesOrder);

              const grandPricesGrid = {
                grandPricesGridId: reference.id,
                competitionFK: competition.competitionId,
                numberOfGrandPrices: storeDraw.numberOfGrandPrices,
                currentlyPointedTokenIndex: 0,
                grandPricesOrder: grandPricesOrder,
                duration: durationInSeconds,
                hasStarted: false,
                hasStopped: false,
              };

              reference.set(grandPricesGrid);

              getFirestore()
                  .collection("stores")
                  .doc(storeDraw.storeFK)
                  .collection("store_draws")
                  .doc(storeDrawId)
                  .collection("draw_grand_prices")
                  .onSnapshot(async (drawGrandPricesSnapshot)=>{
                    if (drawGrandPricesSnapshot.size>0) {
                      drawGrandPricesSnapshot.forEach(
                          async (drawGrandPrice)=>{
                            const tokenReference =
                            reference
                                .collection("grand_prices_tokens")
                                .doc();

                            const grandPriceToken ={
                              grandPriceTokenId:
                              tokenReference.id,
                              grandPriceGridFK:
                              grandPriceGridId,
                              tokenIndex:
                              drawGrandPrice.data().grandPriceIndex,
                              isPointed:
                              drawGrandPrice.data().grandPriceIndex==0,
                              imageURL:
                              drawGrandPrice.data().imageURL,
                              description:
                              drawGrandPrice.data().description,
                            };
                            await tokenReference.set(grandPriceToken);
                          });

                      reference = getFirestore()
                          .collection("competitions")
                          .doc(storeDraw.storeDrawId)
                          .collection("group_competitors_grids")
                          .doc();

                      const groupCompetitorsGridId = reference.id;

                      // Time it would take to pick a winner.
                      durationInSeconds =
                      storeDraw.numberOfGroupCompetitorsSoFar *
                      randomNoOfRepeataions;
                      /* The order of visiting competitors
                      are kept here.*/
                      let competitorsOrder = [];
                      // Make sure all competitors are visited.
                      for (index = 0; index <
                        storeDraw.numberOfGroupCompetitorsSoFar;
                        index++) {
                        competitorsOrder.push(index);
                      }
                      // Create additional way of visiting competitors.
                      for (index =
                        storeDraw.numberOfGroupCompetitorsSoFar;
                        index < durationInSeconds;
                        index++) {
                        competitorsOrder.push(Math.floor(Math.random()*
                        storeDraw.numberOfGroupCompetitorsSoFar));
                      }
                      // Make sure competitors are visited randomly.
                      competitorsOrder = shuffle(competitorsOrder);
                      // Create a duration it takes to pick a winner.
                      if (
                        storeDraw.numberOfGroupCompetitorsSoFar <= 20) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar * 6;
                      } else if (
                        storeDraw.numberOfGroupCompetitorsSoFar <=
                        50) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar * 5;
                      } else if (
                        storeDraw.numberOfGroupCompetitorsSoFar <=
                        100) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar + 20;
                      } else if (
                        storeDraw.numberOfGroupCompetitorsSoFar <=
                        200) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar +
                        30;
                      } else if (
                        storeDraw.numberOfGroupCompetitorsSoFar <=
                        500) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar + 50;
                      } else if (
                        storeDraw.numberOfGroupCompetitorsSoFar <=
                        1000) {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar + 30;
                      } else {
                        durationInSeconds =
                        storeDraw.numberOfGroupCompetitorsSoFar + 60;
                      }

                      const groupCompetitorsGrid = {
                        competitorsGridId: groupCompetitorsGridId,
                        competitionFK: storeDraw.storeDrawId,
                        numberOfGroupCompetitors:
                        storeDraw.numberOfGroupCompetitorsSoFar,
                        currentlyPointedTokenIndex: 0,
                        competitorsOrder: competitorsOrder,
                        duration: durationInSeconds,
                        hasStarted: false,
                        hasStopped: false,
                      };

                      reference.set(groupCompetitorsGrid);

                      getFirestore()
                          .collection("stores")
                          .doc(storeDraw.storeFK)
                          .collection("store_draws")
                          .doc(storeDrawId)
                          .collection("draw_groups_competitors")
                          .onSnapshot(
                              async (drawGroupCompetitorsSnapshot)=>{
                                if (drawGroupCompetitorsSnapshot.size>
                                  0) {
                                  drawGroupCompetitorsSnapshot.forEach(
                                      async (drawGroupCompetitorDoc)=>{
                                        const tokenDocReference =
                                  reference
                                      .collection(
                                          "group_competitors_tokens")
                                      .doc();
                                        const groupCompetitorToken = {
                                          groupCompetitorTokenId:
                                          tokenDocReference
                                              .id,
                                          groupCompetitorsGridFK:
                                          groupCompetitorsGridId,
                                          tokenIndex:
                                          drawGroupCompetitorDoc
                                              .data()["groupNumber"],
                                          isPointed:
                                          drawGroupCompetitorDoc
                                              .data()["groupNumber"]==0,
                                          groupCompetitorImageURL:
                                          drawGroupCompetitorDoc
                                              .data()["groupImageURL"],
                                          groupName:
                                          drawGroupCompetitorDoc
                                              .data()["groupName"],
                                          creatorUsername:
                                          drawGroupCompetitorDoc
                                              .data()["creatorUsername"],
                                          creatorId:
                                          drawGroupCompetitorDoc
                                              .data()["creatorId"],
                                          groupSectionName:
                                          drawGroupCompetitorDoc
                                              .data()["groupSectionName"],
                                          groupSpecificLocation:
                                          drawGroupCompetitorDoc
                                              .data()["groupSpecificLocation"],
                                        };

                                        tokenDocReference
                                            .set(groupCompetitorToken);
                                      });
                                }
                              });
                    }
                  });
            });
          }
        });
    res.json({result: `Done Converting Store Draws Into Competitions.`});
  } catch (e) {
    logger.log(e);
  }
});

/* Make sure all competitions start at an acceptable time,
like 08:30 for instance.*/
// http://127.0.0.1:5001/alcoholic-expressions/us-central1/initiateRemainingTimeCountDown
export const initiateRemainingTimeCountDown =
onDocumentCreated("/competitions/" +
  "{competitionId}", async (event) => {
  const day = event.data.data().dateTime.day;
  const month = event.data.data().dateTime.month;
  const year = event.data.data().dateTime.year;
  const hour = event.data.data().dateTime.hour;
  const minute = event.data.data().dateTime.minute;

  const collectionId = `${day}-${month}-${year}_${hour}${minute}`;

  const reference = getFirestore().collection("read_only")
      .doc(collectionId);

  reference.onSnapshot((snapshot)=>{
    if (!snapshot.exists) {
      let second = 300; // Remaining seconds
      const remainingTimeTimerId = setInterval(async ()=>{
        if (second==0) {
          clearInterval(remainingTimeTimerId);
        }
        else {
          second--;
        }
        reference.set({
          remainingTime: second,
        }).then(()=>{
          logger.log(second);
        });
      }, 1000);
      logger.log(`Remaining Time Update In Progress...`);
    }
  });
});

// ##################Production Functions [End]########################

// ########################################Development Functions [Start]#######################################################

/*
==================================================================================================================================
http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveFakeAlcoholics
http://127.0.0.1:5001/alcoholic-expressions/us-central1/createFakeStoreOwners
http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveFakeStores
http://127.0.0.1:5001/alcoholic-expressions/us-central1/createFakeStoreDraws?storeIndex=i[0-9]
http://127.0.0.1:5001/alcoholic-expressions/us-central1/updateStoreDrawsDates
http://127.0.0.1:5001/alcoholic-expressions/us-central1/fromDrawsToCompetitionsTransaction
==================================================================================================================================
*/

//===========================================Create Alcoholic Data[Start]===========================================
// Create Fake Alcoholics Usernames.
const alcoholicsUsernames = [
  'Snathi', 'Thami', 'Mbuso', 'Mdu', 'Sam', 'Vusi', 'Sadam',
  'Toto', 'Javas', 'Mlimi', 'Maliyeqolo', 'Sihle', 'Mtho',
  'Mazweni', 'Yninini', 'Sphiwe', 'Mazeze', 'Theniza', 'Jam Jam',
  'Radebe',
];
// Create Fake Alcoholics Images.
const alcoholicsImages = [
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27625446322.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27625446353.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27668743000.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27668743411.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27744446350.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27765446353.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27765454543.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27788746350.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27811740000.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27811740113.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848740000.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848740212.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848741215.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848741333.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848743411.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848744324.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848746311.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848746350.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848746353.jpg',
  'gs://alcoholic-expressions.appspot.com/alcoholics/+27848746456.jpg',
];
// Create Fake Alcoholics Phone Numbers
const alcoholicsPhoneNumbers = [
  '+27848746353',
  '+27848741215',
  '+27848743411',
  '+27765446353',
  '+27848740000',
  '+27848746350',
  '+27668743411',
  '+27625446353',
  '+27811740000',
  '+27788746350',
  '+27848746311',
  '+27848741333',
  '+27848744324',
  '+27765454543',
  '+27848740212',
  '+27848746456',
  '+27668743000',
  '+27625446322',
  '+27811740113',
  '+27744446350',
];
//===========================================Create Alcoholic Data[End]===========================================


//===========================================Create Stores Owners Data[Start]===========================================
// Create Fake Store Owner Phone Numbers.
const storeOwnersPhoneNumbers = [
  '+27674533323', 
  '+27674563542', 
  '+27674563111', 
  '+27674563222', 
  '+27675099012', 
  '+27787653542', 
  '+27674511121', 
  '+27674567777', 
  '+27690900542', 
  '+27832121223', 
];
// Create Fake Store Owners Profile Images.
const storeOwnersProfileImages = [
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674533323.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674563542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674563111.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674563222.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27675099012.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27787653542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674511121.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27674567777.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27690900542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_images/+27832121223.jpg',
];
// Create Fake Store Owner Names.
const storeOwnerFullnames = [
  'Sandile James',
  'Thandanani Lungelo',
  'Sizwe',
  'Vusimuzi',
  'Sbongakonke Emmanual',
  'Sihle',
  'Mhlengi',
  'Thabiso Innocent Njabulo',
  'Busisiwe Candice',
  'Zanene Angel',
];
// Create Fake Store Owner Names.
const storeOwnerSurnames = [
  'Mkhize',
  'Zondi',
  'Masango',
  'Memela',
  'Khanyile',
  'Mbeje',
  'Mazibuko',
  'Mokoena',
  'Sbisi',
  'Khumalo',
];
// Create Fake Identity Documents
const identityDocuments = [
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674533323.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674563542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674563111.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674563222.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27675099012.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27787653542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674511121.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27674567777.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27690900542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/store_owners_ids/+27832121223.jpg',
];
//===========================================Create Stores Owners Data[End]===========================================

//==============================================Create Stores Data[Start]==============================================
// Create Fake Store Names.
const storeNames = [
  'Ka Nkuxa', 
  'Ziyasha', 
  '6 To 6', 
  'Ka Msanga', 
  'Emakhehleni',
  'Ka Bhakabhaka', 
  'Ka Mjey', 
  'Lungelo\'s Tavern', 
  'Sisonke Tavern',
  'Emhosheni Tavern',
];
// Create Fake Store Names
const sectionNames = [
  'Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa',
  'H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa',
  'M Section-Kwa Mashu-Durban-Kwa Zulu Natal-South Africa',
  'BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa',
  'Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa',
  'Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa',
  'K Section-Kwa Mashu-Durban-Kwa Zulu Natal-South Africa',
  'West Street-Folweni-Durban-Kwa Zulu Natal-South Africa',
  'AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa',
  'V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa',
]
// Create Fake Store images.
const storeImages = [
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674533323.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674563542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674563111.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674563222.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27675099012.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27787653542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674511121.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27674567777.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27690900542.jpg',
  'gs://alcoholic-expressions.appspot.com/store_owners/stores_images/+27832121223.jpg',
];
//==============================================Create Stores Data[End]==============================================

//========================================Create Draw Grand Prices Data[Start]========================================
// Outer Array Or Rows - Represent stores
// Inner Array Or Columns - Represent store draws
// Cells - Represent no of draw grand prices
var fakeGrandPricesData = [
  [4, 7, 5, 4, 6, 8, 7],
  [5, 8, 5],
  [4, 4, 8, 8, 6],
  [4, 7, 4, 5, 4, 5, 4, 6, 8, 7],
  [5, 8, 4, 5, 7, 5],
  [],
  [4, 5, 5, 5, 8, 7, 7],
  [5, 7],
  [4,],
  []
];

// Create Fake Grand Prices Images
const grandPricesImages = [
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Savana#Qty-6#Vol-330ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Castle#Qty-12#Vol-330ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Sminnorf#Qty-12#Vol-750ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Castle_Milk_Stout#Qty-6#Vol-500ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Amstel_Light#Qty-6#Vol-330ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Heineken#Qty-12#Vol-750ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Castle_Milk_Stout#Qty-6#Vol-330ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Castle#Qty-24#Vol-330ml.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Wines.jpg',
  'gs://alcoholic-expressions.appspot.com/grand_prices_images/Name-Savana#Qty-24#Vol-360ml.jpg',
];
// Create Fake Grand Prices Descriptions
const descriptions = [
  'Savana 6x330ml',
  'Castle 12x330ml',
  'Sminnorf 12x750ml',
  'Castle Milk Stout 6x500ml',
  'Amstel Light 6x330ml',
  'Heineken 12x750ml',
  'Castle Milk Stout 6x330ml',
  'Castle 24x330ml',
  'Wines',
  'Savana 24x360ml',
];
let imageAndDescriptionIndex;
//========================================Create Draw Grand Prices Data[End]========================================

//========================================Create Draw Competitors Data[Start]========================================
const fakeDrawGroupCompetitorsNames = [
  'Izinja Madoda',
  'Abanqobi',
  'Real Madrid',
  'Abashayi Besinqa',
  'Maxican',
  'Amastorm',
  'Las Vegas',
  'Iringi',
  'O-2room',
  'O-1gal',
  'Green Land',
  'Abomayo'
];

// Create Fake Grand Prices Images
const fakeDrawGroupCompetitorsImages = [
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Izinja-Madoda.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Abanqobi.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Real-Madrid.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Abashayi-Besinqa.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Maxican.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Amastorm.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Las-Vegas.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Iringi.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/O-2room.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/O-1gal.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Green-Land.jpg',
  'gs://alcoholic-expressions.appspot.com/group_competitors_images/Abomayo.jpg',
];

// Outer Array Or Rows - Represent stores
// Inner Array Or Columns - Represent store draws
// Cells - Represent no of draw group competitors
var fakeDrawGroupCompetitorsData = [
  [7, 6, 1, 2, 19, 12, 10],
  [4, 6, 7],
  [4, 5, 8, 10, 3],
  [4, 7, 4, 5, 2, 5, 2, 6, 8, 7],
  [5, 8, 4, 5, 7, 5],
  [1],
  [4, 5, 1, 5, 8, 7, 7],
  [1, 7],
  [4],
  [10],
];
//========================================Create Draw Competitors Data[End]========================================

// http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveFakeAlcoholics
export const saveFakeAlcoholics = onRequest(async (req, res)=>{

  let alcoholicDocReference
  for(let alcoholicIndex = 0; alcoholicIndex < alcoholicsPhoneNumbers.length; alcoholicIndex++){

      // Create a document reference in order to associate it id with the stores's id.
      alcoholicDocReference = getFirestore()
      .collection("alcoholics").doc(alcoholicsPhoneNumbers[alcoholicIndex]);

      // Grab all parameters, then use them create a alcoholic object.
      const alcoholic = {
          phoneNumber:alcoholicDocReference.id,
          profileImageURL:alcoholicsImages[alcoholicIndex],
          sectionName:sectionNames[0],
          username: alcoholicsUsernames[alcoholicIndex],
      };

      // Push the new alcoholic into Firestore using the Firebase Admin SDK.
      await alcoholicDocReference.set(alcoholic);
  }
  

  // Send back a message that we've successfully written the store
  res.json({result: `All Alcoholics Are Added And They Leave In Cato Crest.`});
});

// http://127.0.0.1:5001/alcoholic-expressions/us-central1/saveFakeStore
export const saveFakeStores = onRequest(async (req, res)=>{

  let storeDocReference;

  for(let storeIndex = 0; storeIndex < storeNames.length; storeIndex++){
  // Create a document reference in order to associate it id with the stores's id.
  storeDocReference = getFirestore()
  .collection("stores").doc(storeOwnersPhoneNumbers[storeIndex]);

  // Grab all parameters, then use them create a store object.
  const store = {
      storeOwnerPhoneNumber:storeOwnersPhoneNumbers[storeIndex],
      storeName:storeNames[storeIndex],
      storeImageURL:storeImages[storeIndex],
      sectionName:sectionNames[storeIndex],
      isFake: 'Yes',
      lastWonPrice:null,
  };

  // Push the new store into Firestore using the Firebase Admin SDK.
  await storeDocReference.set(store);
  }
  // Send back a message that we've successfully written the store
  res.json({result: `All Fake Stores Added Successfully.`});
  // [END adminSdkAdd]
});

// http://127.0.0.1:5001/alcoholic-expressions/us-central1/createFakeStoreOwners
export const createFakeStoreOwners = onRequest(async (req, res) => {

  let storeOwnerDocReference;

  for(let storeOwnerIndex = 0; storeOwnerIndex < storeOwnersPhoneNumbers.length; storeOwnerIndex++){
      // Create a document reference in order to associate it id with the stores's id.
      storeOwnerDocReference = getFirestore()
      .collection("store_owners").doc(storeOwnersPhoneNumbers[storeOwnerIndex]);

      const storeOwner =  {
          phoneNumber: storeOwnersPhoneNumbers[storeOwnerIndex],
          profileImageURL: storeOwnersProfileImages[storeOwnerIndex],
          fullname: storeOwnerFullnames[storeOwnerIndex],
          surname: storeOwnerSurnames[storeOwnerIndex],
          identityDocumentImageURL: identityDocuments[storeOwnerIndex],
          isAdmin: storeOwnerIndex==0,
      };

      await storeOwnerDocReference.set(storeOwner);
  }
  res.json({result: `All Store Owners Added Successfully`});
});

// http://127.0.0.1:5001/alcoholic-expressions/us-central1/createFakeStoreDraws?storeIndex=0
export const createFakeStoreDraws = onRequest(async (req, res) =>{

  const storeIndex = req.query.storeIndex;
  let storeDrawId;
  

  let storeDraw;
  let storeDrawReference;

  const justNow = new Date();

  // Create a certain number of store draws.
  for(var storeDrawNo = 0; storeDrawNo < fakeGrandPricesData[storeIndex].length;storeDrawNo++){

    // Point where to save a store draw.
    storeDrawReference = getFirestore()
    .collection("/stores/").doc(storeOwnersPhoneNumbers[storeIndex])
    .collection("/store_draws/")
    .doc();

    //storeDrawId = `${storeNames[storeIndex]} ${justNow.getDate()}-${justNow.getMonth()+1}-${justNow.getFullYear()} ${justNow.getHours()+2}:${justNow.getMinutes()+3} [${storeDrawFK}]`;
    storeDrawId = storeDrawReference.id;
    
    // Create a single store draw.
    storeDraw = {
        isFake: 'Yes',
        storeDrawId: storeDrawId,
        storeFK: storeOwnersPhoneNumbers[storeIndex],
        drawDateAndTime: {
            'year':justNow.getFullYear() - 1, 
            'month':justNow.getMonth() +1, // 1-12
            'day':justNow.getDate(), 
            'hour':justNow.getHours() +2, // GMT
            'minute': justNow.getMinutes(),
        },
        joiningFee: Math.floor(Math.random()*2),
        numberOfGrandPrices: fakeGrandPricesData[storeIndex][storeDrawNo],
        numberOfGroupCompetitorsSoFar: fakeDrawGroupCompetitorsData[storeIndex][storeDrawNo],
        isOpen: false,
        storeName: storeNames[storeIndex],
        storeImageURL: storeImages[storeIndex],
        sectionName: sectionNames[storeIndex],
        remainingTime: 300, // 5 minute which is 300 seconds
        isRemainingTimeVisible: false,
    };

    
    // Save a store draw into the database.
    await storeDrawReference.set(storeDraw);

    let drawGrandPrice;
    let drawGrandPriceReference;

    // Create grand prices for a particular store draw.
    for(var grandPriceNo = 0; grandPriceNo < storeDraw.numberOfGrandPrices;grandPriceNo++){

        imageAndDescriptionIndex = Math.floor(Math.random()*grandPricesImages.length);

        // Point where to save a store draw grand price.
        drawGrandPriceReference = getFirestore()
        .collection("stores").doc(storeOwnersPhoneNumbers[storeIndex])
        .collection("store_draws").doc(storeDrawId)
        .collection("draw_grand_prices").doc();

        // Create a grand price
        drawGrandPrice = {
            isFake: 'Yes',
            grandPriceId: drawGrandPriceReference.id,
            storeDrawFK: storeDrawId,
            description: descriptions[imageAndDescriptionIndex],
            imageURL: grandPricesImages[imageAndDescriptionIndex],
            grandPriceIndex: grandPriceNo,
        };

        // Save a draw grand price
        await drawGrandPriceReference.set(drawGrandPrice);
    }

    let drawGroupCompetitor;
    let drawGroupCompetitorReference;

    // Create draw group competitors for a particular store draw. 
    // Note: group members may belong in more than one group which is not allowed in production.
    for(var groupCompetitorNo = 0; groupCompetitorNo < storeDraw.numberOfGroupCompetitorsSoFar;groupCompetitorNo++){


        let alcoholicsPhoneNumbersCopy = [];
        for(let i = 0; i < alcoholicsPhoneNumbers.length;i++){
          alcoholicsPhoneNumbersCopy.push(alcoholicsPhoneNumbers[i]);
        }
        
        shuffle(alcoholicsPhoneNumbersCopy);

        const groupMembers = [];
        const totalNoOfGroupMembers = 1 + Math.floor(Math.random()*alcoholicsPhoneNumbersCopy.length);
        for(let groupMemberNumber = 0; groupMemberNumber <totalNoOfGroupMembers;groupMemberNumber++){
          groupMembers.push(alcoholicsPhoneNumbersCopy[groupMemberNumber]);
        }

        // Point where to save a store draw competitor.
        drawGroupCompetitorReference = getFirestore()
        .collection('/stores/').doc(`${storeOwnersPhoneNumbers[storeIndex]}`)
        .collection('/store_draws/').doc(`${storeDrawId}`)
        .collection('/draw_groups_competitors/').doc(); 

        const pickedGroupIndex = Math.floor(
          Math.random()*fakeDrawGroupCompetitorsNames.length);
        const pickedGroupCreator = Math.floor(
          Math.random()*alcoholicsPhoneNumbers.length);
        const groupSpecificLocations = 
        ['Ringini', 'Ko 1Room', 'Ko 2Room', 'Stop 1' ];
        const groupSpecificLocationIndex = Math.floor(
          Math.random()*groupSpecificLocations.length);
        
        // Create a draw competitor;
        drawGroupCompetitor = {
            'groupCompetitorId': drawGroupCompetitorReference.id,
            'storeDrawFK': storeDrawId,
            'groupImageURL': fakeDrawGroupCompetitorsImages[pickedGroupIndex],
            'creatorUsername': alcoholicsUsernames[pickedGroupCreator],
            'creatorId': alcoholicsPhoneNumbers[pickedGroupCreator],
            'groupName': fakeDrawGroupCompetitorsNames[pickedGroupIndex],
            'groupNumber': groupCompetitorNo,
            'groupSpecificLocation': groupSpecificLocations[groupSpecificLocationIndex],
            'groupSectionName' : sectionNames[0],
            'groupMembers': groupMembers,
        };

        // Save draw competitor into the database.
        await drawGroupCompetitorReference.set(drawGroupCompetitor);
    }
  }
      
  res.json({result: `Done Saving Fake Store Draws.`});

});

// ########################################Development Functions [End]#######################################################


