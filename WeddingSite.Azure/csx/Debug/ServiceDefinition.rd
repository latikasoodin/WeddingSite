<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="WeddingSite.Azure" generation="1" functional="0" release="0" Id="a8f4be57-d735-4b10-948d-52b3ef164a7c" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="WeddingSite.AzureGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="WeddingSite:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/LB:WeddingSite:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="WeddingSite:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/MapWeddingSite:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WeddingSiteInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/MapWeddingSiteInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:WeddingSite:Endpoint1">
          <toPorts>
            <inPortMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSite/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapWeddingSite:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSite/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWeddingSiteInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSiteInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="WeddingSite" generation="1" functional="0" release="0" software="C:\latika\WeddingSite\WeddingSite.Azure\csx\Debug\roles\WeddingSite" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WeddingSite&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WeddingSite&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSiteInstances" />
            <sCSPolicyUpdateDomainMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSiteUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSiteFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="WeddingSiteUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="WeddingSiteFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="WeddingSiteInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="3df012b2-bc71-466c-be90-9f3193e6a874" ref="Microsoft.RedDog.Contract\ServiceContract\WeddingSite.AzureContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="d9abc1d5-99db-4d6c-8208-dd6044ec3a24" ref="Microsoft.RedDog.Contract\Interface\WeddingSite:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/WeddingSite.Azure/WeddingSite.AzureGroup/WeddingSite:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>