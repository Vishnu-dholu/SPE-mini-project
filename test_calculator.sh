#!/bin/bash

# tolerance for floating comparison
EPSILON=0.000001

pass_count=0
fail_count=0

compare_float() {
    diff=$(echo "$1 - $2" | bc -l)
    abs=$(echo "if ($diff < 0) -1*$diff else $diff" | bc -l)

    comp=$(echo "$abs < $EPSILON" | bc -l)

    if [ "$comp" -eq 1 ]; then
        return 0
    else
        return 1
    fi
}

print_result() {
    if [ $1 -eq 0 ]; then
        echo "PASS: $2"
        ((pass_count++))
    else
        echo "FAIL: $2"
        ((fail_count++))
    fi
}

echo "Running Scientific Calculator Tests..."
echo "--------------------------------------"

# Square Root Tests
result=$(echo "scale=4; sqrt(16)" | bc -l)
compare_float $result 4
print_result $? "SquareRoot(16)"

result=$(echo "scale=4; sqrt(2.25)" | bc -l)
compare_float $result 1.5
print_result $? "SquareRoot(2.25)"

# Factorial Tests
factorial() {
    n=$1
    fact=1
    for ((i=1;i<=n;i++))
    do
        fact=$((fact*i))
    done
    echo $fact
}

result=$(factorial 5)
[ "$result" -eq 120 ]
print_result $? "Factorial(5)"

result=$(factorial 7)
[ "$result" -eq 5040 ]
print_result $? "Factorial(7)"

# Natural Log Tests
result=$(echo "scale=4; l(1)" | bc -l)
compare_float $result 0
print_result $? "ln(1)"

result=$(echo "scale=10; l(e(1))" | bc -l)
compare_float $result 1
print_result $? "ln(e)"

# Power Tests
result=$(echo "2^3" | bc -l)
compare_float $result 8
print_result $? "Power(2,3)"

result=$(echo "2^-1" | bc -l)
compare_float $result 0.5
print_result $? "Power(2,-1)"

echo "--------------------------------------"
echo "Tests Passed: $pass_count"
echo "Tests Failed: $fail_count"

if [ $fail_count -gt 0 ]; then
    exit 1
else
    exit 0
fi
