//chuck_practice_20201208
//sine.ck

//sound chain
SinOsc sin => Envelope env => JCRev jc => dac;

//create BPM & Counter objects
BPM tempo;
TheCount counter;

while(true){
        //two note pattern. i found that it sounded better the more simple it got
        play_note(48,tempo.eighthNote); //root of scale
        tempo.eighthNote => now;
        play_note(43,tempo.eighthNote);//fifth of the scale an octave below
        tempo.eighthNote => now;
        tempo.wholeNote => now;
}


fun void play_note(int midNote, dur length){
    Std.mtof(midNote) => sin.freq; //set frequency
    0.25 => env.target;
    length => env.duration; 
    1 => env.keyOn; //env on
    length => now;
    1 => env.keyOff; //env off;
    2*length => now;
    }

