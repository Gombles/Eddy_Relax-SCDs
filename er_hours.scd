~time_funcs = {

	~timeline = [
		{\twentyfour.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 5);
			Pdefn(\m_amp_scale, 2);
			Pdefn(\rqmin, 0.002);
			Pdefn(\rqmax, 0.005);

		},

		{\one.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 72;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 3);
			//performance/events
			r = Routine {
				Pdefn(\m_time, 0.5);
				"burst".postln;
				6.3.wait;
				Pdefn(\m_time, 3);
				"end".postln;
			}.play;

		},

		{\two.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 41;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 2);

		},

		{\three.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 51;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 1);

		},
		{\four.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 58;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 2.5);

		},
		{\five.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 34;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 5);

		},
		{
			\six.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			r = Routine {
				Pdefn(\m_time, 0.5);
				1.wait;
				Pdefn(\m_time, 0.2);
				2.wait;
				Pdefn(\m_time, 1);
			}.play;
			Pdefn(\m_time, 2);

		},
		{\seven.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 70;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 5);

		},
		{\eight.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 58;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 3);

		},
		{\nine.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 54;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 1);

		},
		{\ten.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 38;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 4);

			~chords1.play;
			//chord parameters
			Pdefn(\c_amp_scale, 0.07);

		},
		{\eleven.postln;
			~mrimba1.stop;

			~chords1.play;
			Pdefn(\cfmin, Pxrand([100, 150, 75], inf));
			Pdefn(\cfmax, Pxrand([1200, 800, 600], inf));

		},
		{\twelve.postln;

			//chord freq range mod
			~chords1.play;
			Pdefn(\cfmin, Pxrand([50, 75, 100], inf));
			Pdefn(\cfmax, Pxrand([400, 600, 800], inf));

		},
		{\thirteen.postln;
			~mrimba1.play;
			~chords1.stop;
		},
		{\fourteen.postln;
			~mrimba1.play;
			//mrimba parameters
			~noteOffset = 34;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 3);
			Pdefn(\m_amp_scale, 0.35);
			Pdefn(\rqmin, 0.02);
			Pdefn(\rqmax, 0.05);
		},
		{\fifteen.postln;
			~mrimba1.play;
			~noteOffset = 39;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 2);
			Pdefn(\m_amp_scale, 0.25);
			Pdefn(\rqmin, 0.04);
			Pdefn(\rqmax, 0.07);

		},
		{\sixteen.postln;
			~mrimba1.play;
			~noteOffset = 51;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 2);
			Pdefn(\m_amp_scale, 0.15);
			Pdefn(\rqmin, 0.06);
			Pdefn(\rqmax, 0.09);

		},
		{\seventeen.postln;
			~mrimba1.play;
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Pdefn(\octs));
			Pdefn(\m_time, 1);
			Pdefn(\m_amp_scale, 0.08);
			Pdefn(\rqmin, 0.06);
			Pdefn(\rqmax, 0.1);
		},
		{\eighteen.postln;
			~mrimba1.play;
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\m_time, 4);
			Pdefn(\m_amp_scale, 0.3);
			Pdefn(\rqmin, 0.02);
			Pdefn(\rqmax, 0.05);
			~chords2.play;
		},
		{\nineteen.postln;
			~mrimba1.stop;
			~chords2.play;
			~noteOffset = 34;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\c2_amp, 1.5);

		},
		{\twenty.postln;
			~chords2.play;
			~carps.play;
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\carp_dur, 2);
			Pdefn(\c2_amp, 1);

		},
		{\twentyone.postln;
			~chords2.play;
			~carps.play;
			~noteOffset = 46;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			Pdefn(\carp_dur, 2);
			Pdefn(\c2_amp, 0.8);

		},
		{\twentytwo.postln;
			~chords2.play;
			~carps.play;
			~noteOffset = 34;
			Pdefn(\root, ~noteOffset - 60);
			~m2n.value(~noteOffset).postln;
			r = Routine {
				Pdefn(\carp_dur, 4);
				(~day_length/48).wait;
				Pdefn(\carp_dur, 2);
				(~day_length/96).wait;
				Pdefn(\carp_dur, 1);
			}.play;
			Pdefn(\c2_amp, 1.2);
		},
		{\twentythree.postln;
			~chords2.stop;
			~carps.stop;

		}
	];

	~timeline_wipe = { ~timeline = [] };
};

// ~timeline[21].value;