#$extension     = 'gd'
#$extensionName = 'Gd'
#$iconFile      = 'GuiDefinition.ico'
#$description   ='GUI Definition'

$extension     = 'pos'
$extensionName = 'Pos'
$iconFile      = 'PosTemplate.ico'
$description   ='POS Template'

$template='
    <!-- $extensionName File-->
    <Component Id="FileTypes.$extensionName" Guid="$([Guid]::NewGuid())">
        <File Id="$iconFile" Name="$iconFile" Source="Icons\$iconFile" />

         <RegistryKey Id="Reg.Extn.$extensionName" Root="HKCR" Key=".$extension" ForceCreateOnInstall="yes">
          <RegistryValue Id="Reg.Extn.$extensionName.Value" Value="VisualStudio.$extension" Type="string" />
          <RegistryValue Id="Reg.Extn.$extensionName.ContentType" Name="Content Type"  Value="text/plain" Type="string" />
        </RegistryKey>

        <RegistryKey Id="Reg.Class$extensionName" Root="HKCR" Key="VisualStudio.$extension" ForceCreateOnInstall="yes">
          <RegistryValue Id="Reg.Class$extensionName.Value" Value="$description" Type="string" />
          <RegistryValue Id="Reg.Class$extensionName.Icon" Key="DefaultIcon" Value="[#$iconFile]" Type="string" />
          <RegistryKey Id="Reg.Class$extensionName.Shell" Key="Shell" ForceCreateOnInstall="yes">
            <RegistryKey Id="Reg.Class$extensionName.Shell.Open" Key="Open" ForceCreateOnInstall="yes">
              <RegistryKey Id="Reg.Class$extensionName.Shell.Open.Command" Key="Command" ForceCreateOnInstall="yes">
                <RegistryValue Id="Reg.Class$extensionName.Shell.Open.Command.Value" Value="[DEVENV] /dde &quot;%1&quot;" Type="string" />
              </RegistryKey>
              <RegistryKey Id="Reg.Class$extensionName.Shell.Open.ddeexec" Key="ddeexec" ForceCreateOnInstall="yes">
                <RegistryValue Id="Reg.Class$extensionName.Shell.Open.ddeexec.Value" Value="Open(&quot;%1&quot;)" Type="string" />
                <RegistryKey Id="Reg.Class$extensionName.Shell.Open.ddeexec.Application" Key="Application" ForceCreateOnInstall="yes">
                  <RegistryValue Id="Reg.Class$extensionName.Shell.Open.ddeexec.Application.Value" Value="[DEVPROGID]" Type="string" />
                </RegistryKey>
                <RegistryKey Id="Reg.Class$extensionName.Shell.Open.ddeexec.Topic" Key="Topic" ForceCreateOnInstall="yes">
                  <RegistryValue Id="Reg.Class$extensionName.Shell.Open.ddeexec.Topic.Value" Value="system" Type="string" />
                </RegistryKey>
              </RegistryKey>
            </RegistryKey>            
          </RegistryKey>          
        </RegistryKey>      
      </Component>'

      $ExecutionContext.InvokeCommand.ExpandString($template) 