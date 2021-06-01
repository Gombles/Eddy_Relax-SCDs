(
///// LOAD EXTERNAL FILES
~path = PathName(thisProcess.nowExecutingPath).parentPath; //++"subFolder/"

~funcs = ~path ++ "er_funcs.scd";
~ue = ~path ++ "er_ueosc.scd";
~score  = ~path ++ "er_hours.scd";
~location = ~path ++ "er_zones.scd";
~insts = ~path ++ "er_inst.scd";

~funcs.load;
~insts.load;
~ue.load;
~score.load;
~location.load;

"Locked...".postln;

/// SERVER OPTIONS
s = Server.local;
NetAddr.localAddr;
s.options.verbosity_(-1);
s.options.numInputBusChannels_(4);
s.options.numOutputBusChannels_(2);
// s.options.inDevice_("ASIO : MOTU M Series");
// s.options.outDevice_("ASIO : MOTU M Series");
// s.options.inDevice_("ASIO : Voicemeeter VAIO3 Virtual ASIO");
// s.options.outDevice_("ASIO : Voicemeeter VAIO3 Virtual ASIO");
s.options.sampleRate_(48000);
s.options.memSize_(2.pow(20));
s.newBusAllocators;

ServerBoot.removeAll;
ServerTree.removeAll;
ServerQuit.removeAll;
Window.closeAll;

~declarations.value;

ServerBoot.add(~make_busses);
ServerQuit.add(~cleanup);

///// BOOT SERVER + SETUP
s.waitForBoot({

	//FUNCS ADDED TO SERVER TREE FOR AUTOMATED SETUP ON START/REBOOT
	ServerTree.add(~make_nodes);
	ServerTree.add(~make_scales);
	ServerTree.add(~instruments);
	// ServerTree.add(~pattern_defs);
	// ServerTree.add(~synth_defs);
	ServerTree.add(~ue_osc);
	ServerTree.add(~conversions);
	ServerTree.add(~time_funcs);
	ServerTree.add(~area_funcs);

	s.freeAll;
	s.sync;

	2.wait;
	~inst_globals.value;
	~osc_reply.sendMsg('/1/server_start', "Server Loaded!");
	"Loaded!".postln;

	t = Routine { loop {
	for (0, 23, {arg i; ~timeline[i].value; ~day_length/24.wait })
	} }.play;
});
)