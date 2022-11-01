resource "aws_route53_zone" "main" {
  name = var.domain

  tags = {
    Name        = "${var.name}-domain-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www"
  type    = "CNAME"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "main" {
  domain_name       = var.domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "main" {
#   certificate_arn = aws_acm_certificate.main.arn
#   validation_record_fqdns = [ aws_route53_record.main.fqdn ]
# }

# resource "aws_acm_certificate_validation" "www" {
#   certificate_arn = aws_acm_certificate.main.arn
#   validation_record_fqdns = [ aws_route53_record.www.fqdn ]
# }

output "tls_certificate" {
  value = aws_acm_certificate.main.arn
}

output "name_servers" {
  value = aws_route53_zone.main.name_servers
}