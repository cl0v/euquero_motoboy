// "use strict";
// Object.defineProperty(exports, "__esModule", {value: true});
// exports.sendToTopic = void 0;
import functions = require("firebase-functions") ;
import admin = require("firebase-admin");
admin.initializeApp();
// const db = admin.firestore();
const fcm = admin.messaging();
exports.sendToTopic = functions.firestore
    .document("franchise/{franchiseId}/order/{orderId}")
    .onCreate(async (_) => {
    // const order = snapshot.data();
      const payload = {
        notification: {
          title: "Nova viagem",
          body: "Toque para visualizar.",
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
// # sourceMappingURL=index.js.map
