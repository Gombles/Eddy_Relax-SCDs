~ue_osc = {

	OSCdef(
		\startup,
		{arg msg;

			r = Routine{
				CmdPeriod.run;
				s.sync;
				1.wait;
				"Game started!!!".postln;
				o = Synth(\mainOut, [\in, ~out], ~outs);
				~shaker = Synth(\shaker, target: ~shakers);
			}.play;
		},
		'/1/startup', recvPort: ~recv_port
	);

	OSCdef(
		\end,
		{arg msg;
			"Game over!".postln;
			CmdPeriod.run;
		},
		'/1/end', recvPort: ~recv_port
	);

	OSCdef(
		\distance,
		{arg msg;

			Pdefn(\m_amp_scale, msg[1]);
		},
		'/1/distance', recvPort: ~recv_port
	);

	OSCdef(
		\day_times,
		{arg msg;
			d = ControlSpec(0, 24, \lin, 1);
			~play_rate = msg[1];
			~day_length = msg[2];
			~play_position = msg[3];

			~hour = d.map(~play_position).asInteger;

			~osc_reply.sendMsg('/1/time_of_day', ~hour);

			~timeline[~hour].value;
		},
		'/1/day_times', recvPort: ~recv_port
	);

	OSCdef(
		\zones,
		{arg msg;

			z = msg[1];
			switch(z)
			{0} {~zones[\waterfall].value; }
			{1} {~zones[\forest].value}
			{2} {~zones[\center].value}
			{3} {~zones[\pine].value}
			{4} {~zones[\rockland].value}
			{5} {~zones[\outflow].value};
		},
		'/1/zone_name', recvPort: ~recv_port
	);

	OSCdef(
		\zone_reset,
		{arg msg;
			~nz = true;
			~zone_reset.value;
		},
		'/1/zone_reset', recvPort: ~recv_port
	);

	OSCdef(
		\secret_zone,
		{arg msg;
			z = msg[1];
			switch(z)
			{0} {
				~timeline_wipe.value;
				~mrimba1.stop;
				~chords1.stop;
				~chords2.stop;
				~carps.stop;
				\secretsss.postln
			}
			{1} { ~time_funcs.value; ~timeline[~hour].value; };
		},
		'/1/secret_zone', recvPort: ~recv_port
	);

	OSCdef(
		\day_end,
		{
			"Day over".postln;
		},
		'/1/day_end', recvPort: ~recv_port
	);

	OSCdef(
		\player_info,
		{arg msg;

			~player_speed = LinLin.ar(msg[1], 0, 600, ~m_max, ~m_min);

			~player_speed = ~player_speed.round(0.01);

			Pdefn(\p_speed, ~player_speed);
		},
		'/1/player_speed', recvPort: ~recv_port
	);

	OSCdef(\shaker_trig,
		{arg msg;
			if ( msg[3] == 1, {~shaker.set(\t_gate, 1); } );
	}, '/shaker_trig');

	OSCdef(\shaker_trig).disable;

	OSCdef(
		\mrimbas,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~mrimba1.play;
					"Mrimbas playing!".postln;
					~osc_reply.sendMsg('/1/mrimbas_playing', 1);
				},
				{
					~mrimba1.stop.fadeTime(3);
					"Mrimbas stopped!".postln;
					~osc_reply.sendMsg('/1/mrimbas_playing', 0);
				}
			);
		},
		'/1/mrimbas', recvPort: ~recv_port
	);

	OSCdef(
		\chords,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~chords1.play;
					"Chords playing!".postln;
					~osc_reply.sendMsg('/1/chords_playing', 1);
				},
				{
					~chords1.stop.fadeTime(3);
					"Chords stopped!".postln;
					~osc_reply.sendMsg('/1/chords_playing', 0);
				}
			);
		},
		'/1/chords', recvPort: ~recv_port
	);

	OSCdef(
		\chords2,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~chords2.play;
					"Chords2 playing!".postln;
					~osc_reply.sendMsg('/1/chords2_playing', 1);
				},
				{
					~chords2.stop.fadeTime(3);
					"Chords stopped!".postln;
					~osc_reply.sendMsg('/1/chords2_playing', 0);
				}
			);
		},
		'/1/chords2', recvPort: ~recv_port
	);

	OSCdef(
		\carps,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~carps.play;
					"Carps playing!".postln;
					~osc_reply.sendMsg('/1/chords2_playing', 1);
				},
				{
					~carps.stop.fadeTime(3);
					"Carps stopped!".postln;
					~osc_reply.sendMsg('/1/chords2_playing', 0);
				}
			);
		},
		'/1/carps', recvPort: ~recv_port
	);

	OSCdef(
		\shaker,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~shaker.set(\t_gate, 1);
					OSCdef(\shaker_trig).enable;
					"Shakers!".postln;
				},
				{

					OSCdef(\shaker_trig).disable;
					"Shhh.".postln;
				}
			);
		},
		'/1/shaker', recvPort: ~recv_port
	);

	OSCdef.new(
		\notes,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~noteOffset = Array.series(5, 23, 12).choose;
					Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Prand([0.5, 1, 2, 4], inf));
					Pdefn(\root, (~noteOffset-60));
					~note_name = ~m2n.value(~noteOffset);
					~note_name.postln;
					~osc_reply.sendMsg('/1/new_note', ~note_name);
				},
			);
		},
		'/1/notes', recvPort: ~recv_port
	);

	OSCdef.new(
		\scale,
		{arg msg;
			if(
				msg[1] == 1,
				{
					~s_index = (0..4).choose;
					Pdefn(\m_notes, Prand((~scales[~s_index]+~noteOffset).midicps, inf) * Prand([0.5, 1, 2, 4], inf));
					~s_names[~s_index].postln;
					~osc_reply.sendMsg('/1/new_scale', ~s_names[~s_index]);
				},

			);
		},
		'/1/scale', recvPort: ~recv_port
	);


};