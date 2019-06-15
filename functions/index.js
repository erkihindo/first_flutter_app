const functions = require('firebase-functions');
const cors = require('cors')({origin: true});
const Busboy = require('busboy');
const os = require('os');
const path = require('path');
const fs = require('fs');
const fbAdmin = require('firebase-admin');
const uuid = require('uuid/v4');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
const gcconfig = {
	projectId: 'first-flutter-app-9a199',
	keyFilename: 'first-flutter-app.json'
};

const gcs = require('@google-cloud/storage')(gcconfig);

fbAdmin.initializeApp({credential: fbAdmin.credential.cert(require('./first-flutter-app.json'))});
exports.storeImage = functions.https.onRequest((request, response) => {
	return cors(request, response, () => {
		if(request.method !== 'POST') {
			return response.status(500).json({message: 'Not allowed.'});
		}

		if(!request.headers.authorization || !request.headers.authorization.startsWith('Bearer ')) {
			return response.status(403).json({message: 'Unauthorized.'});
		}

		let idToken;
		idToken = request.headers.authorization.split('Bearer ')[1];

		const busboy = new Busboy({headers: request.headers});
		let uploadData;
		let oldImagePath;

		busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
			const filePath = path.join(os.tmpdir(), filename);
			uploadData = {filePath: filePath, type: mimetype, name: filename};
			file.pipe(fs.createWriteStream(filePath));
		});

		busboy.on('field', (fieldname, value) => {
			oldImagePath = decodeURIComponent(value);
		});

		busboy.on('finish', () => {
			const bucket = gcs.bucket('first-flutter-app-9a199.appspot.com');
			const id = uuid();

		let imagePath = 'images/' + id + '-' + uploadData.name;
		if (oldImagePath) {
			imagePath = oldImagePath;
		}

		return fbAdmin.auth().verifyIdToken(idToken).then(decodedToken => {
			return bucket.upload(uploadData.filePath, {
				uploadType: 'media',
				destination: imagePath,
				metadata: {
					metadata: {
						contentType: uploadData.type,
						firebaseStorageDownloadToken: id
					}
				}
			});
		}).then(() => {
			return response.status(201).json({
				imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + bucket.name + '/o/' + encodeURIComponent(imagePath) + '?alt=media&token=' + id,
				imagePath: imagePath
			})
		})

		.catch(error => {
			return response.status(401).json({error: 'UnAuth'});
		});
		});

		return busboy.end(request.rawBody);
	});
});