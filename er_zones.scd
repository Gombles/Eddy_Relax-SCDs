~area_funcs = {

	~zone_reset = {
		~mrimba1.stop;
		~chords1.stop;
		~chords2.stop;
		~carps.stop;
		OSCdef(\shaker_trig).disable;
		\zoneReset.postln;
	};

	~zones = Dictionary.new;
	//0
	~zones.put(	\waterfall, {
		~s_index = 4; //major
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\high_octs));
		Pdefn(\octs, Pdefn(\high_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).disable;
		\waterfall.postln;
	});
	//1
	~zones.put(	\forest, {
		~s_index = 0; //mixolydian
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\mid_octs));
		Pdefn(\octs, Pdefn(\mid_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).enable;
		\forest.postln;
	});
	//2
	~zones.put(	\center, {
		~s_index = 1; //melodicMinor
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\mid_octs));
		Pdefn(\octs, Pdefn(\mid_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).disable;
		\center.postln;
	});
	//3
	~zones.put(	\pine, {
		~s_index = 2; //phrygian
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\low_octs));
		Pdefn(\octs, Pdefn(\low_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).enable;
		\pine.postln;
	});
	//4
	~zones.put(	\rockland, {
		~s_index = 3; //dorian
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\low_octs));
		Pdefn(\octs, Pdefn(\low_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).enable;
		\rockland.postln;
	});
	//5
	~zones.put(	\outflow, {
		~s_index = 5; //lydian
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\high_octs));
		Pdefn(\octs, Pdefn(\high_octs));
		Pdefn(\scale, ~scales[~s_index]);
		OSCdef(\shaker_trig).disable;
		\outflow.postln;
	});

};