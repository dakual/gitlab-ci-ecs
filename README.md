Create a new hosted zone
```sh
aws route53 create-hosted-zone --name kruta.link --caller-reference 2022-11-03
```
AWS provides the NameServers record for all new hosted zones. If your domain is registered outside of AWS, you would provide these nameservers to your domain provider.


List all hosted zones and get records
```sh
aws route53 list-hosted-zones
aws route53 list-resource-record-sets --hosted-zone-id /hostedzone/Z072644766PACZEBSIHZ
```

Checking domain is ready
```sh
dig kruta.link
# ;; AUTHORITY SECTION:
# kruta.link.		900	IN	SOA	ns-1190.awsdns-20.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
```