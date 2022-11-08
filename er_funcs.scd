////////////////////UTILITIES
~declarations = {
	//global variables
	d = ControlSpec(0, 24, \lin, 1);
	~osc_reply = NetAddr.new("127.0.0.2", 12345);
	~m_max = 1;
	~m_min = 0.5;
	~noteOffset = 48;
	~day_length = 360;
	~hour = 0;
	~recv_port = 23456;
};

~make_busses = {
	~reverb = Bus.audio(s, 2);
	~filter = Bus.audio(s, 2);
	~out = Bus.audio(s, 2);

};

~make_nodes = {
	s.bind({
		~mrimbas = Group.new;
		~chords = Group.new;
		~shakers = Group.new;
		~outs = Group.after(~mrimbas)
	});
};

~make_scales = {

	~mixolydian = Scale.mixolydian.degrees;
	~melodicMinor = Scale.melodicMinor.degrees;
	~phrygian = Scale.phrygian.degrees;
	~dorian = Scale.dorian.degrees;
	~major = Scale.major.degrees;
	~lydian = Scale.lydian.degrees;

	~scales = [ ~mixolydian, ~melodicMinor, ~phrygian, ~dorian, ~major, ~lydian ];
	~s_names = ["mixolydian", "melodic minor", "phrygian", "dorian", "major", "lydian"];

	~s_index = 2;

	Pdefn(\scale, ~scales[~s_index]);
};

~cleanup = {
	~osc_reply.sendMsg('/1/server_stop', "Server has stopped!");
	s.newBusAllocators;
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
	OSCdef.freeAll;
	MIDIdef.freeAll;
	Window.closeAll;

};

~conversions = {

	~notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
	~m2n = {
		|midinote|
		o = ((midinote / 12) - 1).asInteger;
		d = (midinote % 12);
		n = ~notes[d] + o;
		n.asString;
	};

	~m2n.value(60);
};