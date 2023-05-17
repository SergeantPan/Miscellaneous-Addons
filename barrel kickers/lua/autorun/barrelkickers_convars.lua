CreateConVar( "BarrelKickersEnabled", "1", 128, "Enable/Disable the addon in its entirety" )

CreateConVar( "BarrelKickersDamageActivation", "1", 128, "Kick barrels with damage. 1 = Yes, 0 = No" )
CreateConVar( "BarrelKickersPromptActivation",  "1", 128, "Kick barrels using the 'KickBarrel' command. 1 = Yes, 0 = No" )

CreateConVar( "BarrelKickersIgniteBarrels", "1", 128, "Should barrels get ignited upon kick/hit. 1 = Yes, 0 = No" )
CreateConVar( "BarrelKickersNPCCanIgnite", "1", 128, "Allow/Disallow NPC's to ignite kicked barrels. 1 = Yes, 0 = No ")

CreateConVar( "BarrelKickersStrength", "750", 128, "The amount of force the object is flung with. Default is 750" )
CreateConVar( "BarrelKickersDistance", "60", 128, "Distance at which you are able to use the 'KickBarrel' command. Default is 60" )

CreateConVar( "BarrelKickersPromptXPos", "0.44", 128, "Adjust the horizontal position of the prompt. Default is 0.44" )
CreateConVar( "BarrelKickersPromptYPos", "0.51", 128, "Adjust the vertical position of the prompt. Default is 0.51" )

CreateConVar( "BarrelKickersIconXPos", "0.47", 128, "Adjust the horizontal position of the prompt icon. Default is 0.47" )
CreateConVar( "BarrelKickersIconYPos", "0.65", 128, "Adjust the vertical position of the prompt icon. Default is 0.65" )

CreateConVar( "BarrelKickersEnablePrompt", "1", 128, "Enable the 'Press X to kick barrel' prompt. 1 = Yes, 0 = No" )
CreateConVar( "BarrelKickersEnablePromptText", "1", 128, "Enable the 'Press X to kick barrel' text prompt. 1 = Yes, 0 = No" )
CreateConVar( "BarrelKickersEnablePromptIcon", "1", 128, "Enable the 'Press X to kick barrel' icon prompt. 1 = Yes, 0 = No" )

CreateConVar( "BarrelKickersNPCCanActivate", "1", 128, "Allow/Disallow NPC's from kicking barrels. 1 = Yes, 0 = No ")
CreateConVar( "BarrelKickersNPCRestricted", "0", 128, "Only allow Human/Combine/Zombies to kick barrels. 1 = Yes, 0 = No ")
CreateConVar( "BarrelKickersNPCStrength", "500", 128, "The amount of force objects kicked by NPC's will have. Default is 500" )

CreateConVar( "BarrelKickersBluntCanActivate", "1", 128, "Allow/Disallow kicking barrels with DMG_BLUNT (Crowbar, SMod Kick, Stunstick etc.) 1 = Yes, 0 = No ")
CreateConVar( "BarrelKickersSlashCanActivate", "1", 128, "Allow/Disallow kicking barrels with DMG_SLASH (Bladed weapons, manhacks, antlions etc.) 1 = Yes, 0 = No ")
CreateConVar( "BarrelKickersGenericCanActivate", "1", 128, "Allow/Disallow kicking barrels with DMG_GENERIC (GMod fists) 1 = Yes, 0 = No ")