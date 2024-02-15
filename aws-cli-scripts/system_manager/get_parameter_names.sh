#get parameter names (from aws system manager parameter store) based on presence of a value (case-sensitive)
parameter_names_array=$(aws ssm describe-parameters --query 'Parameters[].Name')
echo $parameter_names_array
all_parameter_names=$(echo $parameter_names_array | tr -d [,'"'])
echo $all_parameter_names
for parameter_name in $all_parameter_names
do
  temp_result=$(aws ssm get-parameters --names $parameter_name --with-decryption --query 'Parameters[?contains(Value,`test1.txt`) == `true`].Name')
  result=$(echo $temp_result | tr -d [])
  if ! [ -z "$result" ]; then
    echo $result
  fi
done

#check for multiple values
#temp_result=$(aws ssm get-parameters --names $parameter_name --with-decryption --query 'Parameters[?contains(Value, `test1.txt`) || contains(Value, `test2.txt`) || contains(Value, `test3.txt`)].Name')