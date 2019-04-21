# Shell snippet.

bugout() { echo "${MYNAME}: Programming error" >&2 ; exit 123 ; }

echo_card_indices()
{
	if [ -f /proc/asound/cards ] ; then
		sed -n -e's/^[[:space:]]*\([0-7]\)[[:space:]].*/\1/p' /proc/asound/cards
	fi
}

filter_amixer_output()
{
	sed \
		-e '/Unable to find simple control/d' \
		-e '/Unknown playback setup/d' \
		-e '/^$/d'
}

# The following functions try to set many controls.
# No card has all the controls and so some of the attempts are bound to fail.
# Because of this, the functions can't return useful status values.

# $1 <control>
# $2 <level>
# $CARDOPT
unmute_and_set_level()
{
	{ [ "$2" ] && [ "$CARDOPT" ] ; } || bugout
	amixer $CARDOPT -q set "$1" "$2" unmute 2>&1 | filter_amixer_output || :
	return 0
}

# $1 <control>
# $CARDOPT
mute_and_zero_level()
{
	{ [ "$1" ] && [ "$CARDOPT" ] ; } || bugout
	amixer $CARDOPT -q set "$1" "0%" mute 2>&1 | filter_amixer_output || :
	return 0
}

# $1 <control>
# $2 "on" | "off"
# $CARDOPT
switch_control()
{
	{ [ "$2" ] && [ "$CARDOPT" ] ; } || bugout
	amixer $CARDOPT -q set "$1" "$2" 2>&1 | filter_amixer_output || :
	return 0
}

# $1 <card ID>
sanify_levels_on_card()
{
	CARDOPT="-c $1"

	unmute_and_set_level "Master" "80%"
	unmute_and_set_level "Master Mono" "80%"   # See Bug#406047
	unmute_and_set_level "Master Digital" "80%"   # E.g., cs4237B
	unmute_and_set_level "Playback" "80%"
	unmute_and_set_level "Headphone" "70%"
	unmute_and_set_level "PCM" "80%"
	unmute_and_set_level "PCM,1" "80%"   # E.g., ess1969
	unmute_and_set_level "DAC" "80%"     # E.g., envy24, cs46xx
	unmute_and_set_level "DAC,0" "80%"   # E.g., envy24
	unmute_and_set_level "DAC,1" "80%"   # E.g., envy24
	unmute_and_set_level "Synth" "80%"
	unmute_and_set_level "CD" "80%"

	mute_and_zero_level "Mic"
	mute_and_zero_level "IEC958"         # Ubuntu #19648

	# Intel P4P800-MX  (Ubuntu bug #5813)
	switch_control "Master Playback Switch" on
	switch_control "Master Surround" on

	# Trident/YMFPCI/emu10k1:
	unmute_and_set_level "Wave" "80%"
	unmute_and_set_level "Music" "80%"
	unmute_and_set_level "AC97" "80%"

	# DRC:
	unmute_and_set_level "Dynamic Range Compression" "80%"

	# Required for HDA Intel (hda-intel):
	unmute_and_set_level "Front" "80%"
	unmute_and_set_level "Master Front" "80%"

	# Required for SB Live 7.1/24-bit (ca0106):
	unmute_and_set_level "Analog Front" "80%"

	# Required at least for Via 823x hardware on DFI K8M800-MLVF Motherboard with kernels 2.6.10-3/4 (see ubuntu #7286):
	switch_control "IEC958 Capture Monitor" off

	# Required for hardware allowing toggles for AC97 through IEC958,
	#  valid values are 0, 1, 2, 3. Needs to be set to 0 for PCM1.
	unmute_and_set_level "IEC958 Playback AC97-SPSA" "0"

	# Required for newer Via hardware (see Ubuntu #31784)
	unmute_and_set_level "VIA DXS,0" "80%"
	unmute_and_set_level "VIA DXS,1" "80%"
	unmute_and_set_level "VIA DXS,2" "80%"
	unmute_and_set_level "VIA DXS,3" "80%"

	# Required on some notebooks with ICH4:
	switch_control "Headphone Jack Sense" off
	switch_control "Line Jack Sense" off

	# Some machines need one or more of these to be on;
	# others need one or more of these to be off:
	#
	# switch_control "External Amplifier" on
	# switch_control "Audigy Analog/Digital Output Jack" on
	# switch_control "SB Live Analog/Digital Output Jack" on
	
	# D1984 -- Thinkpad T61/X61
	switch_control "Speaker" on
	switch_control "Headphone" on

	# HDA-Intel w/ "Digital" capture mixer (See Ubuntu #193823)
	unmute_and_set_level "Digital" "80%"

	# On MacBookPro5,3 and later models (See Bug#597791)
	unmute_and_set_level "Front Speaker" "80%"
	# On MacBook5,2 models (See Bug#602973)
	unmute_and_set_level "LFE" "80%"

	# On Intel 82801H (See Bug#603550)
	unmute_and_set_level "Speaker" "80%"

	return 0
}

# $1 <card ID> | "all"
sanify_levels()
{
	TTSDML_RETURNSTATUS=0
	case "$1" in
	  all)
		for CARD in $(echo_card_indices) ; do
			sanify_levels_on_card "$CARD" || TTSDML_RETURNSTATUS=1
		done
		;;
	  *)
		sanify_levels_on_card "$1" || TTSDML_RETURNSTATUS=1
		;;
	esac
	return $TTSDML_RETURNSTATUS
}

# $1 <card ID>
preinit_levels_on_card()
{
	CARDOPT="-c $1"

	# Silly dance to activate internal speakers by default on PowerMac
	# Snapper and Tumbler
	id=$(cat /proc/asound/card$1/id 2>/dev/null)
	if [ "$id" = "Snapper" -o "$id" = "Tumbler" ]; then
		switch_control "Auto Mute" off
		switch_control "PC Speaker" off
		switch_control "Auto Mute" on
	fi
}

# $1 <card ID> | "all"
preinit_levels()
{
	TTSDML_RETURNSTATUS=0
	case "$1" in
	  all)
		for CARD in $(echo_card_indices) ; do
			preinit_levels_on_card "$CARD" || TTSDML_RETURNSTATUS=1
		done
		;;
	  *)
		preinit_levels_on_card "$1" || TTSDML_RETURNSTATUS=1
		;;
	esac
	return $TTSDML_RETURNSTATUS
}
