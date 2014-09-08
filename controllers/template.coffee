exports.prefix = '/template';

exports.before = (req, res, next)->

  req.getMyStick = (id)->
    'your stik id is:' + id

  next()

exports.index = (req, res, next)->
  console.log req.getMyStick(4)
  res.render 'template'
