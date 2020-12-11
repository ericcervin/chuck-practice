//chuck_practice_20201210
//pulse.ck

//sound chain
PulseOsc pls => Envelope env => JCRev jc => LPF lp => dac;

//create BPM & Counter objects
BPM tempo;
TheCount counter;

Std.mtof(60) => lp.freq;

while(true){
        play_note(randomMidi(),tempo.eighthNote);
        tempo.eighthNote => now;
        play_note(randomMidi(),tempo.eighthNote);
        tempo.eighthNote => now;
        tempo.wholeNote => now;
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

fun int randomMidi()
{   
    [43,48] @=> int Scale[]; //set scale
    Scale[Math.random2(0,1)] => int midNote;//select random midi note from scale
    <<<midNote>>>;
    return midNote;
}