clear &&
echo -e "\n───────────────────────────────────────\n" && 
gcc ./$1 -o ./$1.exe && ./$1.exe && rm -rf ./$1.exe
echo -e "\n\n───────────────────────────────────────\n"