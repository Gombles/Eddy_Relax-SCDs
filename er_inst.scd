~instruments =  {

	~outputs = {
		SynthDef(\mainOut, {
			arg in = ~out, out = 0;
			var sig;
			sig = In.ar(in, 2);
			Out.ar(out, sig);
		}).add;

	}.value;

	~mrimba_setup = {

		//MRIMBA SYNTH DEF
		SynthDef(\msaw, {
			arg att=2, sus=0, rel=3, c1=1, c2=(-1), freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, offset = 34;
			var sig, env;
			env = EnvGen.kr(Env([0,1,1,0],[att,sus,rel],[c1,0,c2]), doneAction:2);
			sig = Saw.ar(freq * {LFNoise1.kr(0.5, detune).midiratio}!2);
			sig = BPF.ar(sig,
				{LFNoise1.kr(
					LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
				).exprange(cfmin, cfmax)}!2,
				{LFNoise1.kr(0.1).exprange(rqmin, rqmax)}!2
			);
			sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
			sig = Balance2.ar(sig[0], sig[1], pan);
			sig = sig * env * amp;
			Out.ar(~out, sig);
		}).add;

		//MRIMBA PATTERN PARAMETERS
		Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Prand([0.5, 1, 2, 4], inf) * 1);
		Pdefn(\m_time, 5);
		Pdefn(\m_att, 3);
		Pdefn(\m_rel, 8);
		Pdefn(\m_amp, Prand([1, 1.1, 1.2], inf));
		Pdefn(\m_amp_scale, 2);
		Pdefn(\rqmin, 0.002);
		Pdefn(\rqmax, 0.005);

		//MRIMBA PATTERN
		Pdef(
			\mrimba,
			Pbind(
				\instrument, \msaw,
				\dur, Pdefn(\m_time) * Pdefn(\p_speed),
				\freq, Prand([1/2, 2/3, 1, 4/3, 2, 5/2, 3, 4, 6, 8], inf), // these are "timings" in cycles per second, fastest being 8 hz, slowest 0.5hz.
				\detune, 0, //this detunes the overall freq so will change timings
				\rqmin, Pdefn(\rqmin),//<< change these two + or - a few thousandths
				\rqmax, Pdefn(\rqmax), // << or more :) //.025 / .035 are percussive
				\cfmin, Pdefn(\m_notes),
				\cfmax, Pkey(\cfmin) * Pwhite(1.000, 1.015, inf), //this Pwhite multiply value gives a detune without affecting timing ("detunes" the filter)
				\att, Pdefn(\m_att),
				\sus, 1,
				\rel, Pdefn(\m_rel),
				\amp, Pdefn(\m_amp) * Pdefn(\m_amp_scale),
				\out, ~out,
				\group, ~mrimbas,
		));

	}.value;

	~chords1_setup = {

		//CHORDS1 SYNTH DEF
		SynthDef(\csaw1, {
			arg att=2, sus=0, rel=3, c1=1, c2=(-1), freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=50, cfmax=600, rqmin=0.1, rqmax=1, lsf=200, ldb=0, amp=1, offset = 34;
			var sig, env;
			env = EnvGen.kr(Env([0,1,1,0],[att,sus,rel],[c1,0,c2]), doneAction:2);
			sig = Saw.ar(freq * {LFNoise1.kr(0.5, detune).midiratio}!2);
			sig = BPF.ar(sig,
				{LFNoise1.kr(
					LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
				).exprange(cfmin, cfmax)}!2,
				{LFNoise1.kr(0.1).exprange(rqmin, rqmax)}!2
			);
			sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
			sig = Balance2.ar(sig[0], sig[1], pan);
			sig = sig * env * amp;
			Out.ar(~out, sig);
		}).add;

		//CHORDS1 PATTERN PARAMETERS
		Pdefn(\c_amp_scale, 0.3);
		Pdefn(\c_time, 8);
		Pdefn(\cfmin, 50);
		Pdefn(\cfmax, 600);

		//CHORDS1 PATTERN
		Pdef(
			\chords1,
			Pbind(
				\instrument, \csaw1,
				\dur, Pdefn(\c_time), // Play a chord every X seconds
				\midinote, Pxrand([
					[23, 35, 54, 63, 64], // Change chords here, notes using midi number
					[45, 52, 54, 59, 61, 64], //Each array is a chord chosen at random without repeats.
					[28, 40, 47, 56, 59, 63],
					[42, 52, 57, 61, 63],
				], inf),
				\detune, Pexprand(0.03, 0.08, inf),
				\cfmin, Pdefn(\cfmin), //Filter frequency ranges
				\cfmax, Pdefn(\cfmax), //
				\att, Pwhite(4, 4.5, inf),
				\rel, Pwhite(5, 7, inf),
				\ldb, 12, //Low shelf "strength" in dB
				\amp, 1 * Pdefn(\c_amp_scale),
				\out, ~out,
				\group, ~chords,
		));

	}.value;

	~chords2_setup = {

		//CHORDS2 + ARPS SYNTH DEF
		SynthDef(\csaw2, {
			arg att=0.2, sus=0, rel=0.5, c1=1, c2=(-1), freq=220, detune=0.2, pan=0, cfhzmin=0.3, cfhzmax=2, cfmin=100, cfmax=2500, rqmin=0.05, rqmax=0.08, lsf=400, ldb=3, amp=0.35, offset = 34;
			var sig, env /*freq = midinote.midicps*/;
			env = EnvGen.kr(Env([0,1,1,0],[att,sus,rel],[c1,0,c2]), doneAction:2);
			sig = SinOsc.ar(freq * {LFNoise1.kr(0.5, detune).midiratio}!2);
			sig = BPF.ar(sig,
				{LFNoise1.kr(
					LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
				).exprange(cfmin, cfmax)}!2,
				{LFNoise1.kr(0.1).exprange(rqmin, rqmax)}!2
			);
			sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
			sig = Limiter.ar(sig, 0.4, \ldur.kr(0.06));
			sig = Balance2.ar(sig[0], sig[1], pan);
			// FreeVerb2.ar(sig[0], sig[1], 1, 0.5, 0.5);
			sig = sig * env * amp;
			Out.ar(~out, sig);
		}).add;

		//CHORDS1 + ARP PARAMETERS
		Pdefn(\root, (~noteOffset-60));
		Pdefn(\c2_amp, 0.6);

		//CHORDS1 PATTERN
		Pdef(
			\chords2,
			Pbind(
				\instrument, \csaw2,
				// \dur, 1,
				\scale, Pdefn(\scale),
				\root, Pseq([Pdefn(\root)], inf), //0 = C
				\degree, Pseq([
					[-3, 0, 2, 4, 7]/*Maj*/,
					[-3, 0, 2s, 4, 7],
					[-3, 0, 5, 11, 14],
					// [0, 2b, 4],
				], inf),
				\att, 4,
				\rel, 4,
				\total, Pkey(\att) + Pkey(\rel),
				\dur, (Pkey(\att) + Pkey(\rel)),
				\l_dur, 0.01,
				\amp, Pdefn(\c2_amp),
			).collect({ |event|
				~c_event = event;
		}));

	}.value;

	~arps_setup = {

		//ARP PATTERN PARAMETERS
		Pdefn(\carp_dur, 2);

		//ARPS PATTERN
		Pdef(
			\carps,
			Pbind(
				\instrument, \csaw2,
				\scale, Pdefn(\scale),
				\root, Pseq([Pdefn(\root)+12], inf), //0 = C
				\c_notes, Pfunc{Pdefn(\notes, ~c_event[\degree])},
				\degree, Pdefn(\notes).composeBinaryOp(\wrapAt, Pseries(0, Prand([-3, -1, 0 , 1, 3], inf))),
				\playing, Pkey(\degree),
				\att, 0.2,
				\rel, 0.2,
				\dur, (Pkey(\att) + Pkey(\rel))/Pdefn(\carp_dur),
				\ldur, Pseq((3..8)/100, inf),
				\amp, Prand([0.4, 0.5, 0.7], inf),
		));

	}.value;


	~shaker_setup = {

		SynthDef(\shaker, {
			arg t_gate=1;
			var sig, env, mod, filt, amp = \amp.kr(0.2);
			sig = WhiteNoise.ar!2;
			env = Env([0,1,0],[\att.kr(3), \rel.kr(3)],[3,-3]).ar(0, t_gate);
			amp = amp * Saw.kr(LFNoise2.kr(0.3).range(5,20), 3);
			sig = BPF.ar(sig, LFNoise1.kr(0.1).range(\sfmin.kr(7500), \sfmax.kr(9500)), 0.05);
			sig = sig * amp * env;
			Splay.ar(sig, LFNoise1.kr(0.2).bipolar(1));
			Out.ar(~out, sig);

			SendReply.kr(Dust.kr(\s_chance.kr(0.1)), '/shaker_trig', 1, 0);
		}).add;

	}.value;

	~inst_globals = {
		~mrimba1 = Pdef(\mrimba);
		~chords1 = Pdef(\chords1);
		~chords2 = Pdef(\chords2);
		~carps = Pdef(\carps);
		~shaker = Synth(\shaker, target: ~shakers);
		o = Synth(\mainOut, [\in, ~out], ~outs);
	};

};

