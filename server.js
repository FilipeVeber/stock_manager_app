const express = require('express');
const path = require('path');

const app = express();

app.use(express.static(__dirname + '/build/web'));

app.get('/*', function (req, res) {
    res.sendFile(path.join(__dirname + '/build/web/index.html'));
});

// Start the app by listening on the default Heroku port
var port = process.env.PORT || 3000;
app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});