db.restaurants.find();
db.restaurants.find({}, {address:0,grades:0});
db.restaurants.find({}, {address:0,grades:0,_id:0});
db.restaurants.find({},{ restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0 });
db.restaurants.find({ borough: "Bronx" });
db.restaurants.find({ borough: "Bronx" }).limit(5);
db.restaurants.find({ borough: "Bronx" }).skip(5).limit(5);
db.restaurants.find({ "grades.score": { $gt: 90 } });
db.restaurants.find({ "grades.score": { $gt: 80, $lt: 100 } });
db.restaurants.find({'address.coord.1':{$lt: -95.754168}})
db.restaurants.find({$and:[{cuisine:{$not:/American/}},{'grades.score':{$gt:70}},{'address.coord.1':{$lt:-65.754168}}]})
db.restaurants.find({cuisine:{$not:/American/},'grades.score':{$gt:70},'address.coord.0':{$lt:-65.754168}})
db.restaurants.find({'grades.grade':'A',cuisine:{$not:/American/},borough:{$not:/Brooklyn/}}).sort({cuisine:-1}) 
db.restaurants.find({ name: { $regex: /^Wil/ } }, { address: 0, grades: 0, _id: 0 })
db.restaurants.find({ name: { $regex: /ces$/ } }, { address: 0, grades: 0, _id: 0 })
db.restaurants.find({ name: { $regex: 'Reg', $options: 'i' } }, { address: 0, grades: 0, _id: 0 })
db.restaurants.find({borough:'Bronx',cuisine:{$in:[/American/,/Chinese/]}})
db.restaurants.find({ $or:[{ borough: 'Staten Island' },{ borough: 'Queens' },{ borough: 'Bronx' },{ borough: 'Brooklyn' }]},{address: 0,grades: 0,_id: 0 })
db.restaurants.find({$nor:[{borough:'Staten Island'},{borough:'Queens'},{borough:'Bronx'},{borough:'Brooklyn'}]},{ address: 0, grades: 0, _id: 0 })
db.restaurants.find({ 'grades.score': { $lt: 10 } }, { address: 0, grades: 0, _id: 0 })
db.restaurants.find({$nor:[{cuisine:/American/},{cuisine:/Chinese/}],name:{ $not:/^Wil/}}, { address: 0, grades: 0, _id: 0 })
db.restaurants.find({ 'grades.grade': 'A', 'grades.score': 11, 'grades.date': ISODate("2014-08-11T00:00:00Z") }, { restaurant_id: 1, name: 1, grades: 1 })
db.restaurants.find({ 'grades.1.grade': 'A', 'grades.score': 9, 'grades.date': ISODate("2014-08-11T00:00:00Z") }, { restaurant_id: 1, name: 1, grades: 1 })
db.restaurants.find({ 'address.coord.1': { $gt: 42, $lte: 50 } }, { restaurant_id: 1, name: 1, address: 1, coord: 1 })
db.restaurants.find({}).sort({ name: 1, _id: 1, address: 1, borough: 1, cuisine: 1, grades: 1, restaurant_id: 1 })
db.restaurants.find({}).sort({ name: -1, _id: -1, address: -1, borough: -1, cuisine: -1, grades: -1, restaurant_id: -1 })
db.restaurants.find({}, { cuisine: 1, borough: 1 }).sort({ cuisine: 1, borough: -1 })
db.restaurants.find({ 'address.street': null })
db.restaurants.find({'address.coord':{type:1}})
db.restaurants.find({ 'grades.score': { $mod: [7, 0] } }, { restaurant_id: 1, name: 1, 'grades.grade': 1 })
db.restaurants.find({ name: { $regex: 'mon', $options: 'i' } }, { name: 1, borough: 1, 'address.coord': 1, cuisine: 1 })
db.restaurants.find({name:{$regex: '^Mad'}},{name:1,borough:1,cuisine:1,'address.coord':1})