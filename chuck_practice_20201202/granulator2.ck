//chuck_practice_20201202
//granulator2.ck

public class Granulator2{
Envelope env1;//envelope for individual grain
Envelope env2;//envelope for group of grains    

fun void intake(int UGenChoice, int grainNum, float freak, dur BurstLength){
    //UGenChoice: the oscillator UGen that will produce the sound
    //grainNum: number of grains that will be in the burst
    //freak: frequency for the oscillator UGen    
    //BurstLength: duration of the entire grain burst
    if (UGenChoice == 1){SinOsc os => env1 => env2 => dac;}
    else if (UGenChoice == 2){TriOsc os => env1 => env2 => dac;0.3 => os.gain;freak=>os.freq;}
    else if (UGenChoice == 3){SqrOsc os => env1 => env2 => dac;0.3 => os.gain;freak=>os.freq;}
    else if (UGenChoice == 4){Phasor os => env1 => env2 => dac;0.3 => os.gain;freak=>os.freq;}
    else if (UGenChoice == 5){SawOsc os => env1 => env2 => dac;0.3 => os.gain;freak=>os.freq;} 
    playBurst(grainNum,BurstLength); 
}  
    
fun void play_grain(dur length){
    //length: length of grain
    0.75 => env1.target; //max gain
    length/2 => dur halfLife; //length of attack and decay
    halfLife => env1.duration; //length of attack
    1 => env1.keyOn; //env on
    halfLife => now;//attack
    1 => env1.keyOff; //env off;
    halfLife => now;//decay
    }

    
fun void playBurst(int grainCount, dur BurstLength){
    //grainCount: number of grains during burst
    //BurstLength: length of the entire burst
    0.75 => env2.target; //max gain
    grainCount/2 => int halfGrainCount; //# of grains that will occur in each half
    BurstLength/grainCount => dur grainLength; //length of each individual grain
    BurstLength/2 => env2.duration;//length of attack
    1 => env2.keyOn; //env on
    repeat (halfGrainCount){play_grain(grainLength);} //attack
    1 => env2.keyOff; //env off
    repeat (halfGrainCount){play_grain(grainLength);} //decay
    }
}