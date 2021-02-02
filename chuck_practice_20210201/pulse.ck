//chuck_practice_20210201
//pulse.ck

//sound chain
PulseOsc pls => Envelope env => JCRev jc => LPF lp => dac;

//create BPM & Counter objects
BPM tempo;
TheCount counter;

Std.mtof(60) => lp.freq;

while(true){
    play_note(36,tempo.quarterNote);
    1*tempo.quarterNote => now;    
}


fun void play_note(int midNote, dur length){
    Std.mtof(midNote) => pls.freq; //set frequency
    0.25 => env.target;
    length => env.duration; 
    1 => env.keyOn; //env on
    length => now;
    1 => env.keyOff; //env off;
    2*length => now;
    }