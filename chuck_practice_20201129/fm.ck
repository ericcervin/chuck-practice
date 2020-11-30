//chuck_practice_20201129
//fm.ck

//sound chain
SinOsc mod => SinOsc car => JCRev jc => Pan2 panda => dac;

2 => car.sync; // FM mode
0.125 => car.gain; //set carrier gain
randomPower10() => mod.gain; //set modifier gain with random number from function

0.3 => jc.mix; // reverb trying to dampen the high end

randomWidePan() => panda.pan; //pan to one random extreme left or right using function

repeat(8){ //play 8 rapid notes
    randomAeolianFreq() => car.freq; //set carrier frequency with random Aeolian function
    randomAeolianFreq() => mod.freq; //set modifier frequency with random Aeolian function
    0.15::second => now; //1.2 seconds total. ~2 quarter notes. noises overlap.
}
fun float randomAeolianFreq()
{   
    [46, 48, 49, 51, 53, 54, 56, 58] @=> int AeolianScale[]; //set scale
    AeolianScale[Math.random2(0,7)] => int midNote;//select random midi note from scale
    return Std.mtof(midNote); //return frequency
}
fun int randomPower10(){
    //all because I don't remember exponents being in the lectures
    [10,100,1000,10000] @=> int gainChoices[]; //array of powers of ten
    return gainChoices[Math.random2(0,3)];//select random power
    }
    
fun float randomWidePan (){
    [-1.0,-0.9,-0.8, 0.8, 0.9, 1.0] @=> float panPos[]; //array of positions
    return panPos[Math.random2(0,5)]; // select random position
    }