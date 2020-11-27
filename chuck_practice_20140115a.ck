"Sample2.wav" => string fileName;
SndBuf biff[16];

play_aud_series();
40::second => now;

fun void play_aud_series(){
    spork~ play_aud(1, fileName, 0);
    for (1 => int i; i < 16; i++){
        (1/(2*(Math.pow(2,i)))) => float delay;
        (1/(Math.pow(2,i-1))) => float gain;
        //<<<delay,gain>>>;
        delay::second => now;
        spork~ play_aud(gain, fileName, i);
    } 
}


fun void play_aud(float buffGain, string fileName, int buffNum){
    biff[buffNum] => dac;
    buffGain =>  biff[buffNum].gain;
    me.dir() + "/audio/" +  fileName =>  biff[buffNum].read;
    1 => biff[buffNum].loop;
    40::second => now;
    }