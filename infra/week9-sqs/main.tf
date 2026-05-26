terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "cli-user"
}

resource "aws_sqs_queue" "dlq" {
  name                      = "terraform-cn-course-product-events-dlq"
  message_retention_seconds = 1209600
  visibility_timeout_seconds = 30
}

resource "aws_sqs_queue" "main" {
  name                       = "terraform-cn-course-product-events"
  visibility_timeout_seconds = 60
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })
}

output "main_queue_url" {
  value = aws_sqs_queue.main.url
}

output "main_queue_arn" {
  value = aws_sqs_queue.main.arn
}

output "dlq_queue_arn" {
  value = aws_sqs_queue.dlq.arn
}