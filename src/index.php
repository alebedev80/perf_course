<?php

//ini_set('error_log', dirname(__DIR__,2). '/logs/php.log');



$delay = (int)($_GET['delay'] ?? 0);

if ($delay) {
        echo "delay: {$delay}\n";
        usleep($delay);
}

$cpu = (float)($_GET['cpu'] ?? 0);

if ($cpu) {
	cpuLoad($cpu);
	echo "CPU: $cpu";
}


echo "Helllo!";        



function cpuLoad(float $loadDuration) 
{
        $startTime = microtime(true);

        // Loop and perform calculations to simulate CPU load
        while ((microtime(true) - $startTime) < $loadDuration) {
            // Perform some calculations (you can modify this part to increase or decrease load)
            $result = 0;
            for ($i = 0; $i < 10000; $i++) {
                $result += sqrt($i);
            }
        }
}  
