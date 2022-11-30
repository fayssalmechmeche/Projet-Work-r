const express = require('express')
const actions = require('../methods/actions')

const router = express.Router()

router.get('/', (req,res)=> {
    res.send('Hello World')
})

router.get('/dashboard', (req,res)=> {
    res.send('dashboard')
})


router.post('/adduser',actions.addNew)
router.get('/authenticate',actions.authenticate)
module.exports= router