//rewrite of a ChucK MOOC assignment from 2013

//signal chain
Gain master => Pan2 panda => dac;
SinOsc s => Envelope env =>  master;
SndBuf kck => master;
Shakers shak => master;

me.dir() + "/audio/kick_02.wav" => kck.read;//load kick sample
0.5 => kck.gain;//set kick gain

0.33 => shak.gain;//set shaker gain
6 => shak.preset;//set shaker preset

//for 40 beat (each .75 second beat)
for (1 => int beat; beat <= 40; beat++)
{    //piece divided into 5 sections with different densities of notes
     //beatIt function receives the number of notes to play in the beat
     //and the beat number. Use an even noteCount if over 1!
    0 => int noteCount;
    if      ((beat <= 8)||(beat >= 33)) {1=>noteCount;} // sections 1&5
    else if ((beat >= 17)&&(beat <= 24)){4=>noteCount;} // section 3
    else                                {2=>noteCount;} // sections 2&4
    beatIt(noteCount,beat);
    <<<beat>>>;
    
}//for each of 40 .75 second beats

fun void beatIt(int noteCount, int beat)
{   //each beat contains a number of notes all wrapped in an attack/sustain/release envelope
    randomWidePan() => panda.pan; //pan to one random extreme left or right using function   
    0 => kck.pos; //set kick sample to start
    1 => shak.noteOn;
    750/noteCount => int msWait; //calculate # of ms between freq changes
    375::ms => dur halflength;// length of env rise/fall
    //<<<msWait>>>;
    0.75 => env.target;
    halflength => env.duration; 
    if (noteCount == 1){
        1 => env.keyOn; //env on
        randomPhyrganFreq() => s.freq; 
        halflength => now;
        1 => shak.noteOn;       
        1 => env.keyOff; //env off;
        halflength => now;
        } 
      else {
        1 => env.keyOn; //env on
        repeat(noteCount / 2){randomPhyrganFreq() => s.freq; msWait::ms => now;}
        1 => shak.noteOn;
        1 => env.keyOff; //env off;
        repeat(noteCount / 2){randomPhyrganFreq() => s.freq; msWait::ms => now;}
        }
    
}

fun float randomPhyrganFreq()
{   
    [49, 50, 52, 54, 56, 57, 59, 61] @=> int PhyrganScale[]; //set scale
    PhyrganScale[Math.random2(0,7)] => int scaleTone; //select random scale tone
    scaleTone + (Math.random2(0,2) * 12) => int midNote; //place randomly in 
                                                         //one of three octaves
    return Std.mtof(midNote); //return frequency
}

fun float randomWidePan (){
    [-1.0,-0.9,-0.8, 0.8, 0.9, 1.0] @=> float panPos[]; //array of positions
    return panPos[Math.random2(0,5)]; // select random position
    }