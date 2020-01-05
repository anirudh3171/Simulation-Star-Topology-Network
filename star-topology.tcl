set ns [new Simulator  -multicast on]

$ns macType Kac/Sat/SlottedAloha

set nf [open out.nam w]
$ns namtrace-all $nf
set nf [open out.tr w]
$ns trace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam
exit 0
}


$ns color 0 Red
$ns color 1 Blue
$ns color 2 Black	
$ns color 3 Green
$ns color 4 Brown
$ns color 5 purple


set n0 [$ns node] 
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]

$n0 label "Router 1"
$n1 label "Client 1"
$n2 label "Client 2"
$n3 label "Client 3"
$n4 label "Client 4"
$n5 label "Router 2"
$n6 label "Client 5"
$n7 label "Client 6"
$n8 label "Client 7"
$n9 label "Client 8"
$n10 label "Client 9"

$ns duplex-link $n1 $n0 500Kb 50ms DropTail
$ns duplex-link $n2 $n0 500Kb 50ms DropTail
$ns duplex-link $n3 $n0 500Kb 50ms DropTail
$ns duplex-link $n4 $n0 500Kb 50ms DropTail
$ns duplex-link $n5 $n0 500Kb 500ms DropTail
$ns duplex-link $n6 $n5 500Kb 100ms DropTail
$ns duplex-link $n7 $n5 500Kb 100ms DropTail
$ns duplex-link $n8 $n5 500Kb 100ms DropTail
$ns duplex-link $n9 $n5 500Kb 100ms DropTail
$ns duplex-link $n10 $n5 500Kb 100ms DropTail


$ns duplex-link-op $n0 $n5 queuePos 0.5

$ns duplex-link-op $n0 $n5 orient right
$ns duplex-link-op $n5 $n6 orient up
$ns duplex-link-op $n5 $n7 orient right-up
$ns duplex-link-op $n5 $n8 orient right
$ns duplex-link-op $n5 $n9 orient right-down
$ns duplex-link-op $n5 $n10 orient down
$ns duplex-link-op $n0 $n2 orient left-up
$ns duplex-link-op $n0 $n3 orient left
$ns duplex-link-op $n0 $n4 orient left-down
$ns duplex-link-op $n0 $n1 orient up

proc multicst {} {
global ns nf n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 

set mproto DM
set mrthandle [$ns mrtproto $mproto {}]

set group1 [Node allocaddr]
set group2 [Node allocaddr]
set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
$udp0 set dst_addr_ $group1
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set rcvr1 [new Agent/Null]
$ns attach-agent $n1 $rcvr1
set rcvr2 [new Agent/Null]
$ns attach-agent $n2 $rcvr2
set rcvr3 [new Agent/Null]
$ns attach-agent $n3 $rcvr3
set rcvr4 [new Agent/Null]
$ns attach-agent $n4 $rcvr4
set rcvr6 [new Agent/Null]
$ns attach-agent $n4 $rcvr6
set rcvr7 [new Agent/Null]
$ns attach-agent $n4 $rcvr7
set rcvr8 [new Agent/Null]
$ns attach-agent $n4 $rcvr8
set rcvr9 [new Agent/Null]
$ns attach-agent $n4 $rcvr9
set rcvr10 [new Agent/Null]
$ns attach-agent $n4 $rcvr10

$ns at 0.1 "$n2 join-group $rcvr2 $group1"
$ns at 0.1 "$n3 join-group $rcvr3 $group1"
$ns at 0.1 "$n4 join-group $rcvr4 $group1"
$ns at 0.1 "$n6 join-group $rcvr6 $group1"
$ns at 0.1 "$n7 join-group $rcvr7 $group1"
$ns at 0.1 "$n8 join-group $rcvr8 $group1"
$ns at 0.1 "$n9 join-group $rcvr9 $group1"
$ns at 0.1 "$n10 join-group $rcvr10 $group1"


#$ns at 4.1 "$n1 leave-group $rcvr1 $group1"
$ns at 1.1 "$n2 leave-group $rcvr2 $group1"
$ns at 1.1 "$n3 leave-group $rcvr3 $group1"
$ns at 1.1 "$n4 leave-group $rcvr4 $group1"
$ns at 1.1 "$n6 leave-group $rcvr6 $group1"
$ns at 1.1 "$n7 leave-group $rcvr7 $group1"
$ns at 1.1 "$n8 leave-group $rcvr8 $group1"
$ns at 1.1 "$n9 leave-group $rcvr9 $group1"
$ns at 1.1 "$n10 leave-group $rcvr10 $group1"

set udp1 [new Agent/UDP]
$ns attach-agent $n3 $udp1
$udp1 set dst_addr_ $group2
set cbr11 [new Application/Traffic/CBR]
$cbr11 attach-agent $udp1

$ns at 0.5 "$cbr0 start"
$ns at 1.3 "$cbr0 stop"
$ns at 1.5 "$cbr11 start"
$ns at 2.5 "$cbr11 stop"

}


