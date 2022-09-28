behaviour("VehicleRadio")

local hasAlreadyPlayedMusic = false

function VehicleRadio:Start()
	
	--Base
	self.musicPlaylist = self.targets.musicplaylist
	self.radioAudSrc = self.targets.radiosource

	self.radioAudSrc.SetActive(false)

	--Keybinds and Settings
	self.alwaysPlay = self.script.mutator.GetConfigurationBool("alwaysPlay")
	self.onlyPlayWhenDriver = self.script.mutator.GetConfigurationBool("onlyDriver")
	self.radioToggle = string.lower(self.script.mutator.GetConfigurationString("radioToggle"))

end

function VehicleRadio:Update()
	
	if Player.actor.activeVehicle ~= nil then
		
		self.radioAudSrc.transform.position = Player.actor.transform.position
		self.radioAudSrc.SetActive(true)

		if Player.actor.isDriver == false and self.onlyPlayWhenDriver == false then
			if hasAlreadyPlayedMusic == false and self.alwaysPlay then
				self.musicPlaylist.gameObject.GetComponent(SoundBank).SetVolume(100)
				self.musicPlaylist.gameObject.GetComponent(SoundBank).PlayRandom()
				self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 100
				hasAlreadyPlayedMusic = true
			end
	
			if Input.GetKeyDown(self.radioToggle) and self.alwaysPlay == false then
				self.playMusic = not self.playMusic
	
				if self.playMusic and hasAlreadyPlayedMusic == false then
					self.musicPlaylist.gameObject.GetComponent(SoundBank).SetVolume(100)
					self.musicPlaylist.gameObject.GetComponent(SoundBank).PlayRandom()
					self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 100
					hasAlreadyPlayedMusic = true
				else
					self.radioAudSrc.SetActive(false)
					self.radioAudSrc.gameObject.GetComponent(AudioSource).Stop()
					self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 0
					hasAlreadyPlayedMusic = false
				end
			end
	
			if self.radioAudSrc.gameObject.GetComponent(AudioSource).isPlaying == false then
				hasAlreadyPlayedMusic = false
			end
		else
			if hasAlreadyPlayedMusic == false and self.alwaysPlay and Player.actor.isDriver then
				self.musicPlaylist.gameObject.GetComponent(SoundBank).SetVolume(100)
				self.musicPlaylist.gameObject.GetComponent(SoundBank).PlayRandom()
				self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 100
				hasAlreadyPlayedMusic = true
			end
	
			if Input.GetKeyDown(self.radioToggle) and self.alwaysPlay == false and Player.actor.isDriver then
				self.playMusic = not self.playMusic
	
				if self.playMusic and hasAlreadyPlayedMusic == false then
					self.musicPlaylist.gameObject.GetComponent(SoundBank).SetVolume(100)
					self.musicPlaylist.gameObject.GetComponent(SoundBank).PlayRandom()
					self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 100
					hasAlreadyPlayedMusic = true
				else
					self.radioAudSrc.SetActive(false)
					self.radioAudSrc.gameObject.GetComponent(AudioSource).Stop()
					self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 0
					hasAlreadyPlayedMusic = false
				end
			end
	
			if self.radioAudSrc.gameObject.GetComponent(AudioSource).isPlaying == false then
				hasAlreadyPlayedMusic = false
			end
		end
	else
		self.radioAudSrc.SetActive(false)
		self.radioAudSrc.gameObject.GetComponent(AudioSource).Stop()
		self.radioAudSrc.gameObject.GetComponent(AudioSource).volume = 0

		hasAlreadyPlayedMusic = false
	end
end
