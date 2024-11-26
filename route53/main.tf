resource "aws_route53_zone" "intodepth" {
  name = var.domainname
}

resource "aws_route53_record" "intodepthdns" {
  zone_id = aws_route53_zone.intodepth.id
  name = var.domainname
  type = "A"
  alias {
    name = var.lburl
    zone_id = var.lbzoneid
    evaluate_target_health = true
  }
}
