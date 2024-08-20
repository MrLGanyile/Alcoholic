import { readFileSync } from 'fs';
import {
    assertFails,
    assertSucceeds,
    initializeTestEnvironment,
    
  } from "@firebase/rules-unit-testing";



const PROJECT_ID = 'alcoholic-expressions';

const myId = 'user_abc';
const myUserData = {
  userId: myId,
  name:'Lwandile', 
  email:'lwa@gmail.com',
};

const theirId = 'user_def';
const theirUserData = {
  userId: theirId,
  name:'Ntuthuko', 
  email:'gasa@gmail.com',
};

const storeOwnerId = 'store_owner_123';
const storeOwnerData = {
  storeOwnerId: storeOwnerId,
};

const otherStoreOwnerId = 'store_owner_333';
const otherStoreOwnerData = {
  storeOwnerId: otherStoreOwnerId,
};

const storeId = 'store_abc';
const storeData = {
  storeId: storeId,
  storeName: 'Nkuxa',
  sectionName: 'Mayville Cato Crest',
  imageURL: '../../image.jpg',
  storeOwnerFK: storeOwnerId,
};

const adminId = 'admin_123';
const adminData = {
  userId: adminId,
  isAdmin: true,
  isOwner: false,
};

const someId = 'someId';

describe('Our Alcoholic App',()=>{
  
  let testEnv = null;
  let myUser = null;
  let theirUser = null;
  let noUser = null;

  let storeOwnerUser = null;
  let otherStoreOwnerUser = null;
  let adminUser = null;
  
  beforeEach(async () => {
        
    testEnv = await initializeTestEnvironment({
      projectId: "alcoholic-expressions",
      firestore: {
        rules: readFileSync("firestore.rules", "utf8"),
          host: "127.0.0.1",
          port: "8080"
      },
    });
    
    // clear datastore
    //await testEnv.clearFirestore();
    //await testEnv.cleanup();

    myUser = testEnv.authenticatedContext(myId);
    theirUser = testEnv.authenticatedContext(theirId);
    noUser = testEnv.unauthenticatedContext();

    storeOwnerUser = testEnv.authenticatedContext(storeOwnerId);
    otherStoreOwnerUser = testEnv.authenticatedContext(otherStoreOwnerId);
    adminUser = testEnv.authenticatedContext(adminId);
    

    // Initial alcoholics
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(myId).set(myUserData);
    });
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('alcoholics').doc(theirId).set(theirUserData);
    });

    // Initialize stores owners
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners').doc(storeOwnerId).set(storeOwnerData);
    });
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners').doc(otherStoreOwnerId).set(otherStoreOwnerData);
    });

    // Initialize stores
    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('stores').doc(storeId).set(storeData);
    });

    
    
 });

  afterEach(async () => {

    await testEnv.clearFirestore();
    //await testEnv.cleanup();
    
  });
  /*
  //=====================Represent All Stores[Start]============================
  
  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Offline User : Do not allow not logged in users to create store name info.', async()=>{

    const doc = noUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Online User : Do not allow logged in users to create store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Store Owner : Do not allow store owners to create store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.


  
  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Offline User : Allow not logged in users to view store name info.', async()=>{

    const doc = noUser.firestore().collection('stores_names_info').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Online User : Allow logged in users to view store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(myUserData.userId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Store Owner : Allow store owners to view store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  


  
  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
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
  // Use Case Name & Number - Represent All Stores 1C.
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
  // Use Case Name & Number - Represent All Stores 1C.
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
  // Use Case Name & Number - Represent All Stores 1C.
  it('Offline User : Do not allow not logged in users to delete store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Online User : Do not allow logged in users to delete store name info.', async()=>{

    const doc = myUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores_names_info/{storeNameInfoId} 
  // Use Case Name & Number - Represent All Stores 1C.
  it('Store Owner : Do not allow store owners to delete store name info.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores_names_info').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //=====================Represent All Stores[End]============================


  //=====================Store Owner CRUD[Start]============================
  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to register as store owners.', async()=>{

    const doc = noUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Allow logged in users to register as store owners.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(someId);
    await assertSucceeds(doc.set({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to register as store owners more than once.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.set({data:'new data'}));
  }); // Working As Expected.



  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Allow not logged in users to view a single store owner.', async()=>{

    const doc = noUser.firestore().collection('store_owners').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Allow logged in users to view a single store owner.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(myUserData.userId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Allow store owners to view a single store owner.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(storeOwnerData.storeOwnerId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.





  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to query store owners.', async()=>{

    const collection = noUser.firestore().collection('store_owners');
    await assertFails(collection.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Do not allow logged in users to query store owners.', async()=>{

    const collection = noUser.firestore().collection('store_owners');
    await assertFails(collection.get());
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Allow store owners to query store owners.', async()=>{

    const collection = storeOwnerUser.firestore().collection('store_owners');
    await assertSucceeds(collection.get());
  }); // Working As Expected.




  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to update any store owner data.', async()=>{

    const storeOwner = {
      data:'old data',
      storeOwnerId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners')
      .doc(storeOwner.storeOwnerId).set(storeOwner);
    });

    const doc = noUser.firestore().collection('store_owners').doc(storeOwner.storeOwnerId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.

  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Do not allow logged in users to update any store owner data.', async()=>{

    const storeOwner = {
      data:'old data',
      storeOwnerId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners')
      .doc(storeOwner.storeOwnerId).set(storeOwner);
    });

    const doc = myUser.firestore().collection('store_owners').doc(storeOwner.storeOwnerId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to update any store owner data.', async()=>{

    const storeOwner = {
      data:'old data',
      storeOwnerId: 'abc',
    };

    await testEnv.withSecurityRulesDisabled(context=>{
      return context.firestore().collection('store_owners')
      .doc(storeOwner.storeOwnerId).set(storeOwner);
    });

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(storeOwner.storeOwnerId);
    await assertFails(doc.update({data:'new data'}));
  }); // Working As Expected.



  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to delete store owner account.', async()=>{

    const doc = myUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Do not allow logged in users to delete store owner account.', async()=>{

    const doc = myUser.firestore().collection('sstore_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /store_owners/{storeOwnerId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to delete store owner accounts.', async()=>{

    const doc = storeOwnerUser.firestore().collection('store_owners').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  //=====================Store Owner CRUD[End]============================

  //=====================Store CRUD[Start]============================
  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to register a store.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.set({data:' some data'}));
  }); // Working As Expected.

  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Allow logged in users to become store owners iff they are not already.', async()=>{


    const store = {
      storeId: 'store_abc',
      storeName: 'Nkuxa',
      sectionName: 'Mayville Cato Crest',
      imageURL: '../../image.jpg',
      storeOwnerFK: theirId,
    };

    const doc = theirUser.firestore().collection('stores').doc(store.storeId);
    await assertSucceeds(doc.set(store));
  }); // Working As Expected.

//************************************Fails*********************************************** 
  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to register a store if they already have one.', async()=>{

    const store = {
      storeId: 'store_abc',
      storeName: 'Nkuxa XYZ',
      sectionName: 'Mayville Cato Crest',
      imageURL: '../../image.jpg',
      storeOwnerFK: storeOwnerId,
    };

    const doc = storeOwnerUser.firestore().collection('stores').doc(store.storeId);
    await assertFails(doc.set(store));
  }); 
//*********************************************************************************** 
*/
  

  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Allow not logged in users to view stores.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.


  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Allow logged in users to view stores.', async()=>{

    const doc = myUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.

  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Allow store owners to view stores.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores').doc(someId);
    await assertSucceeds(doc.get());
  }); // Working As Expected.
  

  

  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to update any store.', async()=>{

    // The store is already created during initialization.
    const doc = noUser.firestore().collection('stores').doc(storeId);
    await assertFails(doc.update({storeName:'new data'}));
  }); // Working As Expected.


  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to update a store they do not own.', async()=>{

    // The store is already created during initialization.
    const doc = otherStoreOwnerUser.firestore().collection('stores').doc(storeId);
    await assertFails(doc.update({storeName:'new data'}));
  }); // Working As Expected.

  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Allow store owners to update a store they own.', async()=>{

    // The store is already created during initialization.
    const doc = storeOwnerUser.firestore().collection('stores').doc(storeId);
    await assertSucceeds(doc.update({storeName:'new data'}));
  }); // Working As Expected.



  // Testing /stores/{storeId} 
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Offline User : Do not allow not logged in users to delete a store.', async()=>{

    const doc = noUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/{storeId}
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Online User : Do not allow logged in users to delete a store.', async()=>{

    const doc = myUser.firestore().collection('stores').doc(someId);
    await assertFails(doc.delete());
  }); // Working As Expected.
  
  // Testing /stores/{storeId}
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to delete a store they do not own.', async()=>{

    const doc = otherStoreOwnerUser.firestore().collection('stores').doc(storeId);
    await assertFails(doc.delete());
  }); // Working As Expected.

  // Testing /stores/{storeId}
  // Use Case Name & Number - CRUD For Stores 2C.
  it('Store Owner : Do not allow store owners to delete store a store they do not own.', async()=>{

    const doc = storeOwnerUser.firestore().collection('stores').doc(storeId);
    await assertSucceeds(doc.delete());
  }); // Working As Expected.

  //=====================Store CRUD[Start]============================
});
