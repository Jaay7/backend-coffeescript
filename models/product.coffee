mongoose = require 'mongoose'

ProductSchema = mongoose.Schema {
  name:
    type: String
    required: true
  description:
    type: String
    required: true
  price:
    type: Number
    required: true
  image:
    type: String
  category:
    type: String
    required: true
  subcategory:
    type: String
}

Product = module.exports = mongoose.model 'Product', ProductSchema