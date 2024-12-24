const mongoose = require('mongoose');

const diaryEntrySchema = new mongoose.Schema(
    {
        entry: {
            type: String,
            required: true
        },

        title:{
            type:String, 
            required:true
        },

        tags: {
            type : [String]
        },    

        mood : {
            type: String, 
            required: true,
        },

        date : {
            type: String,
            required: true,
            default: new Date().toJSON().slice(0,10).replace(/-/g,'/')    
        }
    }
);


module.exports = mongoose.model('DiaryEntry', diaryEntrySchema);