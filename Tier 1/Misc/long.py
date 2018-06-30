import socket                                                                                               
import sys                                                                                                  
import re     #module for regular expression                                                                                                 
                                                                                                            
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  #creates a new socket                                                       
s.connect(("shell2017.picoctf.com", 14319))            #connect to the service                                
msg = s.recv(10000)                                    #save receiving message from service                              
print(msg)                                                                                                  
regex_times = r"('[0-9]+'|'[A-Za-z]+')"                #regular expression to filter the parameters                 
                                                                                                            
                                                                                                            
reg_search = re.findall(regex_times, msg)              #find all expressions in the message matching the regex 
						       #(every substring enclosed in '' with only one or more numbers or one letter will be matched)                                                     
                                                                                                            
                                                                                                            
regsearch = [ x.replace("'", "") for x in reg_search ] #remove ' from all hits
                                                                                                            
times = int(regsearch[1])                              #cast to int so we can multiply with times                              
char = regsearch[0]                                    #save the char we want to print           
last = regsearch[2]                                    #this is the last char                      
                                                                                                        
tosend = char*times + last                             #this creates the string we want to send                                                    
s.send(tosend + "\n")                                  #we concatinate \n so the server knows we are done sending             
                                  
print(s.recv(1000)  )                                  #print the answer (the flag)                                                               
               
