aws route53 create-hosted-zone --name kruta.link --caller-reference 2022-11-03
aws route53 list-hosted-zones
aws route53 list-resource-record-sets --hosted-zone-id /hostedzone/Z072644766PACZEBSIHZ

dig kruta.link
;; AUTHORITY SECTION:
kruta.link.		900	IN	SOA	ns-1190.awsdns-20.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
