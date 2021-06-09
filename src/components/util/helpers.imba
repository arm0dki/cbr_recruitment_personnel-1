
export var delayer = do |_callback , timer| 
	clearTimeout(timer)
	timer = setTimeout(&,1300) do |s|
		_callback()
	return timer