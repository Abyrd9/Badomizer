export var to_object = do |arr|
  var rv = {}

  for item in arr
    rv[item:id] = item
  rv
