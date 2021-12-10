mongoose = require 'mongoose'

OrderSchema = mongoose.Schema {
  user: 
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  
  products: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product'
  }]
  total: 
    type: Number,
    default: 0
  
  status: 
    type: String,
    enum: ['pending', 'paid', 'shipped', 'delivered'],
    default: 'pending'
  
  createdAt: 
    type: Date,
    default: Date.now
  
}

module.exports = mongoose.model 'Order', OrderSchema