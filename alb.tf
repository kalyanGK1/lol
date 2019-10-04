resource "aws_alb" "alb"{
  name="pro-alb"
  internal=false
  load_balancer_type="application"
  security_groups=["${aws_security_group.sg1.id}"]
  subnets=["${aws_subnet.subnets[0].id}","${aws_subnet.subnets[1].id}","${aws_subnet.subnets[2].id}"]
}  
  
resource "aws_alb_target_group" "tg" {
   name="prod-tg"
   port=80
   protocol="HTTP"
   vpc_id="${aws_vpc.vpc1.id}"
}

resource "aws_alb_target_group_attachment" "tg-attch"{
   count="${length(var.subnets_cidr)}"
   target_group_arn="${aws_alb_target_group.tg.arn}"
   target_id="${aws_instance.instance[count.index].id}"
   port=80
}

resource "aws_alb_listener" "alb-listner"{
  load_balancer_arn="${aws_alb.alb.arn}" 
  port=80
  protocol="HTTP"
  
  default_action {
   type="forward"
   target_group_arn = "${aws_alb_target_group.tg.arn}"
  }
}  



   
      