set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2
set tcp3 [new Agent/TCP]
$ns attach-agent $n3 $tcp3
set tcp4 [new Agent/TCP]
$ns attach-agent $n4 $tcp4
set tcp6 [new Agent/TCP]
$ns attach-agent $n6 $tcp6
set tcp7 [new Agent/TCP]
$ns attach-agent $n7 $tcp7
set tcp8 [new Agent/TCP]
$ns attach-agent $n8 $tcp8
set tcp9 [new Agent/TCP]
$ns attach-agent $n9 $tcp9
set tcp10 [new Agent/TCP]
$ns attach-agent $n10 $tcp10


set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4
set sink6 [new Agent/TCPSink]
$ns attach-agent $n6 $sink6
set sink7 [new Agent/TCPSink]
$ns attach-agent $n7 $sink7
set sink8 [new Agent/TCPSink]
$ns attach-agent $n8 $sink8
set sink9 [new Agent/TCPSink]
$ns attach-agent $n9 $sink9
set sink10 [new Agent/TCPSink]
$ns attach-agent $n10 $sink10


$ns connect $tcp1 $sink4
$ns connect $tcp2 $sink1
$ns connect $tcp3 $sink4
$ns connect $tcp2 $sink7
$ns connect $tcp6 $sink8
$ns connect $tcp9 $sink2
$ns connect $tcp10 $sink3
$ns connect $tcp7 $sink10
$ns connect $tcp1 $sink10


set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $tcp1
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 50
$cbr2 set interval_ 0.005
$cbr2 attach-agent $tcp2
set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 50
$cbr3 set interval_ 0.005
$cbr3 attach-agent $tcp3
set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 50
$cbr4 set interval_ 0.005
$cbr4 attach-agent $tcp2
set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 50
$cbr5 set interval_ 0.005
$cbr5 attach-agent $tcp6
set cbr6 [new Application/Traffic/CBR]
$cbr6 set packetSize_ 50
$cbr6 set interval_ 0.005
$cbr6 attach-agent $tcp9
set cbr7 [new Application/Traffic/CBR]
$cbr7 set packetSize_ 50
$cbr7 set interval_ 0.005
$cbr7 attach-agent $tcp1
set cbr8 [new Application/Traffic/CBR]
$cbr8 set packetSize_ 50
$cbr8 set interval_ 0.005
$cbr8 attach-agent $tcp10
set cbr9 [new Application/Traffic/CBR]
$cbr9 set packetSize_ 50
$cbr9 set interval_ 0.005
$cbr9 attach-agent $tcp7

$tcp1 set fid_ 0
$tcp2 set fid_ 1
$tcp3 set fid_ 2
$tcp4 set fid_ 3
$tcp10 set fid_ 5
$tcp6 set fid_ 4
$tcp7 set fid_ 2
$tcp8 set fid_ 1
$tcp9 set fid_ 0

$ns at 0.0 "multicst"
$ns at 3.1 "$cbr1 start"
$ns at 3.1 "$cbr8 start"
$ns at 3.2 "$cbr2 start"
$ns at 3.3 "$cbr3 start"
$ns at 3.4 "$cbr4 start"
$ns at 3.5 "$cbr5 start"
$ns at 3.6 "$cbr6 start"
$ns at 3.6 "$cbr7 start"
$ns at 3.7 "$cbr9 start"
$ns at 3.7 "$cbr1 stop"
$ns at 3.8 "$cbr2 stop"
$ns at 3.9 "$cbr3 stop"
$ns at 3.0 "$cbr4 stop"
$ns at 3.1 "$cbr5 stop"
$ns at 3.2 "$cbr6 stop"
$ns at 3.3 "$cbr7 stop"
$ns at 3.7 "$cbr8 stop"
$ns at 3.8 "$cbr7 stop"
$ns at 200 "finish"
$ns run
