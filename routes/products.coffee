express = require 'express'
router = express.Router()

Product = require '../models/product'

router.post '/addProduct', (req, res) ->
  newProduct = new Product {
    name: req.body.name,
    description: req.body.description,
    price: req.body.price,
    image: req.body.image,
    category: req.body.category,
    subcategory: req.body.subcategory
  }
  newProduct.save (err, product) ->
    if err
      res.json { success: false, message: 'Error' + err }
    else
      res.json { success: true, message: 'Product added' }

router.get '/getProducts', (req, res) ->
  Product.find (err, products) ->
    if err
      res.json { success: false, message: 'Error' + err }
    else
      res.json { success: true, products: products }

router.get '/getProduct/:id', (req, res) ->
  Product.findById(req.params.id, (err, product) ->
    if err
      res.json { success: false, message: 'Error' + err }
    else
      res.json { success: true, product: product }
  )

module.exports = router
