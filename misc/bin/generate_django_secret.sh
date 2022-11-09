# Filename: generate_django_secret.sh
#!/bin/bash
function generate_secret() {
  echo "Django secret for $1 stack"
  head -c 51 < /dev/urandom | base64 | tr '/' '_'
}

generate_secret $1
