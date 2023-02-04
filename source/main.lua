import 'libraries/noble/Noble'

import 'utilities/Utilities'

import 'entities/square'

import 'scenes/ExampleScene'
import 'scenes/ExampleScene2'
import 'scenes/TitleScreen'
import 'scenes/YogaStudio'


Noble.Settings.setup({
	Difficulty = "Medium"
})

Noble.GameData.setup({
	Score = 0
})

Noble.showFPS = true

Noble.new(TitleScreen, 1.5, Noble.TransitionType.CROSS_DISSOLVE)