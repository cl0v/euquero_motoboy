// "use strict";
// Object.defineProperty(exports, "__esModule", {value: true});
// exports.sendToTopic = void 0;
import functions = require("firebase-functions") ;
import admin = require("firebase-admin");
admin.initializeApp();
// const db = admin.firestore();
const fcm = admin.messaging();

exports.sendToTopic = functions.firestore
    .document("franchise/{franchiseId}/openOrders/{openOrdersId}")
    .onCreate(async (snapshot, context) => {
    // const order = snapshot.data();
      const payload = {
        notification: {
          title: "Nova Viagem",
          body: "Toque para visualizar.",
        },
      };
      return fcm.sendToTopic("order", payload);
    });

exports.requestPayment = functions.firestore.document