import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// const db = admin.firestore();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore
    .document("order/{orderId}")
    .onCreate(async (snapshot) => {
    // const order = snapshot.data();

      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "Nova viagem",
          body: "Aceitar viagem",
        },
      };

      return fcm.sendToTopic("order", payload);
    });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
