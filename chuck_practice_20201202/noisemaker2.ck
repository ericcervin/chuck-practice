//chuck_practice_20201202
//noisemaker2.ck

[69,71,73,76,78,81,83,85,88,90,93] @=> int penMelody[]; //2 octaves of A pentatonic Scale

//create tempo and counter objects
BPM tempo;
TheCount counter;

int offset;//declare global variable

//Ugen and number of grains is selected. frequency is random.

//array for selecting the timbre in each burst of grains
//[Ugen,grains/burst]
//1=Sine,2=Tri,3=Sqr,4=Phs,5=Saw
[
//[1,10],[1,100],[1,1000],[1,100], \\ too tame so commented out
//[2,10],[2,100],[2,1000],[2,100], \\ too tame so commented out
[3,5],[3,50],[3,500],[3,50],
[4,5],[4,50],[4,500],[4,50],
[5,5],[5,50],[5,500],[5,50]
] @=> int pattern[][];

while (true){
    for (0 => int i; i < pattern.cap(); i++)
    {
        //Piece has 5 sections spread split between low and high register L/H/L/H/L
        if ((counter.Measure < 7)||(counter.Measure > 24)){-36 => offset;} //low register
        else if ((counter.Measure >= 13 )&&(counter.Measure <= 18)) {-36 => offset;} //low register
        else {24 => offset;}//high register
        
        spork ~ makeGrains(pattern[i][0],pattern[i][1],Std.mtof(randomApent() + offset)); //create grainburst at random freq
        tempo.eighthNote => now;
        
        
    }
}

fun void makeGrains(int UGenChoice, int grainCount, float freak){
    //UGenChoice: the oscillator UGen that will produce the sound
    //grainCount: number of grains that will be in the burst
    //freak: frequency for the oscillator UGen    
    Granulator2 grn;//create granulator object
    grn.intake(UGenChoice,grainCount,freak,tempo.eighthNote); //start it granulating. all bursts are 1/8 notes
    }
    
 fun int randomApent(){
    penMelody[Math.random2(0,10)] => int midiNote; //select random notes from my A pentatonic scale
    return midiNote;
    }