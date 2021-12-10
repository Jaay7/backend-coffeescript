express = require 'express'
router = express.Router()

Order = require '../models/order'

router.post '/takeOrder/:id', (req, res) -> 
  newOrder = new Order {
    user: req.params.id,
    products: req.body.products,
    total: req.body.total
  }
  newOrder.save (err, order) ->
    if err 
      res.json { success: false, message: 'Error: ' + err }
    else
      res.json { success: true, message: 'Order taken' }
    


router.get '/getOrderDetails/:id', (req, res) -> 
  Order.findOne { user: req.params.id }, (err, order) -> 
    if err 
      res.json { success: false, message: 'Error: ' + err }
    else 
      res.json { success: true, order: order }
  

router.post '/updateOrderStatus/:id', (req, res) ->
  Order.findOneAndUpdate { user: req.params.id }, { status: req.body.status }, (err, order) ->
    if err 
      res.json { success: false, message: 'Error: ' + err }
    else 
      res.json { success: true, message: 'Order status updated' }
  

module.exports = router