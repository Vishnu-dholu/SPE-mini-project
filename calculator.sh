#!/bin/bash
# Scientific Calculator Shell Program using while loop

while true
do
    echo "------ Scientific Calculator ------"
    echo "1. Square Root (√x)"
    echo "2. Factorial (x!)"
    echo "3. Natural Logarithm ln(x)"
    echo "4. Power (x^b)"
    echo "5. Exit"

    echo -n "Enter your choice: "
    read ch

    case $ch in
        1)
            echo -n "Enter number: "
            read x

            if (( $(echo "$x < 0" | bc -l) )); then
                echo "Square root undefined for negative numbers"
            else
                res=$(echo "scale=4; sqrt($x)" | bc -l)
                echo "Square root of $x = $res"
            fi
            ;;

        2)
            echo -n "Enter number: "
            read x

            if [ "$x" -lt 0 ]; then
                echo "Factorial undefined for negative numbers"
            else
                fact=1
                for ((i=1;i<=x;i++))
                do
                    fact=$((fact * i))
                done
                echo "Factorial of $x = $fact"
            fi
            ;;

        3)
            echo -n "Enter number: "
            read x

            if (( $(echo "$x <= 0" | bc -l) )); then
                echo "ln(x) undefined for x <= 0"
            else
                res=$(echo "scale=4; l($x)" | bc -l)
                echo "ln($x) = $res"
            fi
            ;;

        4)
            echo -n "Enter base (x): "
            read x
            echo -n "Enter power (b): "
            read b

            res=$(echo "scale=4; $x^$b" | bc -l)
            echo "$x^$b = $res"
            ;;

        5)
            echo "Exiting calculator..."
            break
            ;;

        *)
            echo "Invalid choice. Try again."
            ;;
    esac

    echo ""
done
