# Vagrant DSC Plugin

[![Build Status](https://travis-ci.org/mefellows/vagrant-dsc.svg)](https://travis-ci.org/mefellows/vagrant-dsc)
[![Coverage Status](https://coveralls.io/repos/mefellows/vagrant-dsc/badge.png?branch=master)](https://coveralls.io/r/mefellows/vagrant-dsc?branch=master)
[![Gem Version](https://badge.fury.io/rb/vagrant-dsc.svg)](http://badge.fury.io/rb/vagrant-dsc)

[Desired State Configuration](http://technet.microsoft.com/en-au/library/dn249912.aspx) provisioning plugin for Vagrant, enabling you to quickly configure & bootstrap a Windows Virtual Machine in a repeatable, reliable fashion - the Vagrant way.

.NET Devs - no more excuses...

> But it works on my machine!?

...is a thing of the past

## Installation

```vagrant plugin install vagrant-dsc```

## Usage

In your Vagrantfile, add the following plugin and configure to your needs:

```ruby
  config.vm.provision "dsc" do |dsc|
  
    # The path relative to `dsc.manifests_path` pointing to the Configuration file
    dsc.configuration_file  = "MyWebsite.ps1"

    # The Configuration Command to run. Assumed to be the same as the `dsc.configuration_file`
    # (sans extension) if not provided.
    dsc.configuration_name = "MyWebsite"

    # Commandline arguments to the Configuration run
    # Set of Parameters to pass to the DSC Configuration.
    #
    # To pass in flags, simply set the value to `nil`
    dsc.configuration_params = {"-MachineName" => "localhost", "-EnableDebug" => nil}

    # A path relative to the Vagrantfile pointing to a Configuration Data file.
    #
    # See https://technet.microsoft.com/en-us/library/dn249925.aspx for details
    # on how to parameterise your Configuration files.
    dsc.configuration_data_file  = "manifests/MyConfig.psd1"

    # Relative path to a folder containing a pre-generated MOF file.
    #
    # Path is relative to the folder containing the Vagrantfile.
    dsc.mof_path = "mof_output"

    # Relative path to the folder containing the root Configuration manifest file.
    # Defaults to 'manifests'.
    #
    # Path is relative to the folder containing the Vagrantfile.
    dsc.manifests_path = "manifests"

    # Set of module paths relative to the Vagrantfile dir.
    #
    # These paths are added to the DSC Configuration running
    # environment to enable local modules to be addressed.
    #
    # @return [Array] Set of relative module paths.
    dsc.module_path = ["manifests", "modules"]

    # The type of synced folders to use when sharing the data
    # required for the provisioner to work properly.
    #
    # By default this will use the default synced folder type.
    # For example, you can set this to "nfs" to use NFS synced folders.
    dsc.synced_folder_type = "nfs"

    # Temporary working directory on the guest machine.
    dsc.temp_dir = "/tmp/vagrant-dsc"
  end
```
## Example

There is a [sample](https://github.com/mefellows/vagrant-dsc/tree/master/development) Vagrant setup used for development of this plugin. 
This is a great real-life example to get you on your way.

## Creating Windows Vagrant boxes

Look at some example Packer templates [here](https://github.com/mefellows/packer-windows-templates/).

## Roadmap

* Support DSC Pull Server provisioning
* Test (dry-run) a DSC Configuration Run with 'vagrant vagrant-dsc test'
* Support for non-Windows environments

### Supported Environments

Currently the plugin only supports modern Windows environments with DSC installed (Windows 8.1+, Windows Server 2012 R2+ are safe bets).
The plugin works on older platforms that have a later version of .NET (4.5) and the WMF 4.0 installed.

As a general guide, configuring your Windows Server

From the [DSC Book](https://onedrive.live.com/view.aspx?cid=7F868AA697B937FE&resid=7F868AA697B937FE!156&app=Word):

> **DSC Overview and Requirements**
> Desired State Configuration (DSC) was first introduced as part of Windows Management Framework (WMF) 4.0, which is preinstalled in Windows 8.1 and Windows Server 2012 R2, and is available for Windows 7, Windows Server 2008 R2, and Windows Server 2012. Because Windows 8.1 is a free upgrade to Windows 8, WMF 4 is not available for Windows 8.
> You must have WMF 4.0 on a computer if you plan to author configurations there. You must also have WMF 4.0 on any computer you plan to manage via DSC. Every computer involved in the entire DSC conversation must have WMF 4.0 installed. Period. Check $PSVersionTable in PowerShell if you’re not sure what version is installed on a computer.
> On Windows 8.1 and Windows Server 2012 R2, make certain that KB2883200 is installed or DSC will not work. On Windows Server 2008 R2, Windows 7, and Windows Server 2008, be sure to install the full Microsoft .NET Framework 4.5 package prior to installing WMF 4.0 or DSC may not work correctly.

We may consider automatically installing and configuring DSC in a future release of the plugin.

## Uninistallation

```vagrant plugin uninstall vagrant-dsc```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/vagrant-dsc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Squash commits & push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
