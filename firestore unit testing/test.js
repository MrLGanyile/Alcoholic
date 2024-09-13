import { readFileSync } from 'fs';
import {
    assertFails,
    assertSucceeds,
    initializeTestEnvironment,
    
  } from "@firebase/rules-unit-testing";



const PROJECT_ID = 'alcoholic-expressions';

const myUserData = {
  phoneNumber: '+27713498754',
  name:'Lwandile', 
  email:'lwa@gmail.com',
};

const theirUserData = {
  phoneNumber: '+27778908754',
  name:'Ntuthuko', 
  email:'gasa@gmail.com',
};

const storeOwnerData = {
  phoneNumber: '+27834321212',
};

const storeData = {
  storeOwnerPhoneNumber: storeOwnerData.phoneNumber,
  storeName: 'Nkuxa',
  sectionName: 'Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa',
  imageURL: '../../image.jpg',
  
};

const theirStoreOwnerData = {
  phoneNumber: '+27854567812',
};

const theirStoreData = {
  storeOwnerPhoneNumber: theirStoreOwnerData.phoneNumber,
  storeName: 'Nomusa',
  sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
  imageURL: '../../image.jpg',
};

const someId = '+27826354732';

describe('Our Alcoholic App',()=>{
  
  let testEnv = null;
  let myUser = null;
  let theirUser = null;
  let noUser = null;

  let storeOwnerUser = null;
  let theirStoreOwnerUser = null;
  
  beforeEach(async () => {
        
    testEnv = await initializeTestEnvironment({
      projectId: "alcoholic-expressions",
      firestore: {
        rules: readFileSync("../firestore.rules", "utf8"),
          host: "127.0.0.1",
          port: "8080"
      },
    });
    
    // clear datastore
    await testEnv.clearFirestore();
    //await testEnv.cleanup();

    myUser = testEnv.authenticatedContext(myUserData.phoneNumber);
    theirUser = testEnv.authenticatedContext(theirUserData.phoneNumber);
    noUser = testEnv.unauthenticatedContext();

    storeOwnerUser = testEnv.authenticatedContext(storeOwnerData.phoneNumber);
    theirStoreOwnerUser = testEnv.authenticatedContext(theirStoreOwnerData.phoneNumber);
    

    // Initial alcoholics
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(myUserData.phoneNumber).set(myUserData);
    });
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(theirUserData.phoneNumber).set(theirUserData);
    });

    // Initialize stores owners
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners').doc(storeOwnerData.phoneNumber).set(storeOwnerData);
    });
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners').doc(theirStoreOwnerData.phoneNumber).set(theirStoreOwnerData);
    });

    // Initialize stores
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber).set(storeData);
    });

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores').doc(theirStoreData.storeOwnerPhoneNumber).set(storeData);
    });
    
 });

  afterEach(async () => {

    //await testEnv.clearFirestore();
    await testEnv.cleanup();
    
  });
