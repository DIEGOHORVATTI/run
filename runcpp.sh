clear && 
echo -e "\n───────────────────────────────────────\n" && 
g++ -o ./$1 ./$1.cpp && ./$1 && rm -rf ./$1
echo -e "\n\n───────────────────────────────────────\n"