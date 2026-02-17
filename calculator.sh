#!/bin/bash
# Scientific Calculator Shell Program

echo "1. Addition"
echo "2. Subtraction"
echo "3. Multiplication"
echo "4. Division"

echo -n "Enter First Number: "
read a
echo -n "Enter Second Number: "
read b
echo -n "Enter the Choice: "
read ch

case $ch in
   1) res=$(expr $a + $b)
      ;;
   2) res=$(expr $a - $b)
      ;;
   3) res=$(expr $a \* $b)
      ;;
   4)
      if [ $b -eq 0 ]; then
         echo "Division by zero not allowed"
         exit 1
      fi
      res=$(expr $a / $b)
      ;;
   *) echo "Invalid choice"
      exit 1
      ;;
esac

echo "Result: $res"
