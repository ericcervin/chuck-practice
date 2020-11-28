//rewrite of a ChucK MOOC assignment from 2013

//signal chain
Gain master => Pan2 panda => dac;
SinOsc s => Envelope env =>  master;
SndBuf kck => master;

me.dir() + "/audio/kick_02.wav" => kck.read;//load kick sample
0.5 => kck.gain;//set kick gain

//for 50 beats (each .6 second beat)
for (1 => int beat; beat <= 50; beat++)
{    //piece divided into 5 sections with different densities of notes
     //beatIt function receives the number of notes to play in the beat
    if      ((beat <= 10)||(beat >= 41)){beatIt(2);} // sections 1&5
    else if ((beat >= 21)&&(beat <= 30)){beatIt(8);} // section 3
    else                                {beatIt(4);} // sections 2&4
    <<<beat>>>;
    
}//for each of 50 .6 second beats

fun void beatIt(int noteCount)
{   //each beat contains a number of notes all wrapped in an attack/sustain/release envelope
    randomWidePan() => panda.pan; //pan to one random extreme left or right using function   
    0 => kck.pos; //set kick sample to start
    
    600/noteCount => int msWait; //calculate # of ms between freq changes
    300::ms => dur halflength;// length of env rise/fall
    
    0.75 => env.target;
    halflength => env.duration; 
    repeat(noteCount / 2){randomEbMixFreq() => s.freq; msWait::ms => now;}
    1 => env.keyOn; //env on
    1 => env.keyOff; //env off;
    repeat(noteCount / 2){randomEbMixFreq() => s.freq; msWait::ms => now;}
}

fun float randomEbMixFreq()
{   
    [51, 53, 55, 56, 58, 60, 61, 63] @=> int EbMix[]; //set scale
    EbMix[Math.random2(0,7)] => int scaleTone; //select random scale tone
    scaleTone + (Math.random2(0,2) * 12) => int midNote; //place randomly in 
                                                         //one of three octaves
    return Std.mtof(midNote); //return frequency
}

fun float randomWidePan (){
    [-1.0,-0.9,-0.8, 0.8, 0.9, 1.0] @=> float panPos[]; //array of positions
    return panPos[Math.random2(0,5)]; // select random position
    }