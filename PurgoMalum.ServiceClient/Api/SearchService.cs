using System;
using System.Collections.Generic;
using System.Net;
using System.Xml;
using PurgoMalum.ServiceClient.Model;
using RestSharp;

namespace PurgoMalum.ServiceClient
{
    public class SearchService : ISearchService
    {
        private IRestResponse response;

        public SearchService(ApiClient apiClient = null)
        {
            if (apiClient == null) // use the default one in Configuration
                this.ApiClient = Configuration.DefaultApiClient;
            else
                this.ApiClient = apiClient;
        }

        public SearchService(string basePath)
        {
            this.ApiClient = new ApiClient(basePath);
        }

        public void SetBasePath(string basePath)
        {
            this.ApiClient.BasePath = basePath;
        }

        public string GetBasePath()
        {
            return this.ApiClient.BasePath;
        }

        public ApiClient ApiClient { get; set; }

        public HttpStatusCode StatusCode => response.StatusCode;

        private readonly Dictionary<string, string> queryParams = new Dictionary<string, string>();
        private readonly Dictionary<string, string> headerParams = new Dictionary<string, string>();
        private readonly Dictionary<string, string> formParams = new Dictionary<string, string>();
        private readonly Dictionary<string, FileParameter> fileParams = new Dictionary<string, FileParameter>();
        private readonly string postBody = null;


        public string GetSearchResult(string responseType, string text,
             string replacementText = null, string replacementChar = null, string add = null)
        {
            queryParams.Clear();

            var path = $"/{responseType}";

            if (text != null) queryParams.Add("text", ApiClient.ParameterToString(text));

            if (!string.IsNullOrEmpty(replacementText)) queryParams.Add("fill_text", ApiClient.ParameterToString(replacementText));

            if (!string.IsNullOrEmpty(replacementChar)) queryParams.Add("fill_char", ApiClient.ParameterToString(replacementChar));

            if (!string.IsNullOrEmpty(add)) queryParams.Add("add", ApiClient.ParameterToString(add));

            response = (IRestResponse)ApiClient.CallApi(path, Method.GET, queryParams, postBody, headerParams, formParams, fileParams);

            if (((int)response.StatusCode) >= 400)
                throw new ApiException((int)response.StatusCode, $"{response.StatusCode}, Error calling Search: " + response.Content, response.ErrorMessage);
            else if ((response.StatusCode) == 0)
                throw new ApiException((int)response.StatusCode, $"{response.StatusCode}, Error calling Search: " + response.Content, response.ErrorMessage);

            SearchResponse searchResponse = new SearchResponse();
            if (response.ContentType == "application/json")
            {
                searchResponse = (SearchResponse)ApiClient.Deserialize(response.Content, typeof(SearchResponse), response.Headers);
                return !string.IsNullOrEmpty(searchResponse.Result) ? searchResponse.Result : searchResponse.Error;
            }
            else if (response.ContentType == "application/xml")
                return ApiClient.SerializeXml(response.Content);
            else
                return response.Content;

        }
    }
}
