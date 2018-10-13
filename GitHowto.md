#Pre-requisites

- Git is installed
- Visual Studio Code is installed
- Azure DevOps account

1. Begin by creating a new Azure DevOps project. Name it 'Git Training'. 

2. Navigate to 'Repos' on the left hand menu, and copy the URL of your repo:

![Clone Repo](/images/step0.png)

3. Open Command Prompt and clone the repo of your newly created project to your desktop using the command below - this will create a folder called 'Git%20Training'

```
git clone <repo url>
```

4. Next, navigate to the repo below, and download it as a zip:

    https://charlenem.visualstudio.com/_git/Git%20Training

5. Extract the files contained within to the repo you cloned earlier (the folder on your desktop called Git%20Training).

6. In the command prompt window, type the following commands. Don't worry - we will explain these commands later!

```
git add -A
git commit -m "initial commit"
git push
```
> Note: If you run into authentication issues, [install the Git Credential Manager](https://docs.microsoft.com/en-us/azure/devops/repos/git/set-up-credential-managers?view=vsts).

We now have our files in our local repo, and in the remote repo of the Azure DevOps project you just created.

#Making a change in Visual Studio Code

1. Right click on the newly created 'Git%20Training' folder and 'Open with Visual Studio Code'. You should see two files in the file explorer: azuredeploy.json and azuredeploy.parameters.json. 

![VSCode](/images/step1.png)


2. Click on azuredeploy.json in the file explorer, and locate line 13.

![change line](/images/step2.png)

3. Change the location from West Europe to North Europe and save with ctrl+s. Notice how we now have some notifications on the left:

![explorer](/images/Step3.png)

4. Click on the icon highlighted - this is a source control extension for Visual Studio Code that allows us to work more easily with our Git repos. Notice how our azuredeploy.json file has a letter beside it? The M means that Git is detecting changes to our file.

![git changes](/images/Step4.png)

5. Click on azuredeploy.json. You can now see a side by side comparison of the change we made. On the left, we can see that 'West Europe' was removed, and on the right we can see that it was replaced with 'North Europe'.

![comparison](/images/Step5.png)

6. We need to tell Git to track this file before we can commit our change. We can do this via the VSCode GUI, or in the terminal. Let's stick with the GUI for this change. Click on the 'plus' sign next to our file:

![stage file](/images/Step6.png)

7. Our changes have now been staged, which means that we can now commit our changes. 

![stage file](/images/Step7.png)

8. Notice the box underneath Source Control - this is where can enter our commit message, and proceed to tell Git to commit our change. Type something like 'changed location on line 13', then click the tick

![commit](/images/Step8.png)

9. We are now ready to push our changes to our remote repo! For this, we will use the built-in Terminal. Use the ctrl + ` to open the Terminal, or navigate to 'View' and select Terminal.

![view terminal](/images/Step9.png)

10. The first thing we should do is:

```
git pull
```

The reason for this is simple; as we are working on the main branch, some of our colleagues may well have made some updates to the remote repo. We want to make sure we have the absolute latest copy of the repo before pushing our changes to it.

As nobody as made any changes, you will see something like this:

![git pull](/images/Step10.png)

11. Finally, type the following command to push our changes to the remote repo. 

```
git push
```
You shouldn't encounter any errors at this stage, and will see something like the below:

![git push](/images/Step11.png)


#Resolving Merge Conflicts

With multiple co-workers all working off the same code base, and in this scenario, branch - it is inevitable that we will run into merge conflicts. A merge conflict happens when we try to push our code to our remote repo, only to find that someone else has modified the same file(s).

Resolving conflicts can seem daunting at first, but VSCode gives us a really nice visual way of viewing conflicts, and resolving them sensibly. 

Let's create a merge conflict.

1. Navigate to the Azure DevOps portal, and find your azuredeploy.json template in the repo. Click edit, and go to line 13. Change the location back to West Europe. Commit your changes. 

![change code](/images/Step12.png)

2. Flip back to VSCode. Click the azuredeploy.json file and find line 13 again. Change the location to South Central US. Hit ctrl+s to save changes.

3. In the Terminal, type the following command:

```
git commit -a –m “changed location”
```

4. This is a quick way of staging and commiting our change in one line. Next, let's go ahead and attempt to push our code to the remote repo.

```
git push
```

You will get an error like the below:

![error](/images/Step13.png)

5. Git detects that our local repo is behind the remote repo. The error messages encourages us to git pull - let's do that, to see what's going on in the remote repo.

```
git pull
```

![error](/images/Step14.png)

Remember; we changed the same line in our remote repo, and Git cannot automatically resolve this merge conflict for us. We need to decide which change to keep. 

You will notice in our code view, that we can see the line that is creating a merge conflict.

![merge conflict](/images/Step15.png)

6. Click on 'Compare Changes' for a side by side view. On the left, we can see our local change; South Central US. On the right, we can see the incoming change from our remote repo, West Europe. 

![merge conflict](/images/Step16.png)

7. Go back to the azuredeploy.json by clicking on it in the file explorer on the left. We will choose to keep the incoming change in this case. Click 'Accept Incoming Change':

![merge conflict](/images/Step17.png)

We have successfuly incorporated the incoming change, but we still haven't actually finished our merge action. Remember, we tried to push our code to the remote repo, but the push was rejected as our repo wasn't up to date.

We then attempted to merge the remote repo with our local repo, and encountered a merge conflict.

8. Now that the merge conflict is resolve, we can proceed to merge. To do this in the terminal, type the following:

```
git commit -a -m "location updated"
git push
```

Our code will successfully be pushed to the remote repo, now that we have resolved our merge conflicts.


#Working with local branches

The last example is of using a simple strategy of commiting directly to the main branch (also known as trunk or master). Depending on your scenario, you may want to implement a more complex branching strategy. By using branches, we can ensure that our main, or master branch, is always protected and ready to go into production.

This next section will guide you through creating a local branch for developing a new feature. We will then merge that feature branch into our main branch once we are happy with it. 

1. To create a new branch, type the following commands into your Terminal:

```
git branch feature1
git checkout feature1
git status
```
![new branch](/images/Step18.png)

The first command created our branch, and the second switched to that branch. git status allows us to make sure we are working in the correct branch. Any work we do now will apply to only the feature1 branch. 

2. Let's create a new Azure Resource Manager template. Click on the 'Add File' icon picture below, and name it azuredeploy2.json

![add file](/images/Step19.png)

3. Copy the below json into the empty file, and hit ctrl+s to save it. 

```
{ 
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminUsername": {
      "type": "string",
      "metadata": {
        "description": "Admin username"
      }
    },
    "adminPassword": {
      "type": "securestring",
      "metadata": {
        "description": "Admin password"
      }
    },
    "vmNamePrefix": {
      "type": "string",
      "defaultValue": "BackendVM",
      "metadata": {
        "description": "Prefix to use for the VM names"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    }
  },
  "variables": {
    "availabilitySetName": "AvSet",
    "storageAccountType": "Standard_LRS",
  "storageAccountName": "[uniqueString(resourceGroup().id)]",
    "virtualNetworkName": "vNet",
    "subnetName": "backendSubnet",
    "loadBalancerName": "ilb",
    "networkInterfaceName": "nic",
    "subnetRef": "[resourceId('Microsoft.Network/virtualNetworks/subnets', variables('virtualNetworkName'), variables('subnetName'))]",
    "numberOfInstances": 2,
    "lbID": "[resourceId('Microsoft.Network/loadBalancers', variables('loadBalancerName'))]"
  },
  "resources": [
    {
      "apiVersion": "2018-02-01",
      "type": "Microsoft.Storage/storageAccounts",
      "name": "[variables('storageAccountName')]",
      "location": "[parameters('location')]",
      "kind": "Storage",
      "sku": {
        "name": "[variables('storageAccountType')]"
      }
    },
    {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Compute/availabilitySets",
      "location": "[parameters('location')]",
      "name": "[variables('availabilitySetName')]",
      "properties": {
        "PlatformUpdateDomainCount": 2,
        "PlatformFaultDomainCount": 2
      },
      "sku": {
        "name": "Aligned"
      }
    },
    {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Network/virtualNetworks",
      "name": "[variables('virtualNetworkName')]",
      "location": "[parameters('location')]",
      "properties": {
        "addressSpace": {
          "addressPrefixes": [
            "10.0.0.0/16"
          ]
        },
        "subnets": [
          {
            "name": "[variables('subnetName')]",
            "properties": {
              "addressPrefix": "10.0.2.0/24"
            }
          }
        ]
      }
    },
    {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Network/networkInterfaces",
      "name": "[concat(variables('networkInterfaceName'), copyindex())]",
      "location": "[parameters('location')]",
      "copy": {
        "name": "nicLoop",
        "count": "[variables('numberOfInstances')]"
      },
      "dependsOn": [
        "[variables('virtualNetworkName')]",
        "[variables('loadBalancerName')]"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipconfig1",
            "properties": {
              "privateIPAllocationMethod": "Dynamic",
              "subnet": {
                "id": "[variables('subnetRef')]"
              },
              "loadBalancerBackendAddressPools": [
                {
                  "id": "[concat(variables('lbID'), '/backendAddressPools/BackendPool1')]"
                }
              ]
            }
          }
        ]
      }
    },
    {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Network/loadBalancers",
      "name": "[variables('loadBalancerName')]",
      "location": "[parameters('location')]",
      "dependsOn": [
        "[variables('virtualNetworkName')]"
      ],
      "properties": {
        "frontendIPConfigurations": [
          {
            "properties": {
              "subnet": {
                "id": "[variables('subnetRef')]"
              },
              "privateIPAddress": "10.0.2.6",
              "privateIPAllocationMethod": "Static"
            },
            "name": "LoadBalancerFrontend"
          }
        ],
        "backendAddressPools": [
          {
            "name": "BackendPool1"
          }
        ],
        "loadBalancingRules": [
          {
            "properties": {
              "frontendIPConfiguration": {
                "id": "[concat(resourceId('Microsoft.Network/loadBalancers', variables('loadBalancerName')), '/frontendIpConfigurations/LoadBalancerFrontend')]"
              },
              "backendAddressPool": {
                "id": "[concat(resourceId('Microsoft.Network/loadBalancers', variables('loadBalancerName')), '/backendAddressPools/BackendPool1')]"
              },
              "probe": {
                "id": "[concat(resourceId('Microsoft.Network/loadBalancers', variables('loadBalancerName')), '/probes/lbprobe')]"
              },
              "protocol": "Tcp",
              "frontendPort": 80,
              "backendPort": 80,
              "idleTimeoutInMinutes": 15
            },
            "Name": "lbrule"
          }
        ],
        "probes": [
          {
            "properties": {
              "protocol": "Tcp",
              "port": 80,
              "intervalInSeconds": 15,
              "numberOfProbes": 2
            },
            "name": "lbprobe"
          }
        ]
      }
    },
    {
      "apiVersion": "2018-04-01",
      "type": "Microsoft.Compute/virtualMachines",
      "name": "[concat(parameters('vmNamePrefix'), copyindex())]",
      "copy": {
        "name": "virtualMachineLoop",
        "count": "[variables('numberOfInstances')]"
      },
      "location": "[parameters('location')]",
      "dependsOn": [
        "[variables('storageAccountName')]",
        "nicLoop",
        "[variables('availabilitySetName')]"
      ],
      "properties": {
        "availabilitySet": {
          "id": "[resourceId('Microsoft.Compute/availabilitySets',variables('availabilitySetName'))]"
        },
        "hardwareProfile": {
          "vmSize": "Standard_DS2_V2"
        },
        "osProfile": {
          "computerName": "[concat(parameters('vmNamePrefix'), copyIndex())]",
          "adminUsername": "[parameters('adminUsername')]",
          "adminPassword": "[parameters('adminPassword')]"
        },
        "storageProfile": {
          "imageReference": {
            "publisher": "MicrosoftWindowsServer",
            "offer": "WindowsServer",
            "sku": "2016-Datacenter",
            "version": "latest"
          },
          "osDisk": {
            "createOption": "FromImage"
          }
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(variables('networkInterfaceName'), copyindex()))]"
            }
          ]
        },
        "diagnosticsProfile": {
          "bootDiagnostics": {
            "enabled": true,
            "storageUri": "[reference(variables('storageAccountName')).primaryEndpoints.blob]"
          }
        }
      }
    }
  ]
}
```
> Note: A common occurence of merge conflicts when working with Json objects can come down to how we individually author these files. Two versions of the same file, with the Json arranged differently may both be perfectly valid and will deploy just fine, but Git won't be able to tell that; it just knows the file has diverged, and it won't know how to auto fix it. To reduce the occurrences of this, I suggest teams use a VS Code extension called Json Tools. It will sort the Json file alphabetically, and 'prettify' it for you.

4. Let's stage our changes and commit them.

```
git add -A
git commit -m "adding new template"
```

Now we we have added our template, we should merge our feature1 branch into our local master branch. Look at the files on the left hand file explorer. You should see your newly created azuredeploy2.json alongside our original two files.

5. We are going to switch back to main branch now:

```
git checkout master
```

Notice how our azuredeploy2.json file disappears from our file explorer? That's because our master branch isn't aware of any changes we made to our feature branch.

![checkout branch](/images/Step20.png)

6. Now, let's perform a merge. We shouldn't encounter any conflicts, as all we did in our feature branch was to add a file.

```
git merge feature1
```

7. You should see a successful merge message. Once we have sucessfully merged our feature1 branch into our master branch, all that's left to do is delete the feature1 branch:

```
git branch -d feature1
```

8. Push our changes to the remote repo:

```
git push
```

In this exercise, we created a local branch in which to implement a new feature. We then merged that branch with our master branch, and deleted the feature1 branch. This is one way to isolate the development of new features from your master branch.

Let's try something different. In the next exercise, we are doing to create a new feature branch in our Azure DevOps repo. We will then enforce a policy on our master branch that forbids pushing directly to it. This is a great way of protecting our code base, and it means all changes that are merged into it must be reviewed first.

We will then switch branches in our local repo to add another new template, and push those changes to the remote feature repo. From there, we can review the commits and initiate a pull request, to merge into master.

It sounds like a lot, so let's get started!

# Protecting and working with remote branches

1. Select 'Branches' from under the Repos tab on the left hand side. You will see a master branch - click on the ellipsis to open the action menu, and select 'Branch policies'.

![project settings](/images/Step21.png)

2. Under 'Protect this branch' make sure you select checkboxes as per the below picture, then save your changes. 

![project settings](/images/Step22.png)

> Note: Usually we would never allow users to approve their own changes but, as this is a hands on lab, and we are a team of one, we can go ahead and check it. 

3. Navigate back to your Branches under the Repos tab. Click 'New Branch' and call it feature1:

![create branch](/images/Step23.png)

Great - we now have a feature branch which is currently identical to our master branch. Let's check it out.

4. Head back to VSCode, and type the following into your terminal:

```
git branch
```

5. You should see only one branch in the output; master. We need to fetch the latest changes from our remote repo. Let's do that with:

```
git pull
```

You will see that our local git repo is now aware of the remote feature1 branch.

![feature branch](/images/Step24.png)

6. Type the following: 

```
git branch -a
git checkout feature1
```

The first command shows us a list of local and remote branches. The second command checks out feature1.

![feature branch](/images/Step25.png)

7. Type git branch to verify that we are working with the feature1 branch:

```
git branch
```
You should see the following:

![feature branch](/images/Step26.png)

Now, let's make some changes!

8. As before, in VSCode, create a new file in the file explorer on the right; call it azuredeploy3.json.

9. Copy the below code and save:

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "existingVNETName": {
            "type": "string",
            "metadata": {
                "description": "Existing VNET that contains the domain controller"
            }
        },
        "existingSubnetName": {
            "type": "string",
            "metadata": {
                "description": "Existing subnet that contains the domain controller"
            }
        },
        "dnsLabelPrefix": {
            "type": "string",
            "metadata": {
                "description": "Unique public DNS prefix for the deployment. The fqdn will look something like '<dnsname>.westus.cloudapp.azure.com'. Up to 62 chars, digits or dashes, lowercase, should start with a letter: must conform to '^[a-z][a-z0-9-]{1,61}[a-z0-9]$'."
            }
        },
        "vmSize": {
            "type": "string",
            "defaultValue": "Standard_A2",
            "metadata": {
                "description": "The size of the virtual machines"
            }
        },
        "domainToJoin": {
            "type": "string",
            "metadata": {
                "description": "The FQDN of the AD domain"
            }
        },
        "domainUsername": {
            "type": "string",
            "metadata": {
                "description": "Username of the account on the domain"
            }
        },
        "domainPassword": {
            "type": "securestring",
            "metadata": {
                "description": "Password of the account on the domain"
            }
        },
        "ouPath": {
            "type": "string",
            "defaultValue": "",
            "metadata": {
                "description": "Specifies an organizational unit (OU) for the domain account. Enter the full distinguished name of the OU in quotation marks. Example: \"OU=testOU; DC=domain; DC=Domain; DC=com\""
            }
        },
        "domainJoinOptions": {
            "type": "int",
            "defaultValue": 3,
            "metadata": {
                "description": "Set of bit flags that define the join options. Default value of 3 is a combination of NETSETUP_JOIN_DOMAIN (0x00000001) & NETSETUP_ACCT_CREATE (0x00000002) i.e. will join the domain and create the account on the domain. For more information see https://msdn.microsoft.com/en-us/library/aa392154(v=vs.85).aspx"
            }
        },
        "vmAdminUsername": {
            "type": "string",
            "metadata": {
                "description": "The name of the administrator of the new VM and the domain. Exclusion list: 'admin','administrator"
            }
        },
        "vmAdminPassword": {
            "type": "securestring",
            "metadata": {
                "description": "The password for the administrator account of the new VM and the domain"
            }
        },
        "location": {
            "type": "string",
            "defaultValue": "[resourceGroup().location]",
            "metadata": {
                "description": "Location for all resources."
            }
        }
    },
    "variables": {
        "storageAccountName": "[concat(uniquestring(resourceGroup().id, deployment().name))]",
        "imagePublisher": "MicrosoftWindowsServer",
        "imageOffer": "WindowsServer",
        "windowsOSVersion": "2016-Datacenter",
        "nicName": "[concat(parameters('dnsLabelPrefix'),'Nic')]",
        "publicIPName": "[concat(parameters('dnsLabelPrefix'),'Pip')]",
        "subnetId": "[resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks/subnets', parameters('existingVNETName'), parameters('existingSubnetName'))]"
    },
    "resources": [
        {
            "apiVersion": "2015-06-15",
            "type": "Microsoft.Network/publicIPAddresses",
            "name": "[variables('publicIPName')]",
            "location": "[parameters('location')]",
            "properties": {
                "publicIPAllocationMethod": "Dynamic",
                "dnsSettings": {
                    "domainNameLabel": "[parameters('dnsLabelPrefix')]"
                }
            }
        },
        {
            "apiVersion": "2015-06-15",
            "type": "Microsoft.Storage/storageAccounts",
            "name": "[variables('storageAccountName')]",
            "location": "[parameters('location')]",
            "properties": {
                "accountType": "Standard_LRS"
            }
        },
        {
            "apiVersion": "2015-06-15",
            "type": "Microsoft.Network/networkInterfaces",
            "name": "[variables('nicName')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/publicIPAddresses/', variables('publicIPName'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', variables('publicIPName'))]"
                            },
                            "subnet": {
                                "id": "[variables('subnetId')]"
                            }
                        }
                    }
                ]
            }
        },
        {
            "apiVersion": "2017-03-30",
            "type": "Microsoft.Compute/virtualMachines",
            "name": "[parameters('dnsLabelPrefix')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts',variables('storageAccountName'))]",
                "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[parameters('vmSize')]"
                },
                "osProfile": {
                    "computerName": "[parameters('dnsLabelPrefix')]",
                    "adminUsername": "[parameters('vmAdminUsername')]",
                    "adminPassword": "[parameters('vmAdminPassword')]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "[variables('imagePublisher')]",
                        "offer": "[variables('imageOffer')]",
                        "sku": "[variables('windowsOSVersion')]",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "[concat(parameters('dnsLabelPrefix'),'_OsDisk')]",
                        "caching": "ReadWrite",
                        "createOption": "FromImage"
                    },
                    "dataDisks": [
                        {
                            "name": "[concat(parameters('dnsLabelPrefix'),'_dataDisk1')]",
                            "caching": "None",
                            "createOption": "Empty",
                            "diskSizeGB": "1000",
                            "lun": 0
                        }
                    ]
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]"
                        }
                    ]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": "true",
                        "storageUri": "[reference(concat('Microsoft.Storage/storageAccounts/', variables('storageAccountName')), '2015-06-15').primaryEndpoints.blob]"
                    }
                }
            }
        },
        {
            "apiVersion": "2015-06-15",
            "type": "Microsoft.Compute/virtualMachines/extensions",
            "name": "[concat(parameters('dnsLabelPrefix'),'/joindomain')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Compute/virtualMachines/', parameters('dnsLabelPrefix'))]"
            ],
            "properties": {
                "publisher": "Microsoft.Compute",
                "type": "JsonADDomainExtension",
                "typeHandlerVersion": "1.3",
                "autoUpgradeMinorVersion": true,
                "settings": {
                    "Name": "[parameters('domainToJoin')]",
                    "OUPath": "[parameters('ouPath')]",
                    "User": "[concat(parameters('domainToJoin'), '\\', parameters('domainUsername'))]",
                    "Restart": "true",
                    "Options": "[parameters('domainJoinOptions')]"
                },
                "protectedSettings": {
                    "Password": "[parameters('domainPassword')]"
                }
            }
        }
    ]
}
```

