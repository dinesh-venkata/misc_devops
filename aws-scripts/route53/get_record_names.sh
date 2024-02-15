#get route53 'A' type record names
records=()
all_hosted_zones=$(aws route53 list-hosted-zones --query "HostedZones[*].Id")
hosted_zone_ids=$(echo $all_hosted_zones | tr -d [,'"'/hostedzone/])
echo $hosted_zone_ids
for hosted_zone_id in $hosted_zone_ids
do
  temp_record_names=$(aws route53 list-resource-record-sets --hosted-zone-id $hosted_zone_id --query "ResourceRecordSets[?Type=='A'].Name" | tr -d [,'"'])
  records+=($temp_record_names)
  echo $hosted_zone_id
done
echo "${records[@]}"