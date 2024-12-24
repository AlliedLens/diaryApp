const express = require('express');
const router = express.Router();
const DiaryEntry = require('../models/diaryEntry');
module.exports = router;

// GET all
router.get('/all', async (req, res)=>{
    try {
        const diaryentries = await DiaryEntry.find();
        return res.status(200).json(diaryentries);
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
});

// CREATE NEW ENTRY
router.post('/new', async(req, res)=>{
    
    const diaryEntry = new DiaryEntry({
        entry: req.body.entry,
        title: req.body.title,
        date: req.body.date,
        tags: req.body.tags,
        mood: req.body.mood
    });

    try {
        const newDiaryEntry = diaryEntry.save();
        return res.status(200).json(newDiaryEntry);
    } catch (error) {
        return res.status(400).json({message: error.message});
    }
});

// CREATE MULTIPLE ENTRIES

router.post('/many-new', async (req, res) => {
    const entries = req.body; 
  
    try {
      const savedEntries = [];
      for (const entry of entries) {
        const diaryEntry = new DiaryEntry(entry);
        const savedEntry = await diaryEntry.save();
        savedEntries.push(savedEntry);
      }
      return res.status(200).json(savedEntries);
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  });

//UPDATE ONE ENTRY

router.patch('/update/:id', getDiaryEntry, async(req, res)=>{
    console.log(res.locals);

    if (req.body.entry != null){
        res.locals.diaryentry.entry = req.body.entry;    
    }

    if (req.body.tags != null){
        res.locals.diaryentry.tags = req.body.tags;    
    }


    if (req.body.mood != null){
        res.locals.diaryentry.mood = req.body.mood;    
    }

    if (req.body.title != null){
        res.locals.diaryentry.title = req.body.title;
    }

    try {
        const updatedDiaryEntry = await res.locals.diaryentry.save();
        return res.json(updatedDiaryEntry);    
    } catch (error) {
        return res.status(500).json({message: error.message});   
    }

})

// CLEAR ALL ENTRIES
router.delete('/clear-all', async (req, res) =>{
    try {
        const result = await DiaryEntry.deleteMany({});
        if (result.deletedCount > 0){
            return res.status(200).json({message: "success deleted"});
        }else{
            return res.status(200).json({message: "already empty"});
        }
    } catch (error) {
        return res.status(500).json({message: error.message})
    }
})

// CLEAR ONE ENTRY
router.delete('/clear/:id', getDiaryEntry,  async(req, res) => {
    try {
        // console.log(Object.keys(res.locals.diaryentry));
        await DiaryEntry.findByIdAndDelete(req.params.id);
        return res.status(200).json({message:`entry ${req.params.id} deleted`, deletedObj : res.locals.diaryentry});
    } catch (error) {
        return res.status(404).json({message:error.message});
    }
})


async function getDiaryEntry(req, res, next) {
    try {
        diaryentry = await DiaryEntry.findById(req.params.id);
        // console.log(diaryentry);
        if (diaryentry == null){
            return res.status(404).json({message: "Cannot find DiaryEntry"});
        }
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
    
    res.locals.diaryentry = diaryentry;
    next();
}

