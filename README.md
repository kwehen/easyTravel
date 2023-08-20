# easyTravel
Get easyTravel up and running with the oneAgent on AWS in minutes with this repo!

<img width="1920" alt="Screenshot 2023-08-20 at 12 03 31 PM" src="https://github.com/kwehen/easyTravel/assets/110314567/7273dac1-cd18-47be-924c-469003641bd2">
<img width="1298" alt="Screenshot 2023-08-20 at 12 02 43 PM" src="https://github.com/kwehen/easyTravel/assets/110314567/1f23f8c7-91ab-41a0-b7df-e76c88b8b258">

# Pre-requisites
- Terraform must be installed on your local machine. This can be done using this link: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- You must have a working AWS Account with valid permissions, if you do not, this can be done using this link: https://aws.amazon.com/resources/create-account/
- You must configure the AWS CLI: https://www.youtube.com/watch?v=dZgLNL869YU
- You must have a working Dynatrace tenant, managed or SAAS: https://www.dynatrace.com/signup/

# Instructions
1. Clone this repo to your local PC:
   $ git clone https://github.com/kwehen/easyTravel
3. Place your DT tenant URL, PAAS Token, and oneAgent installation commands inside of the easytravel-install.sh script (Lines 13, 14, 164-166)
4. Create a private GitHub repository and upload your configured easytravel-install.sh script (Make sure the file is named "easytravel-install.sh")
5. In your private GitHub repository, navigate to the RAW file of easytravel-install.sh in your browser.
6. Copy the link to the RAW file. It should look similar to https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/easytravel-install.sh?token=RANDOMTOKENGENRATEDBYPRIVATEREPO
7. Paste link into userdata.tpl on your local machine
8. $ terraform init
9. $ terraform apply
