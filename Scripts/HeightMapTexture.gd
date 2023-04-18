extends TextureRect
tool

func update_with_heights(heights):
	var image = Image.new()
	image.create(heights.size(), heights[0].size(), false, Image.FORMAT_RGB8)
	
	image.lock()
	for i in heights.size():
		for j in heights[i].size():
			var channel = heights[i][j]
			image.set_pixel(i, j, Color(channel, channel, channel, 1))
	image.unlock()
	
	 
#	image.fill(Color(1,1,1))
	
	var imageTexture = ImageTexture.new()
	imageTexture.create_from_image(image)
	self.texture = imageTexture
		
