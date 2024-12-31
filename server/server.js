//sudo service mongod start incase u get an error MongoError: connect ECONNREFUSED

const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();
const app = express();

mongoose.connect(process.env.DATABASE_URL);

mongoose.connection.on('error', (error)=>{
    console.error(error);
});

mongoose.connection.once('open', ()=>{
    console.log("Connected to mongodb");
});

mongoose.connection.on( ' disconnected', ()=>{
    console.log("disconnected to mongodb");
});

app.use(express.json());

const diaryEntriesRouter = require('./routes/diaryEntries');
app.use('/diaryEntries', diaryEntriesRouter );

app.listen(process.env.PORT, ()=>{
    console.log("server started and listening on port 3000");
});
