import 'libraries/noble/Noble'
import 'libraries/AnimatedSprite/AnimatedSprite'
import 'entities/JointWrapper'
import 'utilities/Utilities'

import 'scenes/ExampleScene'
import 'scenes/ExampleScene2'
import 'scenes/TitleScreen'
import 'scenes/CodyTest'
import 'scenes/YogaStudio'


import 'entities/JointSelector'
import 'entities/Joint'
import 'entities/ScoringPoint'

Noble.Settings.setup({
	Difficulty = "Medium"
})

Noble.GameData.setup({
	Score = 0
})

Noble.showFPS = true
Noble.new(CodyTest, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
