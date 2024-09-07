#!/bin/bash

install_terraform() {
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null
    then
        echo "Terraform not found. Installing Terraform..."
        sudo apt-get update
        sudo apt-get install -y gnupg software-properties-common curl
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        # Install Terraform
        sudo apt-get update && sudo apt-get install terraform
        echo "Terraform installed successfully!"
    else
        echo "Terraform is already installed."
    fi
}

get_credentials(){
    read -p "Enter your AWS_ACCESS_KEY: " AWS_ACCESS_KEY
    read -p "Enter your AWS_SECRET_ACCESS_KEY: " AWS_SECRET_KEY
    read -p "Enter your AWS_REGION: " AWS_REGION
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
    export AWS_DEFAULT_REGION=$AWS_REGION
} 


install_cluster() {
  echo "Installing cluster..."
  echo "Getting Credentials..."
  #get_credentials
  terraform validate
  terraform init
  terraform plan
  terraform apply
  echo "Cluster installation complete."
}


# Function to stop the cluster
stop_cluster() {
  terraform destroy
  echo "Stopping cluster..."
  echo "Cluster stopped."
}

# Function to check the status of the cluster
check_status() {
  echo "Checking cluster status..."
  read -p "Enter the ALB DNS: " ALB_DNS

  # Perform status check by making 10 requests to the ALB
  for X in $(seq 10); do
    curl -so /dev/null -w "%{http_code}\n" "$ALB_DNS"
  done

  echo "Cluster status check complete."
}

show_menu() {
  echo "========== Cluster Management Menu =========="
  echo "1. Get Credentials"
  echo "2. Install cluster"
  echo "3. Stop cluster"
  echo "4. Check cluster status"
  echo "5. Quit"
  echo "============================================"

  read -p "Enter your choice (1-5): " choice
  echo

  case "$choice" in
    1) 
      get_credentials
    ;;
    2)
      install_terraform
      install_cluster
      ;;
    3)
      stop_cluster
      ;;
    4)
      check_status
      ;;
    5)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac

  echo
  show_menu
}

# Main script
show_menu