10. Stage your changes using either the GUI or the terminal, then commit and push them. As a reminder:

```
git add -A
git commit -m "adding new template"
git push
```

11. You will notice in the output of the terminal that our changes got pushed to feature1 branch. Let's head on over to the Azure DevOps portal.

12. Under files, you can see that our new templates doesnt exist in our master repo. Select feature1 instead, and you will see our newly created file.

![feature branch](/images/Step27.png)

13. Next, head to the Branches section again under Repos. You will see both our branches - notice that our feature1 branch is now ahead of our master branch (in my case, by two commits). Let's create a pull request to merge my changes into master.

![feature branch](/images/Step28.png)

14. Give it a title and something descriptive that describes what you are attempting to merge into the master branch. Additionally, scroll down to see the changes that will be made. You can even see a side-by-side view to compare. 

![pull request](/images/Step29.png)

![side by side diff](/images/Step30.png)

15. Once you have created the pull request, you need to approve it, and then complete it. Follow the pictures below to do this. We can delete feature1 branch once we complete the merge, as it is not necessary to keep it around. 

![approve](/images/Step31.png)
![approve](/images/Step32.png)

16. Go back to VSCode and type the following into your terminal to swich branches:

```
git checkout master
```

17. You will see the files in your explorer on the left change again, and azuredeploy3.json will be missing. That's normal - we need to pull down the latest version of our master branch.

```
git pull
```

18. There it is! All the changes we made in our feature1 branch are now reflected in master. Let's remove out local feature1 branch:

```
git branch -d feature1
```

That's it! This was a whirlwind tour of the most common Git commands when pushing and pulling code from a remote repo. We also looked at protecting branches in Azure DevOps, as well as merging feature branches into master. Hopefully you're now beter equipped to work collaboratively with Git.

