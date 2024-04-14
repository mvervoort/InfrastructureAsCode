// Copyright 2016-2021, Pulumi Corporation.  All rights reserved.

using System;
using Pulumi;
using Pulumi.AzureNative.Insights;
using Pulumi.AzureNative.OperationalInsights;
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Sql;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;
using Pulumi.AzureNative.Web;
using Pulumi.AzureNative.Web.Inputs;
using Random = Pulumi.Random;

class AppServiceStack : Stack
{
    public AppServiceStack()
    {
        // Get the name of the current stack. E.g. 'dev', 'test', 'prod'.
        var stack = Pulumi.Deployment.Instance.StackName;

        // Get the configuration settings for the current stack.
        var config = new Pulumi.Config();
        var sku = config.Get("sku") ?? "B1";
        var dotnet_version = config.Get("dotnet_version") ?? "8.0";

        // Calculated variables
        var baseNameWithEnvironment = $"iac-demo3-pulumi-{stack}";

        // Create an Azure Resource Group
        var resourceGroup = new ResourceGroup("rg", new ResourceGroupArgs
        {
            ResourceGroupName = $"{baseNameWithEnvironment}-rg",
        });

        // Create an App Service Plan
        var appServicePlan = new AppServicePlan("asp", new AppServicePlanArgs
        {
            Name = $"{baseNameWithEnvironment}-plan",
            ResourceGroupName = resourceGroup.Name,
            Kind = "Linux",
            Reserved = true,
            Sku = new SkuDescriptionArgs
            {
                Tier = "Basic",
                Name = sku,
                Capacity = 1
            },
        });


        // Create a Linux App Service
        var random = new Random.RandomString("random", new Random.RandomStringArgs()
        {
            Length = 4,
            Special = false,
            Upper = false,
            Lower = true,
        });

        var appName = random.Result.Apply(rnd => $"{baseNameWithEnvironment}-{rnd}-webapp");
        
        var app = new WebApp("app", new WebAppArgs
        {
            Name = appName,
            ResourceGroupName = resourceGroup.Name,
            ServerFarmId = appServicePlan.Id,
            SiteConfig = new SiteConfigArgs
            {
                AlwaysOn = true,
                LinuxFxVersion = $"DOTNETCORE:{dotnet_version}",
            },

        });

        this.Endpoint = app.DefaultHostName;
    }

    [Output] public Output<string> Endpoint { get; set; }
}