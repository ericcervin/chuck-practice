//rewrite of a ChucK MOOC assignment from 2013

TriOsc sin => Envelope env =>  dac; //signal chain

60 => int tempo;

(1::minute / tempo) => dur quarter; //set up duration for quarter note 
quarter / 4 => dur sixteenth; 
quarter / 2 => dur eighth;
sixteenth => dur noteLength;

[0,7,10,12] @=> int notePattern[];

43 => int rootPitch;
repeat(3){
  repeat(4){play_pattern(notePattern,noteLength,rootPitch);}
  repeat(2){play_pattern(notePattern,noteLength,rootPitch + 5);}
  repeat(2){play_pattern(notePattern,noteLength,rootPitch);}
  repeat(2){play_pattern(notePattern,noteLength,rootPitch + 7);}
  repeat(2){play_pattern(notePattern,noteLength,rootPitch);}
}


fun void play_pattern(int pattern[], dur length, int rootNote){
    for( 0 => int i; i < pattern.cap() ; i++ ){
       play_note(pattern[i] + rootNote,length);
        }
    }

fun void play_note(int midNote, dur length){
    length / 2 => dur halflength;
    Std.mtof(midNote) => sin.freq; //set frequency
    1 => env.target;
    halflength => env.duration; 
    1 => env.keyOn; //env on
    halflength => now;
    1 => env.keyOff; //env off;
    halflength => now;
    }