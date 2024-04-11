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
        var resourceGroup = new ResourceGroup("rg", new ResourceGroupArgs
        {
            ResourceGroupName = "iac-demo3-pulumi-rg",
        });

        var appServicePlan = new AppServicePlan("asp", new AppServicePlanArgs
        {
            Name = "iac-demo3-pulumi-plan",
            ResourceGroupName = resourceGroup.Name,
            Kind = "App",
            Sku = new SkuDescriptionArgs
            {
                Tier = "Basic",
                Name = "B1",
            },
        });

        //Console.WriteLine("Test message to see in the pulumi output.");

        var random = new Random.RandomString("random", new()
        {
            Length = 4,
            Special = false,
            Upper = false,
            Lower = true,
        });

        var appName = random.Result.Apply(rnd => $"iac-demo3-pulumi-{rnd}-webapp");

        var app = new WebApp("app", new WebAppArgs
        {
            Name = appName,
            ResourceGroupName = resourceGroup.Name,
            ServerFarmId = appServicePlan.Id,
        });

        this.Endpoint = app.DefaultHostName;
    }

    [Output] public Output<string> Endpoint { get; set; }
}