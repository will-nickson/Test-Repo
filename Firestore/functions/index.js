const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();
db.settings({ timestampsInSnapshots: true });

exports.imageAdded = functions.firestore
    .document('images/{imageId}')
    .onCreate(updatePhotosCount);

exports.imageDeleted = functions.firestore
    .document('images/{imageId}')
    .onDelete(updatePhotosCount);

function updatePhotosCount(snapshot) {
    const albumId = snapshot.data().albumId;

    return db.collection('images').where('albumId', '==', albumId).get()
        .then(snapshot => {
            return snapshot.docs.length || 0;
        }).then(count => {
            return db.collection('albums').doc(albumId).update({ 'numberOfPhotos': count });
        });
}