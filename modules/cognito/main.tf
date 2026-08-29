
resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes = ["email"]

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = false
    temporary_password_validity_days = 7
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }
  tags = var.tags
}

resource "aws_cognito_user_pool_client" "this" {
  name         = var.app_client_name
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}

resource "aws_cognito_user" "test_user" {
  user_pool_id = aws_cognito_user_pool.this.id

  username = var.test_user_email

  attributes = {
    email          = var.test_user_email
    email_verified = "true"
  }

  temporary_password = var.test_user_password

  message_action = "SUPPRESS"
}

resource "aws_cognito_user_group" "admins" {
  user_pool_id = aws_cognito_user_pool.this.id

  name        = "Admins"
  description = "Administrators of the FileProcessing API"

  precedence = 1
}