/*
  //================================Alcoholic [Start]===================================
  // Testing /alcoholics/{alcoholicId} 
  it('Offline User : Do not allow not logged in users to become alcoholics.', async()=>{

    const alcoholic = {
      phoneNumber: '+27635453456',
      profileImageURL: '../image.png',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = noUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they provide incomplete info[1].', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '../image.png',
      sectionName: null,
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they provide incomplete info[2].', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '../image.png',
      sectionName: "",
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.
  
  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they provide incomplete info[3].', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: null,
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they provide incomplete info[4].', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they provide not supported section name[5].', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '../image.png',
      sectionName: 'Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to become alcoholics if they already have.', async()=>{

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '../image.png',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(alcoholic.phoneNumber).set(alcoholic);
    });

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set({alcoholic, merge:true}));
  }); // Working As Expected.

  it('Online User : Allow logged in users to become alcoholics if they provide complete info.', async()=>{

    // Start by deleting myUser from the alcoholics collection.
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics')
      .doc(myUserData.phoneNumber).delete();
    });

    const alcoholic = {
      phoneNumber: myUserData.phoneNumber,
      profileImageURL: '../image.png',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = myUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertSucceeds(doc.set(alcoholic));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Store Owner : Do not allow store owners to become alcoholics.', async()=>{

    const alcoholic = {
      phoneNumber: '+27635453456',
      profileImageURL: '../image.png',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
    };

    const doc = storeOwnerUser.firestore().collection('alcoholics')
    .doc(alcoholic.phoneNumber);
    await assertFails(doc.set(alcoholic));
  }); // Working As Expected.
  


  // Testing /alcoholics/{alcoholicId} 
  it('Offline User : Allow not logged in users to view alcoholics.', async()=>{

    const doc = noUser.firestore().collection('alcoholics')
    .doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Allow logged in users to view alcoholics.', async()=>{

    const doc = myUser.firestore().collection('alcoholics')
    .doc(myUserData.userId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Store Owner : Allow store owners to view alcoholics.', async()=>{

    const doc = storeOwnerUser.firestore().collection('alcoholics')
    .doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.



  // Testing /alcoholics/{alcoholicId} 
  it('Offline User : Do not allow not logged in users to update alcoholics.', async()=>{

    const doc = noUser.firestore().collection('alcoholics')
    .doc(theirUserData.userId);
    await assertFails(doc.update({profileImageURL:'new data'}));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to update alcoholics\'data.', async()=>{

    const doc = myUser.firestore().collection('alcoholics')
    .doc(theirUserData.userId);
    await assertFails(doc.update({profileImageURL:'new data'}));
  }); // Working As Expected.

  // Testing /alcoholics/{alcoholicId} 
  it('Store Owner : Do not allow store owners to update any alcoholic account.', async()=>{

    const doc = storeOwnerUser.firestore().collection('alcoholics')
    .doc(theirUserData.userId);
    await assertFails(doc.update({profileImageURL:'new data'}));
  }); // Working As Expected.



  // Testing /alcoholics/{alcoholicId} 
  it('Offline User : Do not allow not logged in users to delete an alcoholic account.', async()=>{

    const doc = noUser.firestore().collection('alcoholics').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /alcoholics/{alcoholicId} 
  it('Online User : Do not allow logged in users to delete an alcoholic account.', async()=>{

    const doc = myUser.firestore().collection('alcoholics').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /alcoholics/{alcoholicId}  
  it('Store Owner : Do not allow store owners to delete an alcoholic account.', async()=>{

    const doc = storeOwnerUser.firestore().collection('alcoholics').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //================================Alcoholic [End]===================================


  //===================================Store [Start]==========================================

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Offline User : Do not allow not logged in users to register a store.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.set({data:' some data'}));
  }); // Working As Expected.

  
  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[1].', async()=>{

    const store = {
      storeName: null,
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: someId,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

   // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[2].', async()=>{

    const store = {
        storeName: '',
        sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
        imageURL: '../../image.jpg',
        storeOwnerPhoneNumber: someId,
    };
  
      const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
      await assertFails(doc.set(store));
  }); // Working As Expected.

    // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[3].', async()=>{

    const store = {
      storeName: 'MOdos',
      sectionName: null,
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: someId,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

    // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[4].', async()=>{

    const store = {
      storeName: 'MOdos',
      sectionName: '',
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: someId,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incorrect data[5].', async()=>{

      const store = {
        storeName: 'MOdos',
        sectionName: 'Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa',
        imageURL: '../../image.jpg',
        storeOwnerPhoneNumber: someId,
      };
  
      const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
      await assertFails(doc.set(store));
    }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[6].', async()=>{

      const store = {
        storeName: 'MOdos',
        sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
        imageURL: null,
        storeOwnerPhoneNumber: someId,
    };
  
    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users to create a store if they provide incomplete data[7].', async()=>{

    const store = {
      storeName: 'MOdos',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
      imageURL: '',
      storeOwnerPhoneNumber: someId,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Do not allow logged in users who are already alcoholics to create a store.', async()=>{

    const store = {
      storeName: 'MOdos',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: myUserData.phoneNumber,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Allow logged in users to create a store.', async()=>{

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(myUserData.phoneNumber).delete();
    });

    const store = {
      storeName: 'MOdos',
      sectionName: 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa',
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: myUserData.phoneNumber,
    };

    const doc = myUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertSucceeds(doc.set(store));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Store Owner : Do not allow store owners to register a store if they already have one.', async()=>{

    const store = {
      storeName: 'Nkuxa XYZ',
      sectionName: 'Mayville Cato Crest',
      imageURL: '../../image.jpg',
      storeOwnerPhoneNumber: someId,
    };

    const doc = storeOwnerUser.firestore().collection('stores').doc(store.storeOwnerPhoneNumber);
    await assertFails(doc.set(store));
  }); // Working As Expected.






  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Offline User : Allow not logged in users to view stores.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.


  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Online User : Allow logged in users to view stores.', async()=>{

    const doc = myUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Store Owner : Allow store owners to view stores.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  

  

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Offline User : Do not allow not logged in users to update any store.', async()=>{

    // The store is already created during initialization.
    const doc = noUser.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber);
    await assertFails(doc.update({storeName:'new data'}));
  }); // Working As Expected.


  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Store Owner : Do not allow store owners to update a store they do not own.', async()=>{

    // The store is already created during initialization.
    const doc = theirStoreOwnerUser.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber);
    await assertFails(doc.update({storeName:'new data'}));
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Store Owner : Allow store owners to update a store they own.', async()=>{

    // The store is already created during initialization.
    const doc = storeOwnerUser.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber);
    await assertSucceeds(doc.update({storeName:'new data'}));
  }); // Working As Expected.



  // Testing /stores/{storeOwnerPhoneNumber} 
  it('Offline User : Do not allow not logged in users to delete a store.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/{storeOwnerPhoneNumber}
  it('Online User : Do not allow logged in users to delete a store.', async()=>{

    const doc = myUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/{storeOwnerPhoneNumber}
  it('Store Owner : Do not allow store owners to delete a store they do not own.', async()=>{

    const doc = theirStoreOwnerUser.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber);
    await assertFails(doc.delete());
  }); // Working As Expected.

  // Testing /stores/{storeOwnerPhoneNumber}
  it('Store Owner : Do not allow store owners to delete store a store they do not own.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores').doc(storeData.storeOwnerPhoneNumber);
    await assertSucceeds(doc.delete());
  }); // Working As Expected.

  //===================================Store [End]==========================================

  //=================================Store Owner [Start]========================================
  // Testing /store_owners/{storeOwnerId} 
  it('Offline User : Do not allow not logged in users to register as store owners.', async()=>{

    const doc = noUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow logged in users to register as store owners if the their phone number is not the same as the docuement id.[1]', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow logged in users to register as store owners if they already have an alcoholic account.[2]', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(myUserData.phoneNumber);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow new logged in users to register as store owners if the store they own does not already exist.[3]', async()=>{

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(myUserData.phoneNumber).delete();
    });

    const doc = myUser.firestore().collection('store_owners').doc(myUserData.phoneNumber);
    await assertFails(doc.set(myUserData));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Allow new logged in users to register as store owners.', async()=>{

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(myUserData.phoneNumber).delete();
    });

    const store = {
      storeOwnerPhoneNumber: myUserData.phoneNumber,
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores').doc(store.storeOwnerPhoneNumber).set(store);
    });

    const doc = myUser.firestore().collection('store_owners').doc(store.storeOwnerPhoneNumber);
    await assertSucceeds(doc.set(myUserData));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Store Owner : Do not allow store owners to register as store owners more than once.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(storeOwnerData.phoneNumber);
    await assertFails(doc.set(storeOwnerData));
  }); // Working As Expected.



  // Testing /store_owners/{storeOwnerId} 
  it('Offline User : Allow not logged in users to view a single store owner.', async()=>{

    const doc = noUser.firestore().collection('store_owners').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Allow logged in users to view a single store owner.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(myUserData.userId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Store Owner : Allow store owners to view a single store owner.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(storeOwnerData.storeOwnerId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.





  // Testing /store_owners/{storeOwnerId} 
  it('Offline User : Do not allow not logged in users to query store owners.', async()=>{

    const collection = noUser.firestore().collection('store_owners');
    await assertFails(collection.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow logged in users to query store owners.', async()=>{

    const collection = noUser.firestore().collection('store_owners');
    await assertFails(collection.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Store Owner : Allow store owners to query store owners.', async()=>{

    const collection = storeOwnerUser.firestore().collection('store_owners');
    await assertSucceeds(collection.get());
  }); // Working As Expected.




  // Testing /store_owners/{storeOwnerId} 
  it('Offline User : Do not allow not logged in users to update any store owner data.', async()=>{

    const doc = noUser.firestore().collection('store_owners').doc(storeOwnerData.phoneNumber);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow logged in users to update any store owner data.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(storeOwnerData.phoneNumber);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  it('Store Owner : Do not allow store owners to update any store owner data.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(storeOwnerData.phoneNumber);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.



  // Testing /store_owners/{storeOwnerId} 
  it('Offline User : Do not allow not logged in users to delete store owner account.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  it('Online User : Do not allow logged in users to delete store owner account.', async()=>{

    const doc = myUser.firestore().collection('sstore_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  it('Store Owner : Do not allow store owners to delete store owner accounts.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //=================================Store Owner [End]========================================

*/
  //=====================Store Name Info [Start]============================
