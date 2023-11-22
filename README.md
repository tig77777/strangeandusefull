# strangeandusefull
Scripts, network stuff

network-config.ps1
Network Configuration Tool (PowerShell Script)
Description
This PowerShell script provides a convenient way to configure network settings on Windows systems. It allows users to modify IP address, subnet mask, gateway, and DNS settings for any active network adapter. The script is designed to be user-friendly, offering a selection of network adapters and accepting input only for the settings you wish to change.

Features
List Active Network Adapters: Displays all active network adapters on the system.
Selectable Network Adapter Configuration: Allows users to choose which network adapter they want to configure.
Flexible Network Settings: Users can update the IP address, subnet mask, gateway, and DNS settings. Each setting is optional; leave it blank if no change is needed.
User-Friendly Interface: Simple prompts guide the user through the configuration process.
Usage
Run as Administrator: To use the script, open PowerShell with administrative privileges.
Navigate to Script Location: Use the cd command to navigate to the directory containing the script.
Execute the Script: Run the script by typing .\network-config.ps1.
Follow Prompts: The script will display a list of active network adapters. Enter the number corresponding to the adapter you wish to configure, then input the desired network settings as prompted.
Requirements
PowerShell: This script is designed for Windows PowerShell.
Administrative Privileges: Administrative rights are required to change network settings.
Contributions
Feedback, suggestions, and contributions are welcome. Please feel free to fork the repository, make changes, and submit a pull request.

3x-ui Docker Setup Script

based on https://openode.ru/topic/529-3x-ui-xray-shadowsocks-kak-zamena-wireguard-docker-edition/?do=findComment&comment=1783&_rid=574

Description

This Bash script automates the setup of the 3x-ui environment using Docker on a Linux system. It simplifies the process of configuring and deploying the 3x-ui Docker container, handling everything from installing necessary dependencies to setting up SSL certificates and configuring Docker Compose.

Features

Automatic Dependency Installation: Installs Docker Compose and Certbot automatically.
Docker Environment Setup: Creates necessary directories and fetches the docker-compose.yml file from the 3x-ui GitHub repository.
Dynamic Docker Compose Configuration: Configures the Docker Compose file with the user's domain name and sets up volume mappings and environment variables.
SSL Certificate Setup: Automates the acquisition of SSL certificates using Certbot and configures symlinks to the certificate files.
Python Shebang Updating: Updates the Python shebang in the SSL certificate script for compatibility.
Permission Management: Sets appropriate file permissions for SSL certificate files.
Docker Container Management: Handles the starting of the Docker container with the configured settings.
Usage
Run the Script: copy and run;)
Follow the Prompts: Provide the necessary information when prompted.
After installation visit "your_ip|domain_name":2053/panel (admin/admin)
