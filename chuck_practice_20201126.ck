//rewrite of a ChucK MOOC assignment from 2013

//Sound Chain
Gain master => dac;
SndBuf kick2 => master;
SndBuf hihat => master;
SndBuf clap => master;
TriOsc tri => Envelope env => master;

//set master gain
.6 => master.gain;

//set step length
140 => int tempo;
(1::minute / tempo) => dur quarter; //set up duration for quarter note 
quarter / 4 => dur sixteenth;
sixteenth => dur steplen;

//read files  into SndBufs
me.dir() + "/audio/kick_02.wav" => kick2.read;
me.dir() + "/audio/hihat_01.wav" => hihat.read;
me.dir() + "/audio/clap_01.wav" => clap.read;

//set all playheads to end so no sound is made
kick2.samples() => kick2.pos;
hihat.samples() => hihat.pos;
clap.samples() => clap.pos;

//initialize counter variable
0 => int counter;
//initialize section variable
0 => int section;

// sets hihat rate for 32 steps in pattern. silent, forward, and reverse
    [0,0,0,0,1,1,1,1,0,2,1,2,1,2,0,0,1,1,1,0,1,1,1,1,0,-2,-1,-2,-1,-2,0,0] @=> int hatRate[];

while (section <= 8) //piece has 8 sections

{
    //steps go from 0 - 31 (32 steps)
    counter % 32 => int step;
 
    //tone every 8th step
    if ((step % 8) == 0)
    {
        spork ~ play_note(22, 4 * steplen);
    }
    
    //bass drum every 4th step
    if ((counter % 4) == 0)
    {
        0 => kick2.pos;
    }
    
    //hihat on every step. sometimes silent when rate is 0
    if (hatRate[step] > 0) { //positive rate. forward hihat
        0 => hihat.pos;
        }
        else { //0 or negative rate. hihat silent or reversed
        hihat.samples() => hihat.pos;
        }
    .2 => hihat.gain; // hihat on, even if silent (rate 0)
    hatRate[step] => hihat.rate; //set hihat rate
    
    //clap every 3rd step for first half of pattern
    if ((step <= 15)&&((counter % 3) == 0))
    {
        0 => clap.pos;
    }
    
    counter++;// increment counter
    steplen => now; //advance step one beat
    
    if (step == 31){ // at end of 32 steps, increment section
        section++;
        } 
}

2::second => now;

fun void play_note(int midNote, dur length){
    length / 2 => dur halflength;
    Std.mtof(midNote) => tri.freq; //set frequency
    1 => env.target;
    halflength => env.duration; 
    1 => env.keyOn; //env on
    halflength => now;
    1 => env.keyOff; //env off;
    halflength => now;
    }