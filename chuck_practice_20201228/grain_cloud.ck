//chuck_practice_20201228
//grain_cloud.ck

// tempo and counter objects
BPM tempo;
TheCount counter;
int sample_start; int sample_end; string sample_file; int grain_count;

ADSR masterEnv => LPF lp => dac;
5000 => lp.freq;
1.5 => lp.Q;


Math.random2(3,6) => int sample_choice;
if      (sample_choice == 0) {"tr-09-bd.wav" => sample_file; 0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 1) {"tr-09-sd.wav" =>sample_file; 0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 2) {"tr-09-lt.wav" =>sample_file; 0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 3) {"tr-09-ht.wav" =>sample_file; 0 => sample_start; 250=> sample_end;}
else if (sample_choice == 4) {"tr-09-clap.wav" =>sample_file;0 => sample_start; 250=> sample_end;}
else if (sample_choice == 5) {"tr-09-rim.wav" =>sample_file;0 => sample_start; 250=> sample_end;}
else if (sample_choice == 6) {"tr-09-ch.wav"=>sample_file;0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 7) {"tr-09-oh.wav" =>sample_file;0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 8) {"tr-09-crash.wav"=>sample_file;0 => sample_start; 250=> sample_end;} 
else if (sample_choice == 9) {"tr-09-ride.wav" =>sample_file;0 => sample_start; 250=> sample_end;} 

Math.random2(2,4) * 50 => int slice_size;
Math.random2(1,8) * 0.25 => float slice_rate;
if (counter.Measure <= 32)
    {counter.Measure => grain_count;}
    else
    {64 - counter.Measure => grain_count;}    


Event happening[grain_count];

for (0 => int i ; i < grain_count; i++){
    spork ~ slice(happening[i],sample_file, Math.random2(sample_start,sample_end), slice_size,slice_rate);
    }

spork ~ masterEnvelope();

repeat (grain_count){
    happening[Math.random2(0,grain_count - 1)].signal();   
    Math.random2(25,100)::ms => now; 
    }


fun void masterEnvelope(){
  masterEnv.set( tempo.quarterNote, 0::ms, 1.0, tempo.quarterNote );
  1 => masterEnv.keyOn;
  3 * tempo.quarterNote=>now;
  1 => masterEnv.keyOff;
  tempo.quarterNote=>now;   
}
    
fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void slice(Event anEvent, string file, int start, int len, float rate){
    SndBuf sound => Envelope env => masterEnv;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    
    2.0 => env.target;
    (len * 0.5)::ms => dur rise =>  dur fall;
    
    while( true )
    {
      anEvent => now;
   
      msToSamples(start) => sound.pos;
      rise => env.duration;
      1 => env.keyOn;
      rise=>now;
      1 => env.keyOff;
      fall=>now;
      sound.samples() => sound.pos;
    }
 }