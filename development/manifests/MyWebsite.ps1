Configuration MyWebsite
{
  param ($MachineName)

  Import-DscResource -Module MyWebapp
  Import-DscResource -Module cNetworking

  Node $MachineName
  {
    WindowsFeature IIS
    {
        Ensure = "Present"
        Name = "Web-Server"
    }

    WindowsFeature IISManagerFeature
    {
        Ensure = "Present"
        Name = "Web-Mgmt-Tools"
    }    

    cFirewallRule webFirewall
    {
        Name = "WebFirewallOpen"
        Direction = "Inbound"
        LocalPort = "80"
        Protocol = "TCP"
        Action = "Allow"
        Ensure = "Present"   
    }

    SimpleWebsite sWebsite
    {
        WebAppPath = "c:\my-new-webapp"
        DependsOn  = '[cWebsite]DefaultWebsite'
    }    
  }
}