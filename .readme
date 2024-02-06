**Recap**

Part 1

- Covered basics of JSON
- JSON Schemas
- Editing with VS Code
- Azure CLI/PowerShell
- ARM Templates

Part 2

- Template quick starts
- Template specs
- Template spec versioning
- Template spec linked templates
- Template spec deployment from DevOps

Part 3

- Bicep / Why use IaaC?
- Bicep vs. ARM
- Bicep Parameters
- Loops / Conditionals / etc

Part 4 

- Bicep to Repo to Azure
- Azure Managed Applications

**Introduction** 

Requirements similar to:
-A completely custom user interface served up via the Azure Portal.
-Integration with Azure Key Vault for certain sensitive values (e.g., passwords) so that they are not displayed, and the user cannot enter.
-Enforcement and validation of naming conventions on various fields, with appropriate interactive guidance and feedback. For example, all VMs must start with the letters “VM_.”
-Limitations on certain fields (e.g., regions allowed size/family of VM, etc.).
-Forced usage of existing VNets and resource groups.
-All scripts should be contained in a private GitHub repository. (ours is public for simplicity)
-Ability to provide data via custom parameters on the portal interface that gets passed into a PowerShell script, which gets automatically invoked upon VM creation. An example would be allowing the user creating the VM to specify via a “Yes/No” parameter whether Microsoft Internet Information Services (IIS) should be installed upon VM creation.

**Custom Azure Portal Interfaces - createUiDefinition.json**

You can create a form that appears in the Azure portal to assist users in deploying a template spec. The form allows users to enter values that are passed as parameters to the template spec.

When you create the template spec, you package the form and Azure Resource Manager template (ARM template) together. Deploying the template spec through the portal automatically launches the form.

Then, we can pass both the template and createUiDefinition.json to the Azure Portal via a URL to create a custom interface for the user to deploy the template.

**Creating a form**

Reference: 
https://github.com/Azure/portaldocs/blob/main/portal-sdk/generated/dx-view-formViewType.md

Link to form view sandbox:
https://aka.ms/form/sandbox


**Azure Managed Applications**

To publish a managed application to your service catalog, do the following tasks:

- Create an Azure Resource Manager template (ARM template) that defines the resources to deploy with the managed application.
- Define the user interface elements for the portal when deploying the managed application.
- Create a .zip package that contains the required JSON files. The .zip package file has a 120-MB limit for a service catalog's managed application definition.
- Publish the managed application definition so it's available in your service catalog.

**Defining Azure Portal Experience**

The user interface (UI) definition for a managed application is defined in a JSON file. The UI definition file is named createUiDefinition.json. 

The UI definition file defines the user interface elements for the portal when deploying the managed application.

**Package the files**


