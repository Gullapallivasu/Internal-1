#!/bin/bash

#Tool determines if a given IPv4 address is in a given subnet

echo_usage() {
  echo "Usage: $0 input_file.txt output_file.txt"
  exit 1
}

if [ $# -ne 2 ] ; then echo_usage ; fi

INPUT_FILE=$1 ; shift
OUTPUT_FILE=$1 ; shift 

if [ ! -f ./"$INPUT_FILE" ]; then
  echo "Create a file similar to input_file.txt or get it from github and place it in the same directory"
  exit 1
fi

if [ -f ./"$OUTPUT_FILE" ]; then rm -rf ./"$OUTPUT_FILE" ; fi

while read -r Given_Hex_IP Given_CIDR_subnet ; do
  
  check_IP_address_format() {
    
    #Verify if string is Hexadecimal or not
    if [ "${Given_Hex_IP:0:2}" == "0x" ] ; then
      convert_hex_to_IP
    else
      echo "Please enter correct string in Hexadecimal format" >> "$OUTPUT_FILE"
      continue
    fi
  
  }

  convert_hex_to_IP(){
    
    #Get the IP ; cut "0x" from it ; Add "0x" to every two digits with a trailing space ; 
    #Split it to to a new line with space as delimiter.
    split_IP=($(echo "$Given_Hex_IP" | cut -c 3- | sed 's/../0x& /g' | tr ' ' '\n'))
  
    #convert each element in the array to decimal number
    IP_Address=($(printf "%d." "${split_IP[@]}" | sed 's/\.$/\n/'))

  }

  check_nmap_install() {
  
    #check if nmap is installed or not ; else install it
    nmap --version >>/dev/null
    if [ $? -ne 0 ]; then
      sudo apt-get -qq install nmap
    fi

  }

  check_if_IP_in_subnet() {
    #Create a file with all IPs of the network specified
    nmap -sL "$Given_CIDR_subnet" | grep "Nmap scan report" | awk '{print $NF}' > ./nmap_scan_report.txt
    #grep the Interested IP address in the file
    if grep -Fq "$IP_Address" ./nmap_scan_report.txt ; then
      echo "True" >> "$OUTPUT_FILE"
    else
      echo "False" >> "$OUTPUT_FILE"
    fi
    rm -rf ./nmap_scan_report.txt
  }
  
  check_IP_address_format
  check_nmap_install
  check_if_IP_in_subnet
done<"$INPUT_FILE"

echo "Tool successfully ran, and the output of the run is in output_file.txt"
