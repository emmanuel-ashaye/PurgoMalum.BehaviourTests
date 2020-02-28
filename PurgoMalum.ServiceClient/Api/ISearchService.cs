using System;

namespace PurgoMalum.ServiceClient
{
    public interface ISearchService
    {
        string GetSearchResult(string responseType, string text,
             string replacementText = null, string replacementChar = null, string add = null);
    }
}
