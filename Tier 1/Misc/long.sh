exec 3<>/dev/tcp/shell2017.picoctf.com/14319;           #/dev/tcp/host/port establishes a bidirectional TCP socket to host:port
														# 3<> is used to redirect to input/output to channel 3
														# this means when we read/print to this channel we will communicate with the service. We can read read from channel 3 with <&3, to write to the channel >3&
														# when we use stdin/stdout (channel 1, this is standard) we will communicate with our shell                                                    
                                                                                                            
string=$(head -2 <&3)                                   # grab the message from server
														# be careful to grab more lines than the service printed or this will end in an infinte loop because the service has not yet sent a 'EOF' flag
times=$(echo $string | egrep "'[0-9][0-9]+'" -o | sed "s/'//g")          #uses RegEx to filter the parameters, sed removes the ''              
char=$(echo $string | egrep "'[A-Za-z]+'" -o | sed "s/'//g")                                                                                                                                             
last=$(echo $string | egrep "'[0-9]'" -o | sed "s/'//g")                                                 
                                                                                            
counter=0                                                                                                   
while [ $counter -le $timess ]                                                                              
do                                                                                                                                                                                               
        if [ $counter -eq $timess ]; then               #on the last iteration we will print the lastletter to the service                                                                                                                          
                echo "$lastlet" >&3                                                                         
        fi                                                                                                  
        echo -ne $chara >&3                             #print the char to the service                                                                                                                                        
        ((counter++))                                                                                       
                                                                                                            
done                                                                                                        
string=$(head -4 <&3)                                   #get the answer                                                   
echo $string                                                                                                
