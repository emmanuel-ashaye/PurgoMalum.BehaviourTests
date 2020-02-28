using System;
using BoDi;
using Microsoft.Extensions.Configuration;
using PurgoMalum.ServiceClient;
using TechTalk.SpecFlow;

namespace AlphaFX.BankValidation.BehaviourTests.Binding
{
    [Binding]
    public class ContainerSetupBindings
    {

        private string _baseUrl;

        private readonly IConfiguration _configuration;

        private readonly IObjectContainer _container;

        public ContainerSetupBindings(IObjectContainer container)
        {
            _container = container;
            _configuration = GetConfiguration();
        }

        private static IConfiguration GetConfiguration()
        {
            var builder = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json");

            return builder.Build();
        }

        [BeforeScenario]
        public void SetupContaienerBindings()
        {
            _baseUrl = _configuration["ApplicationBaseUrl"];

            ISearchService _searchService = new SearchService(_baseUrl);
            _container.RegisterInstanceAs(_searchService);
        }
    }
}
