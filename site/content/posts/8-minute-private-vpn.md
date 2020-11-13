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

<iframe width="437" height="246" src="https://www.youtube.com/embed/ittv-1ya1tc?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

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

<iframe width="437" height="246" src="https://www.youtube.com/embed/hD1Jaqsvrn4?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Run command `terraform init`. This installs tools required for the VPN deployment.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/jk3b1TbHemI?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Now that terraform is initialized, run `terraform apply`

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/jtGLCmo0DQc?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

If you have a flaky internet connection like me an error could happen like shown here. Don't worry, terraform is idempotent. You can just run `terraform apply` again and it will calculate what needs doing the second time around so that there are no undesired consequences!

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/yf5LK85VtmQ?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Answer yes and the resources will be provisioned.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/51pSCcnMuSw?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Showing the provisioning of terraform apply command. OpenVPN gets installed all by automation. You can look through the code at https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh to see how the install script works.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/3JdI6xJwqNI?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Just continuing to show the provisioning so that you get a sense of how long it takes!

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/7ooW3IFkFi4?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Provisioning completes and we get an output showing us the ssh command we can use to connect to our newly provisioned remote instance.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/svMk6btsk2k?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Once ssh'd in, issue command `sudo ./openvpn-install.sh`. This will tell you that OpenVPN is already installed but additionally gives the option to add a new user. Follow the prompts.

You will see that a new .ovpn is created, named according to your inputs.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/UA-AqAPY3QY?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Use scp to transfer the OpenVPN client config to your local machine, e.g `scp -i ~/.ssh/openvpn.pem ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com:yourname.ovpn ~/Downloads/`

Then import the file into your machine's VPN settings as shown in the video. You might need to install openvpn and an openvpn integration with your desktop environment. Ask in the comments if you struggle with this step.

Once the OpenVPN client config is imported successfully, you can toggle on the VPN connection. You should see a lock on the top right of the taskbar.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/8j-u8c9jTF0?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To test that the VPN is working, you can navigate to one of:

 - https://whatismyipaddress.com/
 - https://www.whatismyip-address.com/
 - https://www.whatismyip.com/

At least one of them should work at the time you try.

See that while the VPN is activated, your location matches that of the AWS region you selected. While deactivated, your location matches your actual location.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/vqgkpjWJXV4?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Here follows a demonstration on how to revoke an OpenVPN client config. Note how after revoking it following the corresponding prompts of `sudo ./openvpn-install.sh`, the VPN config imported previously stops working (the lock on the top right of the taskbar fails to appear as it did before).

This is useful, for example, if a colleague leaves your company and you don't wish for them to gain access to your internal network anymore.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/bdsu4VljFfg?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Here I show the process of destroying all the infrastructure you have created up until now. This stops all billing (except you do get charged for a full hour for your instance if it was up for less than an hour).

In order to do this, terraform uses the state files to determine what it can destroy. Those files are located in the .terraform folder. It is possible to store this state in the cloud, that way you can destroy this from anywhere, so long as you have access to those state files. Look for how to do this at https://www.terraform.io/docs/state

This would be useful if your server is known to become compromised. It also might be easier to make a few edits to the code to link to a static IP. To upgrade your OpenVPN server to the latest releases, you could destroy this infrastructure and reprovision with the latest on a fresh instance.

Note that if you do this, you will need to reissue all client configs again. But this is probably not a terrible idea for security, although there might be some work to do connecting other applications to the new infrastructure.

But in case you are a casual VPN user, you could use this system of temporary provisioning to save a lot of money. Running this infrastructure for 10 hours would cost you less than $0.06 (assuming a t2.nano instance type)!

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/_40cQo30Y-0?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Continuing on from the last video just to give you a feeling of the `terraform destroy` process and how long it takes.

___

<iframe width="437" height="246" src="https://www.youtube.com/embed/AaM-xsSFiaw?list=PLvvmwjQ_mfY6aENXDRJn0VH6UU0OAFNm6" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

You get a chance to answer yes or no at the prompt. Before the prompt, terraform calculates what it will do without affecting your infrastructure. After a 'yes' to the prompt, it carries out the pre-calculated actions.

If you selected 'no' it would simply cancel the destroy process.

___

Part 16 is coming tomorrow due to quota upload limits imposed :)

___

Hope you enjoyed. Please let me know in the youtube comments about any problems. You can also find me @dnk8n on most platforms in case you prefer.

