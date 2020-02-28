using System;
using System.Collections.Generic;
using System.Net;
using RestSharp;

namespace PurgoMalum.ServiceClient
{
    public class SearchService : ISearchService
    {
        private IRestResponse response;

        /// <summary>
        /// Initializes a new instance of the <see cref="CounterpartyApi"/> class.
        /// </summary>
        /// <param name="apiClient"> an instance of ApiClient (optional)</param>
        /// <returns></returns>
        public SearchService(ApiClient apiClient = null)
        {
            if (apiClient == null) // use the default one in Configuration
                this.ApiClient = Configuration.DefaultApiClient;
            else
                this.ApiClient = apiClient;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="CounterpartyApi"/> class.
        /// </summary>
        /// <returns></returns>
        public SearchService(string basePath)
        {
            this.ApiClient = new ApiClient(basePath);
        }

        /// <summary>
        /// Sets the base path of the API client.
        /// </summary>
        /// <param name="basePath">The base path</param>
        /// <value>The base path</value>
        public void SetBasePath(string basePath)
        {
            this.ApiClient.BasePath = basePath;
        }

        /// <summary>
        /// Gets the base path of the API client.
        /// </summary>
        /// <param name="basePath">The base path</param>
        /// <value>The base path</value>
        public string GetBasePath(string basePath)
        {
            return this.ApiClient.BasePath;
        }

        /// <summary>
        /// Gets or sets the API client.
        /// </summary>
        /// <value>An instance of the ApiClient</value>
        public ApiClient ApiClient { get; set; }

        public HttpStatusCode StatusCode => response.StatusCode;

        private readonly Dictionary<string, string> queryParams = new Dictionary<string, string>();
        private readonly Dictionary<string, string> headerParams = new Dictionary<string, string>();
        private readonly Dictionary<string, string> formParams = new Dictionary<string, string>();
        private readonly Dictionary<string, FileParameter> fileParams = new Dictionary<string, FileParameter>();
        private string postBody = null;

        /// <summary>
        /// Get list of supported currency pairs 
        /// </summary>
        /// <param name="ccy">Required currency code filter</param> 
        /// <returns>List&lt;CurrencyPair&gt;</returns>            
        public string GetSearchResult(string responseType, string text,
             string replacementText = null, string replacementChar = null, string add = null)
        {
            queryParams.Clear();

            var path = $"/{responseType}";

            if (text != null) queryParams.Add("text", ApiClient.ParameterToString(text));

            if (!string.IsNullOrEmpty(replacementText)) queryParams.Add("fill_text", ApiClient.ParameterToString(replacementText));

            if (!string.IsNullOrEmpty(replacementChar)) queryParams.Add("fill_char", ApiClient.ParameterToString(replacementChar));

            if (!string.IsNullOrEmpty(add)) queryParams.Add("add", ApiClient.ParameterToString(add));

            // make the HTTP request
            response = (IRestResponse)ApiClient.CallApi(path, Method.GET, queryParams, postBody, headerParams, formParams, fileParams);

            if (((int)response.StatusCode) >= 400)
                throw new ApiException((int)response.StatusCode, $"{response.StatusCode}, Error calling Search: " + response.Content, response.ErrorMessage);
            else if (((int)response.StatusCode) == 0)
                throw new ApiException((int)response.StatusCode, $"{response.StatusCode}, Error calling Search: " + response.Content, response.ErrorMessage);

            return (string)ApiClient.Deserialize(response.Content, typeof(string), response.Headers);
        }
    }
}
