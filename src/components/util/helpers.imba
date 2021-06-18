
export var delayer = do |_callback , timer| 
	clearTimeout(timer)
	timer = setTimeout(&,1300) do |s|
		_callback()
	return timer

export def arraySum arr
	let sum = 0
	if arr:length
		sum = arr:reduce(do |a, b|
			return (parseFloat(a) || 0) + (parseFloat(b) || 0)
		)
	else
		sum = 0
	return sum