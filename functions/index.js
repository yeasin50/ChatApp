const functions = require('firebase-functions');
const admin =  require('firebase-admin');

admin.initializeApp();

exports.myFunction =  functions.firestore
            .document('chat/{message}')
            .onCreate((snaphot, context)=>{
        
            return admin.messaging().sendToTopic( "chat", { 
                notification: {
                    title: snaphot.data().username,
                body: snaphot.data().text,
            clickAction:"FLUTTER_NOTIFICATION_CLICK",
             },
            });
              
        });