/*
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Offline User : Do not allow not logged in users to create store name info.', async()=>{

    const doc = noUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  it('Online User : Do not allow logged in users to create store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  it('Store Owner : Do not allow store owners to create store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.


  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Offline User : Allow not logged in users to view store name info.', async()=>{

    const doc = noUser.firestore().collection('stores_names_info').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  it('Online User : Allow logged in users to view store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(myUserData.userId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  it('Store Owner : Allow store owners to view store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  


  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Offline User : Do not allow not logged in users to update a store name info.', async()=>{

    const storeNameInfo = {
      data:'old data',
      storeNameInfoId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores_names_info')
      .doc(storeNameInfo.storeNameInfoId).set(storeNameInfo);
    });

    const doc = noUser.firestore().collection('stores_names_info').doc(storeNameInfo.storeNameInfoId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Online User : Do not allow logged in users to update a store name info.', async()=>{

    const storeNameInfo= {
      data:'old data',
      storeNameInfoId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores_names_info')
      .doc(storeNameInfo.storeNameInfoId).set(storeNameInfo);
    });

    const doc = myUser.firestore().collection('stores_names_info').doc(storeNameInfo.storeNameInfoId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Store Owner : Do not allow store owners to update a store name info.', async()=>{

    const storeNameInfo= {
      data:'old data',
      storeNameInfoId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores_names_info')
      .doc(storeNameInfo.storeNameInfoId).set(storeNameInfo);
    });

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(storeNameInfo.storeNameInfoId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.

  
  
  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Offline User : Do not allow not logged in users to delete store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Online User : Do not allow logged in users to delete store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  it('Store Owner : Do not allow store owners to delete store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //=====================Store Name Info[End]============================
*/

  


  //=====================Relationship [Start]============================
  
  // Testing /relationships/{userID} 
  it('Offline User : Do not allow not logged in users to create relationships.', async()=>{

    const doc = noUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Do not allow logged in users to create relationships.', async()=>{

    const doc = myUser.firestore().collection('relationships')
    .doc(someId);
    await assertFails(doc.set({data:'abc'}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Store Owner : Do not allow store owners to create relationships.', async()=>{
    
    const doc = storeOwnerUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.




  // Testing /relationships/{userID} 
  it('Offline User : Do not allow not logged in users to view relationships.', async()=>{

    const doc = noUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.get());
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Do not allow logged in users to view relationships not belonging to them.', async()=>{

    const relationship = {
      user3DigitToken: 'token_xyz',
      userFK: theirUserData.phoneNumber,
      joinedStoresFKs: [],
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('relationships')
      .doc(relationship.userFK).set(relationship);
    });

    const doc = myUser.firestore().collection('relationships')
    .doc(relationship.userFK);
    await assertFails(doc.get());
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Allow logged in users to view relationships they have created.', async()=>{

    const relationship = {
      user3DigitToken: 'token_arc',
      userFK: myUserData.phoneNumber,
      joinedStoresFKs: [],
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('relationships')
      .doc(relationship.userFK).set(relationship);
    });

    const doc = myUser.firestore().collection('relationships')
    .doc(relationship.userFK);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Store Owner User : Do not allow store owners to view relationships.', async()=>{

    const doc = storeOwnerUser.firestore().collection('relationships')
    .doc(someId);
    await assertFails(doc.get());
  }); // Working As Expected.
 
  


  // Testing /relationships/{userID} 
  it('Offline User : Do not allow not logged in users to update relationships.', async()=>{

    const doc = noUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.update({user3DigitToken:'new data'}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Do not allow logged in users to update relationships not belonging to them.', async()=>{

    const relationship = {
      user3DigitToken: 'token_xyz',
      userFK: theirUserData.phoneNumber,
      joinedStoresFKs: [],
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('relationships')
      .doc(relationship.userFK).set(relationship);
    });

    const doc = myUser.firestore().collection('relationships')
    .doc(relationship.userFK);
    await assertFails(doc.update({user3DigitToken:'new data'}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Do not allow logged in users to update a user3DigitToken on a relationship they have created.', async()=>{

    const relationship = {
      user3DigitToken: 'token_arc',
      userFK: myUserData.phoneNumber,
      joinedStoresFKs: [],
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('relationships')
      .doc(relationship.userFK).set(relationship);
    });

    const doc = myUser.firestore().collection('relationships')
    .doc(relationship.userFK);
    await assertFails(doc.update({user3DigitToken:'new data'}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Online User : Allow logged in users to update relationships they have created.', async()=>{

    const relationship = {
      user3DigitToken: 'token_arc',
      userFK: myUserData.phoneNumber,
      joinedStoresFKs: [],
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('relationships')
      .doc(relationship.userFK).set(relationship);
    });

    const doc = myUser.firestore().collection('relationships')
    .doc(relationship.userFK);
    await assertSucceeds(doc.update({joinedStoresFKs:['store_abc']}));
  }); // Working As Expected.

  // Testing /relationships/{userID} 
  it('Store Owner User : Do not allow store owners to update relationships.', async()=>{

    const doc = storeOwnerUser.firestore().collection('relationships')
    .doc(someId);
    await assertFails(doc.update({user3DigitToken:'new data'}));
  }); // Working As Expected.




  // Testing /relationships/{userID} 
  it('Offline User : Do not allow not logged in users to delete a relationship.', async()=>{

    const doc = noUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /relationships/{userID} 
  it('Online User : Do not allow logged in users to delete a relationship.', async()=>{

    const doc = myUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /relationships/{userID} 
  it('Store Owner : Do not allow store owners to delete relationships.', async()=>{

    const doc = storeOwnerUser.firestore().collection('relationships').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //=====================Relationship [End]============================

  
/*
  //=====================Won Price Summary [Start]============================

  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Offline User : Do not allow not logged in users to create a won price summary.', async()=>{

    const doc = noUser.firestore().collection('won_prices_summaries')
    .doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Online User : Do not allow logged in users to create a won price summary.', async()=>{

    const doc = myUser.firestore().collection('won_prices_summaries')
    .doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId}  
  it('Store Owner : Do not allow store owners to create a won price summary.', async()=>{

    const doc = storeOwnerUser.firestore().collection('won_prices_summaries')
    .doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.



  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Offline User : Allow not logged in users to view any won price summary.', async()=>{

    const doc = noUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Online User : Allow logged in users to view any won price summary.', async()=>{

    const doc = myUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId}  
  it('Store Owner : Allow store owners to view any won price summary.', async()=>{

    const doc = storeOwnerUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.



  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Offline User : Do not allow not logged in users to update a won price summary.', async()=>{

    const wonPriceSummary = {
      wonPriceSummaryId : 'info',
      data: 'old data',
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('won_prices_summaries')
      .doc(wonPriceSummary.wonPriceSummaryId).set(wonPriceSummary);
    });

    const doc = noUser.firestore().collection('won_prices_summaries')
    .doc(wonPriceSummary.wonPriceSummaryId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Online User : Do not allow logged in users to update a won price summary.', async()=>{

    const wonPriceSummary = {
      wonPriceSummaryId : 'info',
      data: 'old data',
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('won_prices_summaries')
      .doc(wonPriceSummary.wonPriceSummaryId).set(wonPriceSummary);
    });

    const doc = myUser.firestore().collection('won_prices_summaries')
    .doc(wonPriceSummary.wonPriceSummaryId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId}  
  it('Store Owner : Do not allow store owners to update a won price summary.', async()=>{

    const wonPriceSummary = {
      wonPriceSummaryId : 'info',
      data: 'old data',
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('won_prices_summaries')
      .doc(wonPriceSummary.wonPriceSummaryId).set(wonPriceSummary);
    });

    const doc = storeOwnerUser.firestore().collection('won_prices_summaries')
    .doc(wonPriceSummary.wonPriceSummaryId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.



  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Offline User : Do not allow not logged in users to delete a won price summary.', async()=>{

    const doc = noUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId} 
  it('Online User : Do not allow logged in users to delete a won price summary.', async()=>{

    const doc = myUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /won_prices_summaries/{wonPriceSummaryId}  
  it('Store Owner : Do not allow store owners to delete a won price summary.', async()=>{

    const doc = storeOwnerUser.firestore().collection('won_prices_summaries').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  //=====================Won Price Summary [End]============================

  //=====================Store Draw [Start]============================
  // Testing /stores/storeId/store_draws/{storeDrawId} 
  it('Offline User : Do not allow not logged in users to create a store draw.', async()=>{

    const storeDraw = {
      storeDrawId: 'store_draw_000',
      storeFK:storeData.storeId,
      drawDateAndTime: {
        weekday: 7, // Sunday
        hour: 8, // 8am
        minute: 0, 
        second: 0,
      },
      joiningFee: 10,
      numberOfCompetitorsSoFar: 0,
      isOpen: true,
      numberOfGrandPrices: 4,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }
    const doc = noUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.set(storeDraw));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/{storeDrawId} 
  it('Online User : Do not allow logged in users to create a store draw.', async()=>{
    
    const storeDraw = {
      storeDrawId: 'store_draw_000',
      storeFK:storeData.storeId,
      drawDateAndTime: {
        weekday: 7, // Sunday
        hour: 8, // 8am
        minute: 0, 
        second: 0,
      },
      joiningFee: 10,
      numberOfCompetitorsSoFar: 0,
      isOpen: true,
      numberOfGrandPrices: 4,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }
    const doc = myUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.set(storeDraw));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Do not allow store owners to create a store draw on a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'store_draw_000',
      storeFK:otherStoreData.storeId,
      drawDateAndTime: {
        weekday: 7, // Sunday
        hour: 8, // 8am
        minute: 0, 
        second: 0,
      },
      joiningFee: 10,
      numberOfCompetitorsSoFar: 0,
      isOpen: true,
      numberOfGrandPrices: 4,
      storeName: otherStoreData.storeName,
      storeImageURL: otherStoreData.imageURL,
      sectionName: otherStoreData.sectionName,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.set(storeDraw));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Do not allow store owners to create a store draw not within the acceptable day/time.', async()=>{

    const storeDraw = {
      storeDrawId: 'store_draw_000',
      storeFK:otherStoreData.storeId,
      drawDateAndTime: {
        weekday: 7, // Sunday
        hour: 14, // Not acceptable
        minute: 0, 
        second: 0,
      },
      joiningFee: 10,
      numberOfCompetitorsSoFar: 0,
      isOpen: true,
      numberOfGrandPrices: 4,
      storeName: otherStoreData.storeName,
      storeImageURL: otherStoreData.imageURL,
      sectionName: otherStoreData.sectionName,
    }
    const doc = otherStoreOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.set(storeDraw));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Allow store owners to create a store draw on a store they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'store_draw_000',
      storeFK:storeData.storeId,
      drawDateAndTime: {
        weekday: 7, // Sunday
        hour: 8, // 8am
        minute: 0, 
        second: 0,
      },
      joiningFee: 10,
      numberOfCompetitorsSoFar: 0,
      isOpen: true,
      numberOfGrandPrices: 4,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertSucceeds(doc.set(storeDraw));
  }); // Working As Expected.




  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Offline User : Allow not logged in users to view any store draw.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId)
    .collection('store_draws').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Online User : Allow logged in users to view any store draw.', async()=>{

    const doc = myUser.firestore().collection('stores').doc(someId)
    .collection('store_draws').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/{storeDrawId}    
  it('Store Owner : Allow store owners to view any store draw.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores').doc(someId)
    .collection('store_draws').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.



  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Offline User : Do not allow not logged in users to update a store draw.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = noUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.update({numberOfCompetitorsSoFar:5}));
  }); // Working As Expected.
  
  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Online User : Do not allow logged in users to update a store draw.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = myUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.update({numberOfCompetitorsSoFar:5}));
  }); // Working As Expected.
  
  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Do not allow store owners to update a store draw belonging to a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = otherStoreOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.update({numberOfCompetitorsSoFar:5}));
  });

  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Allow store owners to update a store draw belonging to a store they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertSucceeds(doc.update({numberOfCompetitorsSoFar:5}));
  }); // Working As Expected.




  // Testing /stores/storeId/store_draws/{storeDrawId}  
  it('Offline User : Do not allow not logged in users to delete a store draw.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = noUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Online User : Do not allow logged in users to delete a store draw.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = myUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Do not allow store owners to delete a store draw belonging to a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = otherStoreOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertFails(doc.delete());
  });

  // Testing/stores/storeId/store_draws/{storeDrawId}  
  it('Store Owner : Allow store owners to delete a store draw belonging to a store they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_bxb',
      storeFK: storeData.storeId,
      drawDateAndTime: Date.now(),
      joiningFee: 5,
      numberOfCompetitorsSoFar: 30,
      isOpen: true,
      numberOfGrandPrices: 2,
      storeName: storeData.storeName,
      storeImageURL: storeData.imageURL,
      sectionName: storeData.sectionName,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId);
    await assertSucceeds(doc.delete());
  }); // Working As Expected.

  //=====================Store Draw [End]============================

  //=====================Customer [Start]============================

  // Testing /stores/storeId/customers/{customerId}
  it('Offline User : Do not allow not logged in users to create customers.', async()=>{

    const doc = noUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Online User : Do not allow logged in users to create customers.', async()=>{

    const doc = myUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Store Owner : Do not allow store owners to create customers.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.




  // Testing /stores/storeId/customers/{customerId}
  it('Offline User : Do not allow not logged in users to view customers.', async()=>{

    const doc = noUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Online User : Do not allow logged in users to view customers.', async()=>{

    const doc = myUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Store Owner : Do not allow store owners to view customers belonging to a store they do not own.', async()=>{

    const customer = {
      customerId: 'customer_xyz',
      storeFK: otherStoreData.storeId,

    };

    await testEnv.withSecurityRulesDisabled(context=>{
      context.firestore().collection('stores')
      .doc(customer.storeFK).collection('customers')
      .doc(customer.customerId).set(customer);
    });
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(customer.storeFK).collection('customers')
    .doc(customer.customerId);
    await assertFails(doc.get());
  }); // Working As Expected.

  // Testing /stores/storeId/customers/{customerId}
  it('Store Owner : Allow store owners to view customers belonging to a store they own.', async()=>{

    const customer = {
      customerId: 'customer_xxx',
      storeFK: storeData.storeId,

    };

    await testEnv.withSecurityRulesDisabled(context=>{
      context.firestore().collection('stores')
      .doc(customer.storeFK).collection('customers')
      .doc(customer.customerId).set(customer);
    });
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(customer.storeFK).collection('customers')
    .doc(customer.customerId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.




  // Testing /stores/storeId/customers/{customerId}
  it('Offline User : Do not allow not logged in users to update customers.', async()=>{

    const customer = {
      customerId: 'some_costomer',
      storeFK: otherStoreData.storeId,
      user3DigitToken: 'token_123',
      imageURL: '../image.jpg',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(customer.storeFK).collection('customers')
      .doc(customer.customerId).set(customer);
    });

    const doc = noUser.firestore().collection('stores')
    .doc(customer.storeFK).collection('customers').doc(customer.customerId);
    await assertFails(doc.update({imageURL:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Online User : Do not allow logged in users to update customers.', async()=>{

    const customer = {
      customerId: 'some_costomer',
      storeFK: otherStoreData.storeId,
      user3DigitToken: 'token_123',
      imageURL: '../image.jpg',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(customer.storeFK).collection('customers')
      .doc(customer.customerId).set(customer);
    });

    const doc = myUser.firestore().collection('stores')
    .doc(customer.storeFK).collection('customers').doc(customer.customerId);
    await assertFails(doc.update({imageURL:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Store Owner : Do not allow store owners to update customers.', async()=>{

    const customer = {
      customerId: 'some_costomer',
      storeFK: otherStoreData.storeId,
      user3DigitToken: 'token_123',
      imageURL: '../image.jpg',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(customer.storeFK).collection('customers')
      .doc(customer.customerId).set(customer);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(customer.storeFK).collection('customers').doc(customer.customerId);
    await assertFails(doc.update({imageURL:'some data'}));
  }); // Working As Expected.





  // Testing /stores/storeId/customers/{customerId}
  it('Offline User : Do not allow not logged in users to delete customers.', async()=>{

    const doc = noUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Online User : Do not allow logged in users to delete customers.', async()=>{

    const doc = myUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/storeId/customers/{customerId}
  it('Store Owner : Do not allow store owners to delete customers.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(someId).collection('customers').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  //=====================Customer [End]============================

  //=====================Store Draw Grand Price [Start]============================

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Offline User : Do not allow not logged in users to create store draw grand prices.', async()=>{

    const doc = noUser.firestore().collection('stores')
    .doc(someId).collection('draw_grand_prices').doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Online User : Do not allow logged in users to create store draw grand prices.', async()=>{

    const doc = myUser.firestore().collection('stores')
    .doc(someId).collection('draw_grand_prices').doc(someId);
    await assertFails(doc.set({data:'some data'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices for a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: otherStoreData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[1].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: null,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[2].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: '',
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[3].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: null,
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[4].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '',
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[5].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: null,
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[6].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[7].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:null,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to create store draw grand prices with missing/incorrect info[1].', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:-1,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.set(drawGrandPrice));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Allow store owners to create store draw grand prices on stores they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
    }

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }
    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(storeDraw.storeDrawId)
    .collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertSucceeds(doc.set(drawGrandPrice));
  }); // Working As Expected.




  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Offline User : Allow not logged in users to view any store draw grand prices.', async()=>{

    const doc = noUser.firestore().collection('stores')
    .doc(someId).collection('store_draws').doc(someId)
    .collection('draw_grand_prices').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Online User : Allow logged in users to view any store draw grand prices.', async()=>{

    const doc = myUser.firestore().collection('stores')
    .doc(someId).collection('store_draws').doc(someId)
    .collection('draw_grand_prices').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}  
  it('Store Owner : Allow store owners to view any store draw grand prices.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(someId).collection('store_draws').doc(someId)
    .collection('draw_grand_prices').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.




  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Offline User : Do not allow not logged in users to update store draw grand prices.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = noUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.update({description:'new description'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Online User : Do not allow logged in users to update store draw grand prices.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = myUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.update({description:'new description'}));
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to update store draw grand prices belonging to a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: otherStoreData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.update({description:'new description'}));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to update store draw grand prices created by another owner.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = otherStoreOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.update({description:'new description'}));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to update store draw grand prices created by them on a store they own if it no longer open.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: false,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.update({description:'new description'}));
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Allow store owners to update store draw grand prices created by them on a store they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertSucceeds(doc.update({description:'new description'}));
  }); // Working As Expected.




  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Offline User : Do not allow not logged in users to delete store draw grand prices.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = noUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Online User : Do not allow logged in users to delete store draw grand prices.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = myUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to delete store draw grand prices belonging to a store they do not own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: otherStoreData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to delete store draw grand prices created by another owner.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = otherStoreOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Do not allow store owners to delete store draw grand prices created by them on a store they own if it no longer open.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: false,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  // Testing /stores/storeId/store_draws/storeDrawId/draw_grand_prices/{grandPriceId}
  it('Store Owner : Allow store owners to delete store draw grand prices created by them on a store they own.', async()=>{

    const storeDraw = {
      storeDrawId: 'draw_123',
      storeFK: storeData.storeId,
      isOpen: true,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(storeDraw.storeDrawId).set(storeDraw);
    });

    const drawGrandPrice = {
      grandPriceId: 'some-gp-id',
      storeDrawFK: storeDraw.storeDrawId,
      imageURL: '../image.jpg',
      description: '###',
      grandPriceIndex:0,
    }

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores')
      .doc(storeDraw.storeFK).collection('store_draws')
      .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
      .doc(drawGrandPrice.grandPriceId).set(drawGrandPrice);
    });

    const doc = storeOwnerUser.firestore().collection('stores')
    .doc(storeDraw.storeFK).collection('store_draws')
    .doc(drawGrandPrice.storeDrawFK).collection('draw_grand_prices')
    .doc(drawGrandPrice.grandPriceId);
    await assertSucceeds(doc.delete());
  }); // Working As Expected.
  //=====================Store Draw Grand Price [End]============================
*/
});
