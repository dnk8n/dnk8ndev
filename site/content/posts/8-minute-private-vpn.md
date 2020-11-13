---
title: 8 minute private VPN
date: 2020-11-12T11:58:53.635Z
tags:
  - vpn
  - terraform
  - automation
  - privacy
  - open-source
categories:
  - DevOps
---
**Introduction:**

I show how to use my fork, but all the credit goes to the original repo, located at https://github.com/dumrauf/openvpn-terraform-install. I suggest that you look at this upstream project instead of mine. I made changes to suit me. I removed the wrapper scripts, took out some automation that I felt would be easier for collaborators to understand if they followed a couple manual steps (to add/revoke users). I also added .envrc.tpl for quick configuration (I use Direnv to maintain config per file directory)

<div class="youtube" data-id="ittv-1ya1tc"></div>

**This first video shows how to:**

 - pull the code required
 - set up the configuration
 - activate the configuration

**Tool/Service requirements for this video series:**

 - Amazon AWS account
 - A computer or VM with GNU/Linux installed (Mac or Windows could work, but untested and would probably be slightly different workflow)
 - Git - https://git-scm.com/
 - Direnv - https://direnv.net/
 - Terraform - https://www.terraform.io/

**Steps:**

 - Create an IAM user with correct privileges (EC2 mainly) and an access key (under the security credentials tab of IAM)... ask questions in the comments if you don't manage to figure it out
 - Clone the repo `git clone https://github.com/dnk8n/openvpn-terraform-install` (in the video I use the ssh protocol which would need a github account, etc which is not necessary)
 - Copy the .envrc.tpl as a starting point. Change instance type to t2.micro for free tier (some regions don't have t2.micro, in which case t3.micro). Paste your access keys in here. Also, choose the region you want.
 - You can simply `source ./envrc`, however, I use Direnv so that every time I cd into this directory it automatically has my shell variables sourced. To activate `direnv allow ./envrc`. In future you will only need to do this again if you change variables.

___

<div class="youtube" data-id="hD1Jaqsvrn4"></div>

Run command `terraform init`. This installs tools required for the VPN deployment.

___

<div class="youtube" data-id="jk3b1TbHemI"></div>

Now that terraform is initialized, run `terraform apply`

___

<div class="youtube" data-id="jtGLCmo0DQc"></div>

If you have a flaky internet connection like me an error could happen like shown here. Don't worry, terraform is idempotent. You can just run `terraform apply` again and it will calculate what needs doing the second time around so that there are no undesired consequences!

___

<div class="youtube" data-id="yf5LK85VtmQ"></div>

Answer yes and the resources will be provisioned.

___

<div class="youtube" data-id="51pSCcnMuSw"></div>

Showing the provisioning of terraform apply command. OpenVPN gets installed all by automation. You can look through the code at https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh to see how the install script works.

___

<div class="youtube" data-id="3JdI6xJwqNI"></div>

Just continuing to show the provisioning so that you get a sense of how long it takes!

___

<div class="youtube" data-id="7ooW3IFkFi4"></div>

Provisioning completes and we get an output showing us the ssh command we can use to connect to our newly provisioned remote instance.

___

<div class="youtube" data-id="svMk6btsk2k"></div>

Once ssh'd in, issue command `sudo ./openvpn-install.sh`. This will tell you that OpenVPN is already installed but additionally gives the option to add a new user. Follow the prompts.

You will see that a new .ovpn is created, named according to your inputs.

___

<div class="youtube" data-id="UA-AqAPY3QY"></div>

Use scp to transfer the OpenVPN client config to your local machine, e.g `scp -i ~/.ssh/openvpn.pem ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com:yourname.ovpn ~/Downloads/`

Then import the file into your machine's VPN settings as shown in the video. You might need to install openvpn and an openvpn integration with your desktop environment. Ask in the comments if you struggle with this step.

Once the OpenVPN client config is imported successfully, you can toggle on the VPN connection. You should see a lock on the top right of the taskbar.

___

<div class="youtube" data-id="8j-u8c9jTF0"></div>

To test that the VPN is working, you can navigate to one of:

 - https://whatismyipaddress.com/
 - https://www.whatismyip-address.com/
 - https://www.whatismyip.com/

At least one of them should work at the time you try.

See that while the VPN is activated, your location matches that of the AWS region you selected. While deactivated, your location matches your actual location.

___

<div class="youtube" data-id="vqgkpjWJXV4"></div>

Here follows a demonstration on how to revoke an OpenVPN client config. Note how after revoking it following the corresponding prompts of `sudo ./openvpn-install.sh`, the VPN config imported previously stops working (the lock on the top right of the taskbar fails to appear as it did before).

This is useful, for example, if a colleague leaves your company and you don't wish for them to gain access to your internal network anymore.

___

<div class="youtube" data-id="bdsu4VljFfg"></div>

Here I show the process of destroying all the infrastructure you have created up until now. This stops all billing (except you do get charged for a full hour for your instance if it was up for less than an hour).

In order to do this, terraform uses the state files to determine what it can destroy. Those files are located in the .terraform folder. It is possible to store this state in the cloud, that way you can destroy this from anywhere, so long as you have access to those state files. Look for how to do this at https://www.terraform.io/docs/state

This would be useful if your server is known to become compromised. It also might be easier to make a few edits to the code to link to a static IP. To upgrade your OpenVPN server to the latest releases, you could destroy this infrastructure and reprovision with the latest on a fresh instance.

Note that if you do this, you will need to reissue all client configs again. But this is probably not a terrible idea for security, although there might be some work to do connecting other applications to the new infrastructure.

But in case you are a casual VPN user, you could use this system of temporary provisioning to save a lot of money. Running this infrastructure for 10 hours would cost you less than $0.06 (assuming a t2.nano instance type)!

___

<div class="youtube" data-id="_40cQo30Y-0"></div>

Continuing on from the last video just to give you a feeling of the `terraform destroy` process and how long it takes.

___

<div class="youtube" data-id="AaM-xsSFiaw"></div>

You get a chance to answer yes or no at the prompt. Before the prompt, terraform calculates what it will do without affecting your infrastructure. After a 'yes' to the prompt, it carries out the pre-calculated actions.

If you selected 'no' it would simply cancel the destroy process.

___

<div class="youtube" data-id="JLwyYFR_Xq4"></div>

And we're done. Everything is back to the way it was before you started. No trace!

**Some things to consider:**

- Although the infrastructure might cast under $0.06 as mentioned before, the bandwidth you use through the VPN will cost $0.15/GB. It is possible to route only certain traffic through the VPN. I will leave that up to you to figure out.

- It is worth exploring the repositories and familiarizing yourself with the code to configure the VPN how you want to. We each have different needs, so out of the box, this won't be to everyone's taste. If you make a change and run `terraform apply` while there is an existing deployment, terraform will calculate what it needs to do in order to apply your changes. In this case, it will rerun the idempotent provisioning script, allowing your changes to be incorporated
___

Hope you enjoyed the tutorial. Please let me know in the youtube comments about any problems or suggestions. You can also find me @dnk8n on most popular platforms in case you prefer.